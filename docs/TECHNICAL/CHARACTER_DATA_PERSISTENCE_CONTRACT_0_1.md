# Contrato Técnico de Dados do Personagem e Persistência — Aethermoor

**Versão:** 0.1  
**Estado:** PROPOSTA TÉCNICA — NÃO APROVADA  
**Etapa do roadmap:** 2 — Contrato de dados do personagem e persistência  
**Base:** Foundation 0.1 integrada à `main`  
**Objetivo:** definir limites e requisitos técnicos antes de qualquer implementação de DataStore.

> Este documento não define atributos, progressão, classes, inventário, equipamentos, habilidades, Sprites, moedas, missões ou qualquer outro conteúdo de gameplay. Os campos persistentes desses sistemas continuam pendentes até que suas especificações aprovadas estejam disponíveis. Nenhum dado fictício deve ser gravado para preencher essas lacunas.

## 1. Escopo

Esta proposta cobre somente o contrato técnico necessário para uma futura camada de perfil persistente:

- envelope de armazenamento e identificação de versão;
- validação estrutural e integridade;
- ciclo de carregamento e disponibilização de dados;
- salvamento, concorrência de sessões e encerramento;
- tratamento de falhas e recuperação;
- migração entre versões;
- testes e critérios de aceitação.

Não implementa DataStore, não escolhe o conteúdo definitivo do perfil e não altera documentos de design aprovados.

## 2. Fontes e hierarquia

Requisitos de origem:

- Project Charter: servidor autoritativo, integridade dos dados, segurança e arquitetura modular.
- Decision Register: OPEN-015 — persistência; modelo, salvamento, recuperação e migração ainda precisam ser especificados.
- Roadmap: etapa 2 deve preceder DataStore e sistemas dependentes de personagem.
- Development Protocol: não improvisar esquema persistente ou migração; decisões técnicas reversíveis podem ser propostas, mas não se tornam decisões aprovadas automaticamente.

Se o texto integral dos Documentos 12 ou 13 vier a ser recuperado, esta proposta deverá ser comparada com ele antes da aprovação. Não se afirma que esta proposta recupera ou substitui esses documentos.

## 3. Envelope técnico proposto

A proposta separa o envelope técnico dos dados de jogo. O envelope não define o significado dos campos de gameplay.

Representação conceitual, não código executável:

```text
StoredProfile
├── schemaVersion: integer
├── revision: integer
├── updatedAt: integer (server Unix timestamp)
└── payload: object
```

Regras propostas:

- `schemaVersion` identifica a versão do formato persistido; deve ser inteiro positivo conhecido pelo servidor.
- `revision` é um contador técnico monotônico incrementado apenas em gravação confirmada; não representa nível ou progressão de jogo.
- `updatedAt` é gerado pelo servidor, nunca aceito do cliente como fonte de verdade.
- `payload` contém somente domínios de dados que tenham contrato aprovado próprio.
- O envelope não deve conter valores de gameplay calculados ou enviados pelo cliente como autoridade.
- Campos desconhecidos não podem ser silenciosamente reinterpretados como valores válidos.
- Limites máximos de tamanho, profundidade e quantidade de elementos precisam ser definidos e testados antes de produção; não são fixados nesta proposta.

**Decisões de produto registradas — slots e personagens:** cada conta Roblox poderá possuir **até 3 personagens**, mas começará com apenas **1 slot disponível**. O segundo slot será liberado quando um personagem atingir o nível 25; o terceiro, quando um personagem atingir o nível 80. O desbloqueio de cada slot é condicionado à existência de um personagem criado naquele próprio slot: se o personagem que atingiu o marco de nível for excluído depois que outro personagem já tiver sido criado no slot liberado, o slot permanece disponível porque o personagem criado nele continua existindo. A mesma regra se aplica ao slot liberado no nível 80. Se o próprio personagem que ocupa o slot adicional for excluído permanentemente, o slot volta a ficar bloqueado e só poderá ser liberado novamente quando outro personagem atingir o marco correspondente (nível 25 para o slot 2; nível 80 para o slot 3). Durante as 24 horas em que a exclusão estiver pendente e puder ser cancelada, o personagem ainda existe e mantém o slot disponível. Portanto, o marco de nível permite abrir o slot, mas a continuidade depende da existência do personagem criado nele; não é um desbloqueio permanente independente dos personagens. Cada personagem terá identidade persistente própria e dados isolados. A conta proprietária será identificada pelo `UserId` Roblox, e cada personagem terá identificador estável próprio.

