# Implementation Log

## Baseline documental — 2026-11-21

### Repositório
- Repositório: https://github.com/foxcr4ft/GFRB
- Branch documental: `docs/project-baseline` (merge confirmado pelo usuário).
- Conteúdo: Project Charter, Decision Register, Map Registry, estado de auditorias/rastreabilidade e roadmap.

### Observação de integridade documental
A baseline é uma consolidação a partir do histórico disponível. Ela não afirma conter a transcrição integral de todos os documentos aprovados. Textos integrais serão incorporados quando recuperados, mantendo versão e natureza (original ou reconstrução editorial).

## Foundation 0.1 — 2026-11-21

### Branch
`implementation/foundation-0.1`

### Arquivos adicionados
- `src/ReplicatedStorage/Shared/ProjectConfig.luau`
- `src/ReplicatedStorage/Shared/MapRegistry.luau`
- `src/ServerScriptService/Services/PlayerLifecycleService.luau`
- `src/ServerScriptService/Bootstrap.server.luau`
- `src/StarterPlayer/StarterPlayerScripts/ClientBootstrap.client.luau`
- `default.project.json`
- `tests/manual/FOUNDATION_0_1.md`
- `docs/IMPLEMENTATION/FOUNDATION_0_1.md`

### Implementado
- Configuração compartilhada e imutável.
- Registro dos sete mapas com IDs permanentes e nomes oficiais.
- Bootstrap de servidor e cliente.
- Serviço mínimo de ciclo de vida do jogador.
- Verificação do número e continuidade dos IDs de mapa no cliente.
- Mapeamento de projeto Rojo.

### Testes e evidências
- Arquivos gravados na branch do GitHub: confirmado.
- Execução em Roblox Studio: NÃO EXECUTADA.
- Testes Luau automatizados: NÃO EXECUTADOS.
- Roteiro manual de aceitação criado em `tests/manual/FOUNDATION_0_1.md`.

### Limitações conhecidas
- Nenhuma persistência de dados nesta entrega.
- `SessionInitialized` significa apenas que o hook básico de sessão executou; não indica dados carregados.
- Não inclui criação de personagem, classes, progressão, combate, inventário, Sprites, missões, economia ou UI.

### Próximas ações
1. Revisar e integrar esta branch.
2. Executar roteiro manual no Roblox Studio e registrar evidências.
3. Recuperar/incorporar documentos integrais aprovados que ainda não constam no repositório.
4. Fechar contrato de dados do personagem e persistência antes de implementar DataStore.


## Foundation 0.1 — revalidação — 2026-11-23

- Corrigida a idempotência por jogador em PlayerLifecycleService, incluindo a corrida entre conexão do evento e enumeração inicial.
- Adicionados casos automatizados Luau compartilhados entre runner do Studio e Lune/CI: 10 passaram no Studio; workflow do GitHub Actions executou os testes e o build Rojo com sucesso.
- Studio: place Lua Etérea! (89394300657763), versão 0.748.0.7481526; place salvo no Team Create como versão 4, não publicado.
- Ressalva: os testes de remoção e jogadores múltiplos usam sinais/jogadores simulados; não foi executada uma sessão live com múltiplos clientes.
- Checklist e relatório atualizados. PR #2 permanece aberta e em draft, sem merge.
