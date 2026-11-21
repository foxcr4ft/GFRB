# Protocolo de Recuperação do Acervo — Aethermoor

## Objetivo
Consolidar progressivamente no GitHub os materiais encontrados nas conversas anteriores, evitando perdas futuras.

## Estados obrigatórios de recuperação
- **Literal integral:** texto original recuperado integralmente, sem alterações.
- **Literal parcial:** trecho original recuperado, mas o documento está incompleto.
- **Resumo contextual:** informação preservada em resumo de contexto, sem corpo original.
- **Reconstrução editorial:** texto recomposto a partir de evidências incompletas; nunca confundir com original.
- **Não localizado:** nenhuma fonte suficiente encontrada até o momento.
- **Pendente de validação:** há divergência ou dúvida que exige decisão do usuário.

## Procedimento para cada material encontrado
1. Identificar documento/bloco, versão, data, estado de aprovação e conversa de origem.
2. Preservar literalmente o texto encontrado, incluindo alterações feitas pelo usuário.
3. Registrar a natureza da fonte e as lacunas.
4. Salvar o material em arquivo próprio sob `docs/recovered/` ou pasta temática apropriada.
5. Atualizar `docs/DOCUMENT_CATALOG.md` com estado, versão, localização e fidelidade.
6. Atualizar `docs/RECOVERY/RECOVERY_REGISTER_0_1.md` com a recuperação realizada.
7. Fazer commits em branch documental e abrir PR para revisão; não fazer merge automático.

## Restrições
- Não repetir as auditorias 1, 2 e 3 já concluídas.
- Não substituir documentos aprovados por reconstruções.
- Não tratar IDs, títulos ou resumos como se fossem o corpo integral.
- Não promover propostas não aprovadas a regras oficiais.
- Não desenvolver sistemas de jogo que dependam de contratos/regras ainda não recuperados, salvo autorização explícita para usar uma especificação provisória.

## Ordem inicial
1. Seis blocos de documentação, com prioridade ao Bloco 2 em sua última versão editada pelo usuário.
2. Documentos 01–18.
3. Relatório consolidado e matrizes de rastreabilidade.
4. Adendos, listas de requisitos e decisões pontuais.
