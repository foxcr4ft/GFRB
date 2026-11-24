# Baseline Técnica Complementar — Dados e Persistência 0.1

**Estado:** PROPOSTA TÉCNICA COMPLEMENTAR — NÃO APROVADA  
**Relacionamento:** complementa, não substitui, `CHARACTER_DATA_PERSISTENCE_CONTRACT_0_1.md`  
**Escopo:** fechar decisões de arquitetura reversíveis e registrar limites oficiais da plataforma antes da implementação.

> Este adendo não aprova campos de gameplay, não substitui os Documentos 12/13 e não autoriza gravar dados reais. As opções abaixo são uma proposta técnica para revisão.

## 1. Decisão de armazenamento proposta

### 1.1 Unidade de persistência

Propor **um registro agregado por conta Roblox**, contendo o índice de personagens e até três perfis individuais aninhados. A chave é derivada exclusivamente no servidor:

- DataStore: `AethermoorProfiles_DEV_v1` em ambiente de desenvolvimento e `AethermoorProfiles_PROD_v1` em produção (nomes propostos; cada um deve respeitar o limite da plataforma).
- Chave: `u:<UserId>`.
- O valor contém o envelope versionado, o estado técnico da sessão e o payload da conta.
- O payload mantém cada personagem em uma entrada separada identificada por `characterId` e `slotIndex`, sem compartilhar estado de gameplay entre personagens.

**Justificativa:** o limite de três personagens permite que criação, exclusão e cálculo de disponibilidade de slots sejam operações atômicas em uma única chave, sem transações distribuídas entre um índice e três chaves de personagem. O custo é que os perfis da mesma conta compartilham uma chave e um bloqueio de sessão. A decisão deve ser reavaliada se medições reais mostrarem contenção ou crescimento excessivo.

### 1.2 Limites e validação de tamanho

- Nome do DataStore, nome da chave e escopo devem respeitar o limite de 50 caracteres cada.
- O valor serializado por chave não pode ultrapassar 4.194.304 caracteres.
- Antes de cada gravação, serializar com `HttpService:JSONEncode()` e validar o tamanho; rejeitar a gravação com erro rastreável antes de chamar o serviço se ultrapassar o limite.
- Não truncar payload, remover itens nem descartar campos automaticamente para caber.
- Medir também o tamanho médio e o percentil alto dos perfis em testes; o limite máximo da plataforma não é uma meta de projeto.

A implementação deve consultar os limites/budgets atuais com as APIs apropriadas e evitar autosaves desnecessários. `UpdateAsync()` consome orçamento de leitura e escrita.

## 2. Payload mínimo candidato

O payload persistente inicial fica limitado ao necessário para identidade, HUB e regra de slots. A lista abaixo é **proposta**, não um catálogo de gameplay aprovado:

| Campo candidato | Finalidade | Regra |
|---|---|---|
| `ownerUserId` | Conferir propriedade da conta | Inserido e validado no servidor; deve corresponder ao jogador autenticado |
| `characterId` | Identidade estável individual | GUID gerado no servidor; não reutilizar |
| `slotIndex` | Posição do personagem | Inteiro restrito aos slots 1, 2 ou 3 |
| `classId` | Classe escolhida | Identificador estável de catálogo aprovado; valores ainda dependem do catálogo oficial |
| `presentationId` | Opção masculina/feminina escolhida | Identificador estável; não presume personalização adicional |
| `level` | Avaliar marcos de desbloqueio | Inteiro autoritativo do servidor; regra de XP/evolução permanece fora deste contrato |

Campos técnicos do envelope — `schemaVersion`, `revision`, `updatedAt` — não são dados de gameplay.

Não incluir neste primeiro payload candidato: XP, atributos, habilidades, inventário, equipamentos, Sprites, profissões, missões, moedas, reputação, preferências, nome visível ou personalização adicional. Esses domínios exigem seus contratos aprovados. O nível é listado porque os marcos 25/80 já foram decididos; a fonte e a semântica do nível ainda devem ser confrontadas com a especificação de progressão antes da implementação.

O identificador de classe, a opção de apresentação e o nível não podem ser aceitos do cliente como autoridade. O servidor valida esses valores contra o catálogo e o estado do personagem.

## 3. Regra determinística de disponibilidade dos slots

Derivar disponibilidade do estado atual dos personagens, sem um booleano permanente de desbloqueio:

