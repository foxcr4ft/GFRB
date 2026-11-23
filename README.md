# GFRB — Aethermoor MMORPG

Repositório oficial de documentação, decisões, implementação e histórico de execução do projeto MMORPG Aethermoor para Roblox.

## Fonte de verdade

- Catálogo e recuperação de documentos: [Document Catalog](docs/DOCUMENT_CATALOG.md)
- Regras aprovadas e princípios: [Project Charter](docs/PROJECT_CHARTER.md)
- Registro de decisões e pendências: [Decision Register](docs/DECISIONS.md)
- Mapas oficiais: [Map Registry](docs/world/MAP_REGISTRY.md)
- Estado documental e rastreabilidade: [Document Status](docs/TRACEABILITY/STATUS.md)
- Plano de desenvolvimento: [Implementation Roadmap](docs/IMPLEMENTATION/ROADMAP.md)
- Histórico de entregas: [Implementation Log](docs/IMPLEMENTATION/IMPLEMENTATION_LOG.md)
- Fundação técnica 0.1: [Foundation 0.1](docs/IMPLEMENTATION/FOUNDATION_0_1.md)
- Proposta de contrato de persistência: [Character Data and Persistence Contract 0.1](docs/TECHNICAL/CHARACTER_DATA_PERSISTENCE_CONTRACT_0_1.md)

## Regras de trabalho

1. Este repositório é o registro central do que foi aprovado, especificado, implementado e testado.
2. Não marcar uma tarefa como concluída sem evidência verificável.
3. Separar sempre **aprovado**, **proposto**, **pendente**, **implementado** e **testado**.
4. Não alterar silenciosamente decisões ou documentos aprovados; usar adendos e histórico.
5. Não inventar fórmulas, taxas, probabilidades, limites ou parâmetros de balanceamento.
6. O servidor Roblox é a autoridade nas operações críticas.
7. Desenvolver em etapas pequenas, revisáveis e testáveis.
8. Registrar cada entrega com arquivos alterados, objetivo, testes executados, resultado e limitações.
9. Merge de Pull Request exige autorização explícita do usuário.

## Estado atual

- Baseline documental integrada à `main`.
- PR #3 (recuperação documental) e PR #4 (protocolo de desenvolvimento) integradas à `main`.
- Foundation 0.1 integrada pela PR #2, validada em Studio e GitHub Actions.
- Place de validação salvo no Team Create; experiência não publicada.
- Etapa 2 em especificação: contrato de dados do personagem e persistência.
- DataStore e esquema persistente ainda não implementados.
- O catálogo de documentos distingue textos aprovados recuperados de textos ainda não recuperados integralmente.

## Estrutura

```
docs/       Regras, decisões, especificações, rastreabilidade e planos
src/        Código-fonte Roblox (Luau)
tests/      Testes automatizados e roteiros de teste
tools/      Ferramentas auxiliares
```
