# GFRB — Aethermoor MMORPG

Repositório oficial de documentação, decisões, implementação e histórico de execução do projeto MMORPG Aethermoor para Roblox.

## Fonte de verdade

- Regras aprovadas e princípios: [Project Charter](docs/PROJECT_CHARTER.md)
- Registro de decisões e pendências: [Decision Register](docs/DECISIONS.md)
- Mapas oficiais: [Map Registry](docs/world/MAP_REGISTRY.md)
- Estado documental e rastreabilidade: [Document Status](docs/TRACEABILITY/STATUS.md)
- Plano de desenvolvimento: [Implementation Roadmap](docs/IMPLEMENTATION/ROADMAP.md)
- Histórico de entregas: [Implementation Log](docs/IMPLEMENTATION/IMPLEMENTATION_LOG.md)

## Regras de trabalho

1. Este repositório é o registro central do que foi aprovado, especificado, implementado e testado.
2. Não marcar uma tarefa como concluída sem evidência verificável.
3. Separar sempre **aprovado**, **proposto**, **pendente**, **implementado** e **testado**.
4. Não alterar silenciosamente decisões ou documentos aprovados; usar adendos e histórico.
5. Não inventar fórmulas, taxas, probabilidades, limites ou parâmetros de balanceamento.
6. O servidor Roblox é a autoridade nas operações críticas.
7. Desenvolver em etapas pequenas, revisáveis e testáveis.
8. Registrar cada entrega com arquivos alterados, objetivo, testes executados, resultado e limitações.

## Estado atual

- Repositório inicializado com baseline documental.
- Auditorias documentais anteriores já realizadas; não repetir como etapa de rotina.
- Desenvolvimento autorizado pelo usuário.
- Fundação técnica inicial foi gerada como pacote preparatório, mas ainda não foi importada nem validada no Roblox Studio.
- Próxima etapa: integrar os documentos-fonte disponíveis e consolidar o primeiro módulo de código com testes.

## Estrutura

```
docs/       Regras, decisões, especificações, rastreabilidade e planos
src/        Código-fonte Roblox (Luau), quando integrado e validado
tests/      Testes automatizados e roteiros de teste
tools/      Ferramentas auxiliares
```