- Slot 1: sempre disponível quando vazio.
- Slot 2: disponível se já estiver ocupado **ou** se ao menos um personagem existente tiver nível igual ou superior a 25.
- Slot 3: disponível se já estiver ocupado **ou** se ao menos um personagem existente tiver nível igual ou superior a 80.
- Um slot ocupado permanece disponível enquanto seu personagem existir, mesmo se o personagem que atingiu o marco for excluído.
- Ao excluir o ocupante, recalcular imediatamente. Se nenhum personagem restante cumprir o marco correspondente, o slot volta a ficar bloqueado.
- A criação só pode ocupar um slot vazio que esteja disponível no momento da operação.

Essa regra reproduz os exemplos já aprovados e evita uma flag de desbloqueio que sobreviva indevidamente à exclusão do ocupante.

## 4. Envelope e concorrência

Envelope proposto:

```text
AccountRecord
├── schemaVersion
├── revision
├── updatedAt
├── session
│   ├── jobId
│   ├── sessionToken
│   ├── lockEpoch
│   └── expiresAt
└── payload
    ├── ownerUserId
    └── characters[characterId]
        ├── slotIndex
        ├── classId
        ├── presentationId
        └── level
```

Regras:

1. Uma única sessão de servidor mantém o bloqueio da conta; todos os personagens daquela conta ficam sob o mesmo bloqueio.
2. Aquisição, renovação, salvamento e liberação são operações atômicas via `UpdateAsync()`.
3. O token é GUID gerado no servidor. `lockEpoch` é incrementado em cada aquisição válida e funciona como fencing token contra uma sessão antiga.
4. Toda gravação exige token e epoch ainda válidos; se não corresponderem, abortar sem alterar o valor.
5. A expiração usa relógio do servidor. Duração do lease, frequência de renovação, margem, timeout e quantidade/intervalo de tentativas são configurações pendentes de medição, não números fixados aqui.
6. O callback de transformação de `UpdateAsync()` deve ser puro, curto e sem operações que cedam execução (*yield*).
7. Não usar `SetAsync()` para atualizar estado compartilhado sujeito a concorrência.

## 5. Ciclo de carregamento e falha

- A sessão só chega a `READY` depois de adquirir o bloqueio, ler e validar o envelope e concluir migrações compatíveis.
- Um retorno `nil` de uma leitura bem-sucedida pode representar conta nova; erro de serviço, timeout, dado inválido ou versão futura não pode ser tratado como conta nova.
- Se a carga falhar, não criar perfil vazio, não permitir criação/exclusão de personagem e não iniciar gameplay persistente.
- A interface pode permanecer no estado de indisponibilidade/repetição ou encerrar a sessão após a política de tentativas. A experiência visual e o limite de espera são decisões de produto ainda pendentes.
- Se a sessão perder o lease, bloquear imediatamente novas mutações e gravações dessa sessão; não tentar salvar por cima da sessão proprietária.
- Uma gravação com resposta incerta deve ser verificada antes de repetir uma mutação não idempotente.

## 6. Salvamento e encerramento

- Manter estado sujo (*dirty*) e coalescer alterações seguras; salvar apenas quando houver alteração persistente.
- Autosave periódico é necessário como proteção contra saída inesperada, mas intervalo e jitter devem ser calibrados com testes e orçamento, sem número arbitrário neste adendo.
- Salvar em `PlayerRemoving` e tentar a gravação final no `BindToClose()`; nenhum deles substitui autosave.
- O encerramento do servidor Roblox aguarda até 30 segundos pelas funções de `BindToClose()`; a implementação deve trabalhar dentro desse limite e não depender de tarefas ilimitadas.
- Em erro, usar tentativas limitadas com backoff exponencial e jitter, monitorando orçamento e erros de throttling. Quantidade de tentativas e tempos são parâmetros de configuração a validar.
- Não descartar alterações não confirmadas silenciosamente. Registrar resultado técnico sem expor payload ou dados pessoais em logs.

## 7. Criação, seleção e exclusão

- A criação ocorre sob o bloqueio da conta e dentro de `UpdateAsync()`: validar slot disponível, catálogo de classe/opção, gerar `characterId` no servidor e inserir o perfil.
- A seleção no HUB apenas escolhe qual perfil carregado será usado na sessão; não precisa persistir a seleção atual neste contrato.
- A exclusão exige solicitação explícita originada no HUB e confirmação do usuário. O servidor revalida propriedade, existência do `characterId`, bloqueio da conta e revisão esperada.
- Após a confirmação validada, remover o perfil do agregado na mesma operação atômica e incrementar `revision`. A exclusão é imediata e permanente no estado ativo do jogo; não criar estado pendente, janela de espera, recurso, cancelamento ou fluxo de restauração.
- Recalcular slots na mesma transformação. Não manter dados do personagem excluído em outro registro criado por esta arquitetura.
- A política de retenção técnica imposta pela plataforma e a política de privacidade/publicação precisam ser verificadas separadamente; este contrato não promete apagamento instantâneo de históricos internos da plataforma.

