# Claude Code Game Studios — adaptação seletiva para Aethermoor

**Estado:** proposta de tooling em revisão; não altera decisões de produto.
**Origem analisada:** Donchitos/Claude-Code-Game-Studios, release 1.3.0.
**Destino:** configuração de projeto Claude Code no repositório GFRB.

## O que foi adaptado

- Separação de responsabilidades por agente, limitada a engenharia Roblox e QA.
- Regras específicas para Luau, limites cliente/servidor, mapeamento Rojo e evidências de teste.
- Fluxos reutilizáveis para revisão de código Roblox e validação em Studio.
- Instruções do projeto que apontam para AGENTS.md e para o protocolo de desenvolvimento aprovado do Aethermoor.

## O que foi deliberadamente deixado de fora

- O projeto.yaml do framework CCGS: Aethermoor já tem README, AGENTS.md, Project Charter, Decision Register e protocolo próprios.
- Os perfis de Godot, Unity, Unreal e engines web: não descrevem o stack Roblox.
- .claude/settings.json: configura comandos permitidos/negados e vários eventos automáticos, sem necessidade para esta adaptação.
- Hooks e scripts Bash: alguns gravam estado/logs locais, podem chamar a rede ou agir em commits e pushes. Não foram instalados nem executados.
- Workflows de teste CCGS: o GFRB já tem suite Luau e workflow que executa testes e build Rojo; duplicá-los criaria dois pontos de manutenção.
- Schemas ou regras DataStore: a especificação de persistência Aethermoor continua sujeita a aprovação e não autoriza implementação por si só.

## Limites de compatibilidade

A configuração adicionada é destinada a Claude Code. Ela não substitui AGENTS.md nem muda o comportamento do Codex. As skills descrevem processos; não executam comandos automaticamente. APIs Roblox devem ser conferidas em documentação oficial atual e as evidências devem indicar se vieram de Studio, Lune, build ou mocks.

## Revisão e avanço

Esta adaptação é tooling inicial e pode ser revisada pela PR. Não muda o projeto Roblox, o lugar do Studio, os dados de jogadores, decisões de gameplay ou o estado de publicação. Nenhuma dependência foi instalada.
