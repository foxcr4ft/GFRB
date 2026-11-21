# Estado documental e rastreabilidade

**Versão:** 1.0 (baseline do repositório)

## 1. Auditorias concluídas

As auditorias documentais anteriores já foram realizadas no trabalho do projeto:

- Auditoria 1 — completude documental preliminar.
- Auditoria 2 — consistência e dependências entre documentos.
- Auditoria 3 — prontidão do projeto/MVP.

Não repetir essas auditorias como etapa de rotina. Retomar uma verificação somente se uma mudança concreta, regressão ou novo documento justificar.

## 2. Resultado consolidado

O projeto foi classificado como **PRONTIDÃO CONDICIONADA**, não como documentação pronta para implementação. O usuário posteriormente autorizou o início da programação.

A autorização para programar não elimina a necessidade de resolver pendências durante o desenvolvimento. Sistemas que dependem de fórmulas ou contratos ainda não definidos devem aguardar sua especificação, ou receber protótipos explicitamente identificados como provisórios.

## 3. Blocos de rastreabilidade

| Bloco | Tema | Registro |
|---|---|---|
| 1 | Identidade, mundo e progressão | Matriz temática v0.1; parcialmente consolidada |
| 2 | Classes, atributos, combate, habilidades, equipamentos e inventário | Matriz temática v0.1; parcialmente consolidada |
| 3 | Sprites, profissões, coleta, fabricação, aprimoramento e economia | Matriz temática v0.1; parcialmente consolidada |
| 4 | Missões, narrativa, multiplayer, guildas, eventos e social | Matriz temática v0.1; parcialmente consolidada |
| 5 | Interface, arquitetura, persistência, segurança, testes e operação | Matriz temática v0.1; parcialmente consolidada |
| 6 | MVP, dependências, ordem de implementação e pacote técnico | Proposta consolidada v0.1 |

## 4. Bloqueadores de prontidão conhecidos

- B-01 — escopo do MVP.
- B-02 — regras centrais e parâmetros.
- B-03 — arquitetura/persistência e contratos.
- B-04 — segurança.
- B-05 — testes e critérios de aceitação.
- B-06 — governança e operação.

Esses itens devem ser tratados dentro das etapas de implementação e especificação; não justificam repetir as auditorias já concluídas.

## 5. Limitações da baseline

Este repositório foi inicialmente vazio, contendo apenas README. Esta primeira carga registra regras, decisões, referências e estados conhecidos a partir do histórico consolidado do projeto. Ela não afirma conter a transcrição integral de todos os documentos aprovados.

Os textos integrais dos documentos devem ser adicionados quando forem disponibilizados/recuperados. Não reconstruir conteúdo ausente como se fosse original.

## 6. Controle de execução

Cada tarefa deve usar os estados:

- BACKLOG — ainda não iniciada.
- SPEC — especificação em elaboração.
- READY — dependências resolvidas e pronta.
- IN_PROGRESS — em desenvolvimento.
- IMPLEMENTED — código integrado, ainda sem validação completa.
- TESTED — testes executados e aprovados, com evidência.
- BLOCKED — depende de decisão, especificação ou correção.
- DEFERRED — planejada para etapa posterior.

Nunca usar IMPLEMENTED como sinônimo de TESTED.