## 8. Migração, recuperação e versões

- Migrações sequenciais N → N+1, determinísticas e sem *yield* dentro do callback de transformação.
- Migrar uma cópia candidata, validar o resultado e gravar apenas enquanto o servidor mantém o lease.
- Versão futura/desconhecida: falhar fechado; nunca rebaixar nem sobrescrever.
- A versionagem automática do DataStore não deve ser tratada como backup completo: a documentação informa que sucessivas gravações na mesma hora UTC podem sobrescrever a versão anterior, e versões históricas têm retenção limitada.
- Política de backup externo, retenção, restauração operacional e tratamento de exclusão de personagem precisam de decisão antes da publicação. A restauração de um personagem excluído não será oferecida como recurso de jogo.

## 9. Ambientes e proteção de dados

- Usar DataStore separado para desenvolvimento/testes e produção; nomes propostos na seção 1.1.
- Nunca habilitar acesso de API do Studio a dados de produção. O Studio pode acessar o mesmo DataStore da experiência quando a opção está habilitada.
- Testes de integração devem usar dados descartáveis e identificadores de teste; não usar contas/perfis reais.
- Não incluir chaves, tokens, credenciais ou dados pessoais desnecessários no payload.
- A chave é sempre montada pelo servidor a partir do `UserId`; nunca aceitar nome de DataStore, chave ou proprietário enviados pelo cliente.

## 10. Matriz mínima de testes

Além dos casos do contrato principal, cobrir:

1. criação de conta sem personagens versus falha de leitura;
2. limite de um, dois e três personagens;
3. desbloqueio do slot 2 no nível 25 e slot 3 no nível 80;
4. exclusão do personagem que liberou slot sem fechar slot ocupado;
5. exclusão do próprio ocupante bloqueando o slot quando nenhum personagem restante alcança o marco;
6. concorrência entre duas sessões tentando adquirir a mesma conta;
7. sessão antiga tentando gravar depois da troca do `lockEpoch`;
8. criação e exclusão concorrentes sob a mesma conta;
9. falha antes/depois de uma resposta incerta de gravação;
10. tamanho serializado no limite e acima do limite;
11. falha de migração sem sobrescrever o original;
12. versão futura desconhecida;
13. falha de serviço sem criação de perfil vazio;
14. encerramento com autosave pendente e janela limitada de `BindToClose()`;
15. teste de isolamento: dados de desenvolvimento nunca atingem o DataStore de produção.

## 11. Fontes técnicas oficiais consultadas

- Roblox Creator Hub — Data Stores: `GetAsync`, `UpdateAsync`, cache, chamadas de rede e acesso de Studio.
- Roblox Creator Hub — Data store error codes and limits: limites de 50 caracteres para nome/chave/escopo, 4.194.304 caracteres por valor e budgets/throttling.
- Roblox Creator Hub — Player data and purchasing: padrão de session locking usando `UpdateAsync()`.
- Roblox Creator Hub — DataModel: `BindToClose()` e limite de espera de 30 segundos.

As referências oficiais estão vinculadas na descrição da PR. Limites e comportamento devem ser reconfirmados na implementação, pois a plataforma pode mudar.

## 12. Pendências que este adendo não pode decidir

1. Fluxo detalhado e apresentação do HUB.
2. Personalização visual além da escolha masculina/feminina por classe.
3. Catálogo oficial de classes/IDs e semântica completa de nível/progressão.
4. Quais domínios adicionais de gameplay entram no MVP persistente.
5. Experiência exata do jogador durante indisponibilidade prolongada do DataStore.
6. Política de privacidade, retenção e requisitos de publicação.
7. Confronto com os textos integrais aprovados dos Documentos 12 e 13, ainda não recuperados no repositório.

**Resultado:** a arquitetura técnica mínima está descrita como proposta revisável. A etapa 2 continua bloqueada para implementação de produção até aprovação do contrato, resolução das dependências de produto e confronto documental quando os originais estiverem disponíveis.