**Criação e apresentação:** inicialmente, a criação ficará limitada às opções masculina e feminina disponíveis para cada classe. A existência de personalização adicional de aparência permanece NÃO DECIDIDA; não presumir controles, opções ou limites de personalização.

**HUB de personagens:** ao entrar no jogo, o usuário será encaminhado a um HUB de seleção de personagens. A seleção de personagem e o fluxo de exclusão serão realizados nesse HUB. A criação também será acessada por esse HUB.

**Exclusão com período de recuperação:** o usuário deverá selecionar explicitamente o personagem e confirmar a exclusão. A confirmação inicia um período de 24 horas durante o qual o usuário poderá recorrer/cancelar a exclusão. Se não houver cancelamento dentro desse prazo, a exclusão será permanente. A implementação deverá distinguir personagem marcado para exclusão, período de recuperação e exclusão permanente; o prazo e o estado não poderão depender do relógio ou de informações fornecidas pelo cliente. O fluxo exato de recurso/cancelamento, a forma de notificação e o tratamento de indisponibilidade durante o prazo ainda precisam ser especificados.

A estrutura e as chaves concretas do DataStore continuam sendo decisões técnicas a detalhar, mas devem permitir localizar, proteger e isolar separadamente até três perfis pertencentes à mesma conta.

**Possibilidade futura, ainda não aprovada como sistema:** o usuário indicou que uma possível mudança de classe poderá ser avaliada no futuro. Isso não autoriza definir agora regras, custos, frequência, restrições, preservação de progresso ou fluxo de mudança. A possibilidade é independente da quantidade de personagens por conta.

## 4. Domínios do payload

Os seguintes domínios são apenas áreas candidatas para contratos próprios; não constituem um esquema aprovado:

| Domínio | Estado | Dependência |
|---|---|---|
| Identidade/quantidade de personagens | DECIDIDO: até 3 por conta; 1 slot inicial; slots 2 e 3 liberados nos níveis 25 e 80; cada slot adicional permanece disponível enquanto existir o personagem criado nele; exclusão permanente desse ocupante volta a bloquear o slot até novo marco de nível | `UserId` da conta + identificador estável individual; validar existência e estado de exclusão dos personagens para determinar slots disponíveis |
| Criação e HUB | DECIDIDO EM NÍVEL DE PRODUTO: opções masculina/feminina por classe; HUB para criação/seleção/exclusão | Catálogo inicial de classes e opções; fluxo de interface ainda a especificar |
| Personalização visual | NÃO DECIDIDA | Não implementar opções de personalização antes de decisão de game design |
| Exclusão de personagem | DECIDIDO: seleção + confirmação; janela de 24h para recorrer/cancelar; depois, exclusão permanente | Estado de exclusão pendente, relógio do servidor, cancelamento, expiração e recuperação precisam de contrato técnico |
| Classe/especialização | PENDENTE | Catálogo e regras aprovadas |
| Atributos/progressão | PENDENTE | Documento de atributos e fórmulas |
| Habilidades/talentos | PENDENTE | Catálogo e desbloqueios |
| Inventário/equipamentos | PENDENTE | Contratos INV/GEAR completos |
| Sprites/profissões | PENDENTE | Contrato de Sprites e profissões |
| Missões/facções | PENDENTE | Regras de missões e narrativa |
| Economia/moedas | PENDENTE | Regras econômicas |
| Preferências não críticas | PENDENTE | Escopo e política de dados |

