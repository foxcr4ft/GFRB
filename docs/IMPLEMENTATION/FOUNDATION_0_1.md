# Foundation 0.1 — Implementação inicial

**Branch:** `implementation/foundation-0.1`  
**Estado:** Implementado e validado em Roblox Studio e GitHub Actions (2026-11-23); PR aberta em draft.  
**Escopo:** Bootstrap mínimo, configuração compartilhada, registro canônico de mapas e ciclo de vida básico de jogador.

## Arquivos

- `src/ReplicatedStorage/Shared/ProjectConfig.luau`
- `src/ReplicatedStorage/Shared/MapRegistry.luau`
- `src/ServerScriptService/Services/PlayerLifecycleService.luau`
- `src/ServerScriptService/Bootstrap.server.luau`
- `src/StarterPlayer/StarterPlayerScripts/ClientBootstrap.client.luau`
- `default.project.json`
- `tests/manual/FOUNDATION_0_1.md`

## Decisões técnicas desta entrega

- A configuração compartilhada é somente leitura.
- Os sete IDs de mapa são permanentes e independentes do nome visível.
- O servidor inicializa o serviço de ciclo de vida do jogador.
- O cliente verifica a consistência básica da configuração e do registro.
- O atributo `SessionInitialized` indica somente que o hook de sessão foi executado.
- Nenhum dado pessoal, progresso, inventário ou personagem é persistido nesta etapa.

## Fora do escopo

DataStore, bloqueio de sessão, criação de personagem, classes, atributos, experiência, combate, inventário, Sprites, missões, economia e UI de jogo.

Esses sistemas dependem de contratos e regras específicos; não serão inventados nesta fundação.

## Validação

- Revisão estrutural dos arquivos: realizada nesta entrega.
- Execução em Roblox Studio: 10/10 testes automatizados passaram; bootstrap servidor/cliente sem erro.
- GitHub Actions: suíte Luau e build Rojo passaram no commit f947e88f5ecd1bc62ce824eb1ecb758643e113eb.
- A saída com SessionInitialized=false e entradas de múltiplos jogadores foram verificadas com sinais simulados; não houve teste live de múltiplos clientes.
- Resultados detalhados: tests/manual/FOUNDATION_0_1.md e docs/IMPLEMENTATION/FOUNDATION_0_1_STUDIO_VALIDATION.md.

## Próxima etapa

Integrar os documentos integrais disponíveis e fechar o contrato técnico de dados de personagem/persistência antes de escrever o serviço DataStore.
