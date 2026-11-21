# Decision Register — Decisões, propostas e pendências

**Versão:** 1.0 (baseline)  
**Legenda:** APROVADO = regra confirmada; PROPOSTA = ainda depende de aprovação; PENDENTE = falta especificação/decisão; IMPLEMENTADO = existe no repositório; TESTADO = validado por execução documentada.

## A. Decisões aprovadas

| ID | Decisão | Estado |
|---|---|---|
| DEC-001 | MMORPG original inspirado em Grand Fantasia, sem cópia literal | APROVADO |
| DEC-002 | Roblox multiplataforma: PC, mobile, tablet e consoles compatíveis | APROVADO |
| DEC-003 | Arquitetura modular e expansível | APROVADO |
| DEC-004 | Separação cliente-servidor; servidor autoritativo em operações críticas | APROVADO |
| DEC-005 | Sete mapas com IDs permanentes | APROVADO |
| DEC-006 | Cinco famílias iniciais de classes | APROVADO |
| DEC-007 | Troca gratuita de especialização | APROVADO |
| DEC-008 | Dois Sprites ativos simultaneamente | APROVADO |
| DEC-009 | Quatro profissões: Mineração, Coleta, Caça e Reciclagem | APROVADO |
| DEC-010 | Acesso geográfico distinto de acesso ao conteúdo | APROVADO |
| DEC-011 | Cooperação entre níveis diferentes | APROVADO |
| DEC-012 | Contribuição cooperativa não se limita a dano | APROVADO |
| DEC-013 | Equipamentos valiosos ligados a drops específicos de chefes | APROVADO |
| DEC-014 | Transmog puramente cosmético | APROVADO |
| DEC-015 | Aceleradores pagos não podem criar poder exclusivo | APROVADO |
| DEC-016 | Identificação/aviso de itens vinculados | APROVADO |
| DEC-017 | Nome do Sprite produtor como autoria, sem bônus automático de atributos | APROVADO |
| DEC-018 | Forja da Alma sem requisito de monetização | APROVADO |

## B. Referências documentais aprovadas

| Documento | Situação registrada |
|---|---|
| Doc 01 — Visão Geral e Identidade v1.0 | Aprovado |
| Doc 02 — Pesquisa Comparativa de Grand Fantasia v1.0-R | Aprovado como reconstrução editorial |
| Doc 03 — Mundo e Exploração v1.0 | Aprovado |
| Doc 04 — Requisitos | Requisitos identificados e aprovados em conjuntos registrados |
| Doc 10 — Multiplayer e Guildas v0.1 | Aprovado |
| Doc 11 — Interface e UX v0.1 | Aprovado como reconstrução editorial |
| Doc 12 — Arquitetura Técnica Roblox v0.1 | Aprovado |
| Doc 13 — Persistência e Segurança v0.1 | Aprovado |
| Doc 15 — Plano de Desenvolvimento v0.1 | Aprovado |
| Doc 16 — Testes, QA e Preparação para Lançamento v1.0 | Escopo/aprovação confirmados; texto integral não recuperado nesta baseline |
| Doc 17 — Operação Contínua e Governança v1.0 | Escopo/aprovação confirmados; texto integral não recuperado nesta baseline |
| Doc 18 v1.1 | Aprovado; preservar e usar adendos |

Documentos 05–09 e 14: existem referências históricas, mas a versão integral deve ser incorporada quando estiver disponível. Não inferir seu conteúdo integral.

## C. Propostas não aprovadas

| ID | Proposta | Estado |
|---|---|---|
| PROP-001 | Adendo de reconciliação de lore Aethermoor v0.3 | PROPOSTA; não tratar como aprovado |
| PROP-002 | Escopo exato de mapas totalmente jogáveis no primeiro lançamento | PROPOSTA a decidir |
| PROP-003 | Ordem detalhada de implementação por fases | PROPOSTA técnica sujeita a ajuste |

## D. Pendências de especificação

| ID | Pendência | Resultado necessário |
|---|---|---|
| OPEN-001 | Escopo de conteúdo do MVP | Lista aprovada de mapas, missões, inimigos, chefes e atividades iniciais |
| OPEN-002 | Classes e especializações | Nomes oficiais, funções e catálogo inicial |
| OPEN-003 | Atributos | Lista, fórmulas, valores iniciais e evolução |
| OPEN-004 | Combate | Dano, defesa, críticos, resistências, alcance, cooldowns e demais fórmulas |
| OPEN-005 | Habilidades | Catálogo, custos, efeitos, escalas e desbloqueios |
| OPEN-006 | Equipamentos | Slots, categorias, raridades, atributos e requisitos |
| OPEN-007 | Aprimoramento | Custos, probabilidades, falhas e proteções |
| OPEN-008 | Inventário | Capacidade, pilhas, armazenamento e regras de descarte |
| OPEN-009 | Sprites | Parâmetros de combate, autonomia, bem-estar e comandos |
| OPEN-010 | Profissões | Curvas, proficiências, tempos e qualidade |
| OPEN-011 | Fabricação | Receitas, materiais, custos e resultados |
| OPEN-012 | Economia | Moedas, fontes, sumidouros e limites |
| OPEN-013 | Missões e facções | Requisitos, reputação, escolhas e recompensas |
| OPEN-014 | Multiplayer | Tamanho de grupos, distribuição de recompensas e instâncias |
| OPEN-015 | Persistência | Modelo de dados, salvamento, recuperação e migração |
| OPEN-016 | Segurança | Matriz de validação, limites, telemetria e resposta |
| OPEN-017 | Desempenho | Metas por plataforma, população e orçamento de recursos |
| OPEN-018 | Testes | Casos, critérios de aceitação e ambientes |
| OPEN-019 | Operação | Publicação, monitoramento, rollback e suporte |

## E. Regra de atualização

Toda decisão nova deve registrar: ID, data, descrição, origem, estado, documentos afetados, impacto no código e eventual aprovação do usuário. Uma proposta não muda para APROVADO sem confirmação explícita.