Nenhum domínio deve ser criado no código persistente até que seus campos, tipos, limites, invariantes e regras de migração tenham fonte aprovada.

## 5. Autoridade e validação

Requisitos técnicos propostos:

1. O servidor é a única autoridade para ler, validar, transformar e gravar dados persistentes.
2. O cliente nunca envia o perfil completo para ser salvo.
3. Toda solicitação do cliente é uma intenção limitada; o servidor valida identidade, permissão, contexto e estado atual.
4. A validação ocorre na entrada do armazenamento e antes de qualquer gravação.
5. Validadores devem distinguir dado ausente, dado inválido, dado incompatível e versão desconhecida.
6. Não converter automaticamente valor inválido em zero, lista vazia ou padrão de gameplay, pois isso pode apagar progresso ou inventar estado.
7. Dados inválidos devem ser isolados e sinalizados; nunca sobrescrever o registro original com um perfil padrão sem recuperação deliberada.
8. Logs não devem expor payloads completos, dados pessoais ou segredos.

## 6. Ciclo de sessão proposto

Estados técnicos sugeridos:

- `NOT_LOADED`: ainda não houve leitura confirmada.
- `LOADING`: leitura e validação em andamento.
- `READY`: dados carregados, validados e sessão autorizada a operar.
- `SAVE_PENDING`: existem alterações persistentes ainda não confirmadas.
- `SAVING`: gravação em andamento.
- `DEGRADED`: serviço temporariamente indisponível ou operação não confirmada.
- `CLOSING`: encerramento e tentativa final de salvamento.
- `FAILED`: falha que impede garantir integridade do perfil.

Regras propostas:

- O jogador não deve executar operações que alterem estado persistente antes de `READY`.
- A inicialização de sessão e a disponibilidade de dados persistidos são conceitos distintos. O atributo atual `SessionInitialized` da Foundation 0.1 não significa que dados foram carregados.
- Falha de carregamento não pode ser tratada como perfil novo vazio.
- O comportamento de produto diante de falha prolongada (aguardar, tentar novamente, encaminhar a uma área segura ou desconectar) permanece PENDENTE; qualquer opção precisa impedir gravação sobre dados não carregados.
- Alterações em memória devem ser marcadas como pendentes e persistidas conforme política aprovada.
- O sistema deve impedir que uma gravação atrasada de uma sessão antiga sobrescreva dados de uma sessão mais recente.

## 7. Concorrência e bloqueio de sessão

É necessária proteção contra duas sessões simultâneas alterarem o mesmo perfil.

Estratégia técnica proposta para avaliação:

- aquisição e atualização de uma concessão de sessão (*lease*) por operação atômica do DataStore;
- token de propriedade único por sessão, gerado no servidor;
- expiração e renovação da concessão;
- toda gravação verifica que o token ainda pertence à sessão ativa;
- liberação condicional no encerramento, sem remover concessão pertencente a outra sessão;
- uso de operação atômica apropriada, como `UpdateAsync`, para resolver concorrência no armazenamento.

Ainda precisam ser definidos por teste e revisão: duração da concessão, intervalo de renovação, margem de segurança, política de retries, comportamento após perda da concessão e tratamento de relógio/timeout. Não definir esses valores por suposição.

## 8. Salvamento e falhas

Requisitos propostos:

- Escritas devem ser idempotentes sempre que possível.
- Nunca considerar uma gravação concluída antes de confirmação do serviço.
- Aplicar tentativas limitadas e backoff com jitter, respeitando orçamento e limites do serviço.
- Não executar loops de retry ilimitados.
- Coalescer alterações pendentes quando seguro, sem perder a ordem lógica das operações.
- Salvar em pontos de ciclo de vida definidos, incluindo encerramento de sessão e encerramento do servidor, sem depender exclusivamente deles.
- O encerramento do servidor tem tempo limitado; o sistema precisa registrar quais gravações foram confirmadas e quais não foram.
- Falha de salvamento mantém o perfil como não confirmado; não descartar silenciosamente alterações pendentes.
- A política final de frequência, autosave, tamanho máximo e prioridade deve ser definida após conhecer os domínios e medir o consumo.

