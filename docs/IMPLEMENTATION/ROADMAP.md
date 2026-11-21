# Roadmap de Implementação — Aethermoor

**Versão:** 1.0 (plano inicial de execução)  
**Estado:** Plano de trabalho; a sequência pode ser ajustada por dependências técnicas.

## Princípios

- Entregas pequenas, rastreáveis e testáveis.
- Servidor autoritativo para operações críticas.
- Multiplataforma desde o começo; não deixar controles móveis para o fim.
- Não codificar fórmulas ausentes por suposição.
- Registrar cada entrega e teste no repositório.
- Não declarar testes aprovados sem execução verificável.

## Etapas

| Etapa | Escopo | Estado inicial |
|---|---|---|
| 0 | Repositório, documentação-base e estrutura de projeto | IN_PROGRESS |
| 1 | Fundação Roblox: bootstraps, configuração, serviços e registro de mapas | BACKLOG |
| 2 | Contrato de dados do personagem e persistência | BLOCKED por especificação |
| 3 | Personagem, progressão, classes e atributos | BLOCKED por regras/formulas |
| 4 | Combate, habilidades, inimigos e chefes | BLOCKED por especificação de combate |
| 5 | Inventário, itens e equipamentos | BLOCKED por contratos e regras |
| 6 | Mundo, interação, missões e recompensas | BLOCKED por escopo de conteúdo |
| 7 | Sprites, profissões, coleta e fabricação | BLOCKED por parâmetros e contratos |
| 8 | Economia e comércio | BLOCKED por regras econômicas |
| 9 | Multiplayer, grupos, instâncias e guildas | BLOCKED por regras de grupo |
| 10 | UI/UX e validação multiplataforma contínua | BACKLOG; iniciar protótipos em paralelo após contratos |
| 11 | Segurança, desempenho, testes integrados e aceitação | BACKLOG |
| 12 | Preparação de publicação, monitoramento e rollback | BACKLOG |

## Primeira entrega técnica planejada

A fundação técnica deve conter:

- Estrutura de pastas/serviços.
- Configuração compartilhada.
- Registro dos sete mapas.
- Inicialização de servidor e cliente.
- Ciclo de vida de sessão sem persistência prematura.

## Próxima entrega recomendada

Contrato de dados de personagem e persistência:

1. Esquema versionado.
2. Campos e tipos.
3. Defaults e validação.
4. Estratégia de carregamento/salvamento.
5. Tratamento de falhas e sessões concorrentes.
6. Migração e recuperação.
7. Testes e critérios de aceitação.

Não integrar DataStore improvisado antes de aprovar o contrato.
