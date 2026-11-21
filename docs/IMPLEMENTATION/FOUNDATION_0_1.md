# Foundation 0.1 — Implementação inicial

**Branch:** `implementation/foundation-0.1`  
**Estado:** Implementado no repositório; teste em Roblox Studio pendente.  
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
- Execução em Roblox Studio: pendente.
- Testes automatizados Luau: não executados neste ambiente.
- Critérios e procedimento: `tests/manual/FOUNDATION_0_1.md`.

## Próxima etapa

Integrar os documentos integrais disponíveis e fechar o contrato técnico de dados de personagem/persistência antes de escrever o serviço DataStore.
