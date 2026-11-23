# Aethermoor — Foundation 0.1: registro de integração e validação

**Data:** 2026-11-22 (America/Fortaleza)  
**PR:** [#2 — Foundation 0.1 — Roblox bootstrap and canonical map registry](https://github.com/foxcr4ft/GFRB/pull/2)  
**Studio:** Place1, modo Edit ao encerrar  
**Estado atual (2026-11-23):** correção integrada e validada; lugar salvo no Team Create (versão 4), não publicado; PR aberta em draft, sem merge.

## Inspeção prévia

- O local aberto era o Place1 padrão, não salvo na nuvem.
- O Workspace já continha Baseplate, SpawnLocation e Terrain. Esses itens foram preservados.
- ReplicatedStorage e ServerScriptService não tinham conteúdo de jogo preexistente; StarterPlayerScripts estava vazio.
- A PR adiciona configuração compartilhada, registro canônico de mapas, ciclo de vida mínimo do jogador, bootstraps, mapeamento Rojo e documentação/roteiro manual.

## Integrado no Roblox Studio

- `ReplicatedStorage.Shared.ProjectConfig` (ModuleScript)
- `ReplicatedStorage.Shared.MapRegistry` (ModuleScript)
- `ServerScriptService.Services.PlayerLifecycleService` (ModuleScript)
- `ServerScriptService.Bootstrap` (Script)
- `StarterPlayer.StarterPlayerScripts.ClientBootstrap` (LocalScript)

No primeiro Play Test do `Place1`, a sessão apresentou callbacks de entrada/saída duplicados e apliquei uma proteção de idempotência por jogador diretamente naquela sessão do Studio. Essa correção não foi incluída nos arquivos da PR e não foi revalidada como código da branch. A rechecagem posterior no lugar salvo na nuvem confirmou configuração, mapas, bootstrap e atributo de sessão; não repetiu o teste de idempotência.

Os documentos e `default.project.json` permanecem como arquivos do repositório da PR; não são nós executáveis do DataModel do Studio e não foram fabricados ou inseridos como scripts.

## Resultados do Studio

- **Servidor:** `[Aethermoor] Server bootstrap complete.` — PASS.
- **Cliente:** `[Aethermoor] Client initialized. Version 0.1.0` — PASS.
- **Configuração:** nome Aethermoor, versão 0.1.0 e tabela congelada — PASS.
- **Registro de mapas:** contagem 7; IDs 1–7 presentes, nomes correspondentes ao catálogo; entradas congeladas — PASS.
- **ID inválido:** ID 8 ausente e rejeitado — PASS.
- **Ciclo do jogador:** atributo `SessionInitialized=true` no jogador de teste — PASS.
- **Idempotência (Place1):** segunda chamada a `PlayerLifecycleService.Start()` sem efeitos duplicados na sessão após a alteração local — PASS. O comportamento da versão da branch da PR não foi validado.
- **Saída do jogador:** evento e log de saída observados ao encerrar Play Test — PASS.
- **Erros no Output:** nenhum erro de execução observado.
- **Persistência/DataStore:** não implementada nem chamada, conforme escopo da Foundation 0.1.
- **Testes Luau automatizados:** não executados; os checks acima foram validações diretas no Studio.

## Salvamento e publicação

O Studio retornou `NeedsUserAction`: Place1 nunca foi salvo e precisa de **File > Save to Roblox** ou **File > Save to File** uma vez. As alterações estão na sessão aberta, mas ainda não persistidas. Não fiz merge da PR nem publicação do jogo.

## Rechecagem em Studio — 2026-11-22

- Studio aberto agora: `Local de foxycraft203: 11222026_1`, placeId `89394300657763`, universeId `10778533298`.
- Estado: Play; `persistedToCloud=true`.
- Os módulos ProjectConfig/MapRegistry, o ClientBootstrap e a estrutura de servidor da Foundation 0.1 estão presentes no DataModel atual.
- Verificação executada no cliente: Aethermoor 0.1.0, MapCount 7, os sete IDs e nomes canônicos, e rejeição do ID 8 — PASS.
- Verificação executada no servidor: Bootstrap e PlayerLifecycleService presentes, jogador de teste com `SessionInitialized=true` — PASS.
- Output atual mostra o bootstrap do servidor e cliente, entrada do jogador e inicialização do cliente sem erro visível. O Output também conserva linhas de playtests anteriores, por isso essas linhas históricas aparecem junto ao teste atual.
- Play Test deixado em execução como encontrado; nenhuma alteração adicional, salvamento, merge ou publicação feita nesta rechecagem.



## Revalidação da correção e testes — 2026-11-23

Esta atualização substitui o status pendente registrado acima para a versão atual da branch. O primeiro Place1 e os eventos de 2026-11-22 permanecem como histórico; não são evidência para o código corrigido agora.

- Branch: implementation/foundation-0.1; commit validado no CI: f947e88f5ecd1bc62ce824eb1ecb758643e113eb.
- Studio: Lua Etérea!, placeId 89394300657763, versão 0.748.0.7481526.
- PlayerLifecycleService agora mantém uma tabela de jogadores já inicializados, conecta os sinais antes de enumerar os jogadores existentes e ignora entradas/saídas repetidas. Stop() desconecta os sinais; o serviço pode ser iniciado novamente.
- Play Test: bootstrap do servidor e cliente concluídos sem erro. Runner no servidor: 10 testes, 10 aprovados, 0 falhas.
- Cobertura: configuração compartilhada e imutável (2); mapas, IDs válidos/inválidos e cópia retornada (3); corrida de inicialização, Start() repetido, múltiplos jogadores simulados, saída duplicada com SessionInitialized=false, e Stop()/reinício (5).
- A asserção de saída e o cenário com jogadores distintos usam objetos/sinais simulados via dependência injetada. Não foi executado um teste de desconexão em uma sessão real de múltiplos clientes.
- GitHub Actions no commit acima: Luau tests and Rojo build — success (ambos os checks).
- O lugar foi salvo no Team Create como versão 4. Não foi publicado. A PR #2 segue aberta, em draft e sem merge.