## 9. Migração de esquema

Proposta:

- Cada formato persistido tem um `schemaVersion` explícito.
- Migrações são funções sequenciais e determinísticas de versão N para N+1.
- Migrações operam sobre cópia candidata, validam o resultado e só então permitem gravação.
- A versão original deve permanecer recuperável até confirmação da migração.
- Versão futura/desconhecida não deve ser rebaixada nem sobrescrita automaticamente.
- Migrações devem ser testadas com fixtures representativas de cada versão histórica suportada.
- Não remover campos ou alterar semântica sem regra explícita de compatibilidade.
- Política de backup, retenção e rollback de migração permanece PENDENTE.

## 10. Segurança, privacidade e abuso

- A identidade de armazenamento deve ser derivada no servidor, associando o identificador estável da conta Roblox (`UserId`) ao identificador estável individual do personagem. O modelo deve suportar até três personagens isolados por conta, um slot inicial e desbloqueios associados aos marcos de nível 25 e 80. Nunca aceitar identificadores ou chaves fornecidos pelo cliente sem validação de propriedade e contexto. O formato exato da chave e a estrutura de índice/seleção permanecem decisões técnicas de implementação.
- O estado de exclusão pendente e o instante de início/fim da janela de 24 horas devem ser controlados pelo servidor. A exclusão permanente só pode ocorrer após o prazo sem cancelamento válido.
- Validar tipo, estrutura, tamanho, frequência e contexto das solicitações.
- Limitar chamadas de salvamento para evitar abuso e esgotamento de orçamento.
- Não confiar em timestamps, revisões ou tokens fornecidos pelo cliente.
- Não registrar dados pessoais ou payload completo em logs.
- Definir política de retenção, exclusão e recuperação de dados antes da publicação; ainda não especificada.
- Não armazenar segredos, tokens de autenticação externos ou credenciais no perfil.

## 11. Plano de testes obrigatório

Antes de aprovar implementação de persistência, criar testes automatizados para:

1. perfil inexistente versus falha de leitura;
2. envelope válido e versão suportada;
3. campos ausentes, tipo incorreto, valores fora de limites e payload excessivo;
4. versão desconhecida/futura;
5. migração sequencial, determinismo e falha no meio da migração;
6. falha de gravação, timeout, retry limitado e backoff;
7. duas sessões concorrentes tentando adquirir o mesmo perfil;
8. renovação, expiração e perda de concessão;
9. sessão antiga tentando gravar após perder propriedade;
10. saída normal e encerramento do servidor;
11. falha parcial e retomada sem sobrescrever dados válidos;
12. garantia de que cliente não consegue escolher chave, revisão, schema ou payload persistido.

Testes unitários devem usar adaptador/mocks isolados. Testes de integração precisam validar o comportamento com DataStore habilitado em ambiente de teste, sem reutilizar dados reais de produção. Não declarar testes de serviço real executados sem evidência.

## 12. Critérios de aceitação da etapa 2

A etapa só pode passar para implementação quando:

