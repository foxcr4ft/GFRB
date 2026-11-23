# Roadmap de Implementação — Aethermoor

**Versão:** 1.1  
**Estado:** Plano de execução atualizado após integração da Foundation 0.1 e dos pacotes documentais.

## Princípios

- Entregas pequenas, rastreáveis e testáveis.
- Servidor autoritativo para operações críticas.
- Multiplataforma desde o começo; não deixar controles móveis para o fim.
- Não codificar fórmulas ausentes por suposição.
- Registrar cada entrega e teste no repositório.
- Não declarar testes aprovados sem execução verificável.
- Nenhuma PR é mesclada por agente; merge reservado ao usuário.

## Etapas

| Etapa | Escopo | Estado atual |
|---|---|---|
| 0 | Repositório, documentação-base e estrutura de projeto | IMPLEMENTED — PRs documentais #3 e #4 integradas |
| 1 | Fundação Roblox: bootstraps, configuração, serviços e registro de mapas | IMPLEMENTED + TESTED — PR #2 integrada; 10/10 testes Luau, CI e build Rojo aprovados; validação Studio registrada |
| 2 | Contrato de dados do personagem e persistência | SPEC IN PROGRESS — proposta técnica 0.1 em revisão; DataStore não implementado |
| 3 | Personagem, progressão, classes e atributos | BLOCKED por regras/formulas aprovadas |
| 4 | Combate, habilidades, inimigos e chefes | BLOCKED por especificação de combate |
| 5 | Inventário, itens e equipamentos | BLOCKED por contratos e regras |
| 6 | Mundo, interação, missões e recompensas | BLOCKED por escopo de conteúdo |
| 7 | Sprites, profissões, coleta e fabricação | BLOCKED por parâmetros e contratos |
| 8 | Economia e comércio | BLOCKED por regras econômicas |
| 9 | Multiplayer, grupos, instâncias e guildas | BLOCKED por regras de grupo |
| 10 | UI/UX e validação multiplataforma contínua | BACKLOG; protótipos dependem de contratos e escopo |
| 11 | Segurança, desempenho, testes integrados e aceitação | BACKLOG contínuo |
| 12 | Preparação de publicação, monitoramento e rollback | BACKLOG |

## Etapa 1 — resultado registrado

A Foundation 0.1 foi integrada à `main` pela PR #2. A entrega contém configuração compartilhada, registro dos sete mapas, bootstraps de servidor/cliente e ciclo de vida básico de jogador.

Evidências registradas:
- 10/10 testes Luau aprovados no Roblox Studio.
- GitHub Actions: suíte Luau e build Rojo aprovados no commit validado.
- Place salvo no Team Create, não publicado.
- Testes com múltiplos jogadores e saída usam sinais simulados; não houve teste live com múltiplos clientes.

A integração da Foundation não significa que persistência ou dados de personagem estejam implementados.

## Etapa 2 — próxima entrega

A etapa 2 é contract-first. Antes de DataStore, concluir e aprovar:
1. Modelo de perfil para até três personagens por conta: um slot inicial; slots 2 e 3 liberados nos níveis 25 e 80, mantendo-se disponíveis enquanto houver personagem criado em cada slot; se o próprio ocupante for excluído permanentemente, o slot volta a ficar bloqueado até novo marco de nível (durante as 24 horas de exclusão pendente, continua disponível); opções masculina/feminina por classe, HUB de criação/seleção/exclusão e exclusão com confirmação e janela de 24 horas para cancelar/recorrer antes da exclusão permanente.
2. Domínios persistentes do MVP e campos fornecidos por especificações aprovadas.
3. Envelope versionado, revisão, validação e limites.
4. Carregamento, salvamento e estados de disponibilidade.
5. Concorrência e concessão de sessão.
6. Falhas, retries, encerramento e recuperação.
7. Migrações, compatibilidade e rollback.
8. Testes automatizados e de integração.

A proposta técnica 0.1 em `docs/TECHNICAL/CHARACTER_DATA_PERSISTENCE_CONTRACT_0_1.md` registra as decisões de produto sobre slots, criação, HUB e exclusão, além das questões ainda não decididas. Personalização visual adicional continua sem decisão. O contrato não está aprovado e não autoriza implementação de DataStore.

## Regra de avanço

Não avançar para implementação persistente enquanto o contrato não estiver aprovado e os domínios de gameplay não tiverem fonte confiável. É permitido desenvolver adaptadores e testes isolados sem gravar dados reais, desde que não fixem um esquema ou comportamento de produto ainda pendente.
