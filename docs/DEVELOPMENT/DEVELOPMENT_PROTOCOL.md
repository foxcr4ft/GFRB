# Aethermoor Development Protocol

**Versão:** 0.1  
**Estado:** Diretriz de trabalho aprovada pelo usuário  
**Padrão:** Equilibrado  
**Autonomia dos agentes:** Completa, com merge reservado ao usuário  
**Escopo:** Documentação, desenvolvimento, testes e manutenção do repositório Aethermoor

## 1. Objetivo

Estabelecer um método consistente para agentes humanos e automatizados planejarem, implementarem, testarem e documentarem Aethermoor, preservando as decisões aprovadas e permitindo autonomia técnica responsável.

Este protocolo complementa, mas não substitui, o Project Charter, o Decision Register, os documentos de design aprovados e os contratos técnicos específicos.

## 2. Padrão de decisão: equilibrado

Agentes podem tomar decisões técnicas provisórias quando necessárias para avançar, desde que:

- A decisão esteja dentro do escopo técnico autorizado.
- Não contradiga o Project Charter, decisões aprovadas ou contratos existentes.
- Seja a opção mais simples, modular, reversível e testável razoável.
- Seja registrada como **PROVISÓRIA**, com justificativa, alternativas relevantes, impacto e forma de reversão.
- Não seja apresentada como decisão de design aprovada.

Agentes não podem preencher lacunas de gameplay com suposições. Não inventar ou fixar sem aprovação explícita: fórmulas, atributos, dano, cooldowns, probabilidades, taxas, limites, progressão, balanceamento, recompensas, receitas, preços, conteúdo narrativo canônico ou regras econômicas.

Quando um requisito estiver incompleto:
1. Implementar apenas a parte independente e bem definida, se possível.
2. Isolar interfaces e pontos de extensão sem impor comportamento de jogo.
3. Registrar a dependência e o bloqueio.
4. Solicitar decisão do usuário somente quando a escolha afetar design, escopo, equilíbrio, monetização, lore ou compatibilidade com decisões aprovadas.

## 3. Autonomia completa e limite de merge

Agentes estão autorizados a executar o fluxo de trabalho de ponta a ponta:

- Inspecionar o repositório e o histórico relevante.
- Planejar tarefas e dependências.
- Criar branches.
- Implementar código e documentação.
- Criar e executar testes disponíveis.
- Corrigir falhas identificadas.
- Criar commits com mensagens claras.
- Abrir e atualizar Pull Requests.
- Revisar as próprias alterações e registrar limitações.

**Limite obrigatório:** agentes não podem fazer merge de Pull Requests, diretamente ou por automação. O merge exige autorização explícita do usuário. Também não devem apagar branches, reescrever histórico compartilhado ou substituir decisões aprovadas sem autorização.

Autonomia completa não significa autorização para redefinir o produto.

## 4. Hierarquia de fontes

Em caso de dúvida, respeitar esta ordem:

1. Decisões explícitas mais recentes do usuário.
2. Documentos de design e requisitos formalmente aprovados.
3. Project Charter e Decision Register.
4. Contratos técnicos aprovados e especificações do sistema.
5. Decisões técnicas provisórias registradas.
6. Propostas, hipóteses e reconstruções editoriais — nunca tratadas como aprovação.

Se duas fontes aprovadas parecerem incompatíveis, não escolher silenciosamente uma delas. Registrar o conflito e buscar resolução.

## 5. Regras de arquitetura Roblox

- Manter separação clara entre cliente e servidor.
- O servidor valida e controla resultados críticos, incluindo combate, dano, recompensas, inventário, comércio, economia, progressão e persistência.
- Tratar toda entrada do cliente como não confiável.
- Validar permissões, tipos, limites e contexto no servidor antes de executar ações solicitadas por clientes.
- Não confiar em valores de dano, preço, quantidade, cooldown ou recompensa calculados pelo cliente.
- Evitar expor segredos, lógica sensível ou autoridade de jogo no cliente.
- Preferir módulos coesos, interfaces explícitas, baixo acoplamento e dependências controladas.
- Projetar para PC, dispositivos móveis, tablets e consoles compatíveis com Roblox.
- Não introduzir DataStore, esquema persistente ou migração improvisados quando o contrato de persistência estiver bloqueado.
- Não adicionar dependências externas sem avaliar necessidade, manutenção, segurança e compatibilidade.

Estas são diretrizes de engenharia; não autorizam criar regras de gameplay ausentes.

## 6. Processo de implementação

Para cada tarefa:

1. **Inspecionar:** ler arquivos, decisões, dependências e estado atual da branch.
2. **Definir escopo:** declarar o que será e o que não será alterado.
3. **Classificar:** distinguir requisito aprovado, decisão técnica provisória e pendência.
4. **Planejar:** escolher uma entrega pequena e verificável.
5. **Implementar:** preservar compatibilidade e evitar alterações não relacionadas.
6. **Testar:** executar verificações relevantes e registrar comandos/resultados.
7. **Revisar:** procurar regressões, falhas de segurança, dependências e código morto.
8. **Documentar:** atualizar log, roadmap, decisões ou especificações afetadas.
9. **Entregar:** criar commit(s) e Pull Request, sem merge.

Não declarar uma etapa concluída se os critérios de aceitação não foram verificados.

## 7. Testes e evidências

- Testar a menor unidade relevante e adicionar testes de integração quando aplicável.
- Testar casos válidos, inválidos, limites, falhas e entradas maliciosas para operações de servidor.
- Não afirmar que Roblox Studio, emuladores, dispositivos ou serviços online foram testados se a execução não ocorreu.
- Distinguir claramente: **não executado**, **passou**, **falhou**, **bloqueado** e **não aplicável**.
- Quando o ambiente não estiver disponível, fornecer roteiro reproduzível e declarar a limitação.
- Não reduzir ou remover testes apenas para fazer a entrega passar.

## 8. Git e Pull Requests

- Usar branches específicas e nomes descritivos, por exemplo `feat/`, `fix/`, `docs/` e `test/`.
- Evitar commits gigantes; separar mudanças coerentes.
- Não incluir arquivos temporários, segredos, credenciais ou dados pessoais.
- PR deve informar objetivo, escopo, decisões provisórias, arquivos alterados, testes executados, resultado, riscos, limitações e pendências.
- Manter PRs como não mescladas até revisão e autorização do usuário.
- Não fazer force-push em branches compartilhadas sem necessidade e autorização.
- Antes de atualizar arquivos existentes, conferir o conteúdo e a versão atuais para evitar sobrescrita de trabalho alheio.

## 9. Documentação e rastreabilidade

Toda entrega relevante deve registrar:

- Identificador da tarefa ou requisito, quando existir.
- Fonte do requisito e seu estado de aprovação.
- Arquivos criados ou alterados.
- Decisões técnicas provisórias e justificativas.
- Testes executados e resultados reais.
- Limitações, riscos e dependências.
- PR e commit correspondentes.

Preservar a distinção entre **APROVADO**, **PROPOSTA**, **PROVISÓRIO**, **PENDENTE**, **IMPLEMENTADO** e **TESTADO**. Implementado não significa testado; testado não significa aprovado como design.

Não reconstruir texto histórico como se fosse literal. Marcar a fidelidade documental de acordo com o protocolo de recuperação.

## 10. Segurança e qualidade

- Nunca registrar tokens, senhas, chaves privadas ou credenciais nos arquivos, commits ou logs.
- Não desativar validações de segurança para contornar problemas.
- Não confiar em RemoteEvents/RemoteFunctions sem validação no servidor, limites de frequência e checagem de contexto adequados.
- Considerar abuso, repetição de chamadas, concorrência, falhas parciais e inconsistência de estado.
- Preferir operações idempotentes quando apropriado.
- Registrar riscos conhecidos e mitigação pendente.

## 11. Quando interromper e pedir decisão

Pedir decisão ao usuário antes de:
- Alterar uma decisão de design aprovada.
- Definir regras ou números de gameplay ausentes.
- Mudar escopo de MVP, lore canônico, monetização ou equilíbrio.
- Escolher comportamento persistente irreversível sem contrato.
- Remover conteúdo aprovado ou fazer merge.
- Aceitar uma concessão que afete significativamente segurança, integridade de dados ou compatibilidade.

Para decisões puramente técnicas, reversíveis e dentro do escopo, agir com autonomia, documentar e prosseguir.

## 12. Checklist de conclusão

- [ ] Escopo e fonte do requisito identificados.
- [ ] Nenhuma regra de gameplay foi inventada.
- [ ] Decisões provisórias estão identificadas e justificadas.
- [ ] Autoridade do servidor preservada.
- [ ] Compatibilidade multiplataforma considerada.
- [ ] Testes relevantes executados ou limitação explicitada.
- [ ] Documentação e rastreabilidade atualizadas.
- [ ] PR descreve riscos e limitações.
- [ ] Nenhum merge foi feito sem autorização explícita do usuário.