- [x] Decisões de produto: até três personagens por conta; um slot inicial; segundo slot no nível 25 e terceiro no nível 80; criação inicial masculina/feminina por classe; HUB de personagens; exclusão com confirmação e janela de 24 horas para cancelar/recorrer antes da exclusão permanente.
- [x] Regra de disponibilidade dos slots definida: após a criação de um personagem no slot liberado, a exclusão do personagem que atingiu o marco não fecha o slot enquanto o personagem criado nele continuar existindo. O mesmo vale para os slots 2 e 3.
- [x] Definido: se o personagem ocupante do slot adicional for excluído permanentemente, o slot volta a ficar bloqueado até outro personagem atingir o marco correspondente (nível 25 ou 80). Durante a janela de 24 horas de exclusão pendente, o personagem ainda existe e mantém o slot disponível.
- [ ] Especificar o fluxo de criação/seleção no HUB e o fluxo técnico de cancelamento da exclusão pendente.
- [ ] Decidir se haverá personalização visual além das opções masculina/feminina por classe; não implementar antes dessa decisão.
- [ ] Definir o que significa operacionalmente “recorrer” (cancelamento direto pelo usuário no HUB ou outro fluxo), mantendo o prazo de 24 horas.
- [ ] Domínios e campos persistentes aprovados ou explicitamente excluídos do MVP.
- [ ] Envelope, versão, revisão e limites aprovados.
- [ ] Política de aquisição, renovação e liberação de sessão definida.
- [ ] Política de carregamento, falha, salvamento e encerramento definida.
- [ ] Migração, recuperação e rollback definidos.
- [ ] Segurança e privacidade revisadas.
- [ ] Testes e critérios de aceitação definidos.
- [ ] Contrato confrontado com documentos originais 12 e 13, caso seus textos integrais sejam recuperados.
- [ ] Nenhum comportamento de gameplay foi inferido ou criado para preencher lacunas.

## 13. Decisões que exigem o usuário

Estas questões não devem ser decididas por conveniência técnica:

1. O comportamento após a exclusão do próprio personagem que ocupa um slot adicional está decidido: após a exclusão permanente, o slot volta a ficar bloqueado até outro personagem atingir o marco correspondente. Durante a janela de 24 horas de exclusão pendente, o slot permanece disponível.
2. Como será o fluxo de criação e seleção no HUB e o cancelamento de uma exclusão pendente?
3. O termo “recorrer” significa cancelar a exclusão diretamente no HUB ou haverá outro fluxo?
4. Haverá personalização visual além das opções masculina/feminina por classe?
5. Quais domínios de dados entram no MVP persistente e quais documentos aprovados fornecem seus campos e invariantes?
6. Qual deve ser a experiência do jogador quando os dados não puderem ser carregados por indisponibilidade prolongada?
7. Há política adicional de exclusão/retensão de dados definida em documento aprovado ainda não recuperado?

**Nota de escopo futuro:** uma eventual mudança de classe foi mencionada como possibilidade a avaliar posteriormente. Nenhuma regra desse sistema está aprovada ou especificada por esta proposta.

As decisões técnicas sobre implementação interna da concessão de sessão, retries e adaptadores podem ser refinadas como propostas reversíveis após as dependências acima.

## 14. Registro de estado

- **Especificação:** proposta técnica v0.1 criada; não aprovada.
- **Código DataStore:** não implementado.
- **Testes de persistência:** não executados; ainda não há implementação.
- **Decisões de produto incorporadas:** até três personagens por conta; um slot inicial; segundo slot ao nível 25 e terceiro ao nível 80; opções masculina/feminina por classe; HUB para criação/seleção/exclusão; exclusão mediante seleção e confirmação, com 24 horas para recorrer/cancelar antes da exclusão permanente. Cada perfil deve ser identificado e persistido separadamente, associado ao `UserId` proprietário.
- **Pendente de game design:** personalização visual adicional não decidida. O comportamento dos slots após exclusão está definido: o slot adicional permanece disponível durante a janela de 24 horas; após a exclusão permanente do personagem que o ocupa, volta a ficar bloqueado até novo marco de nível. O fluxo exato de cancelamento/recorrência ainda precisa ser especificado.
- **Possibilidade futura registrada:** avaliar mudança de classe em etapa própria, sem regras definidas nesta proposta.
- **Próximo passo:** revisão das decisões ainda pendentes e recuperação dos textos integrais dos Documentos 12/13, se disponíveis. Só então consolidar contrato aprovado e iniciar implementação.
