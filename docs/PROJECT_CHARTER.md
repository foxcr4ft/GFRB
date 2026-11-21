# Project Charter — Aethermoor

**Versão:** 1.0 (baseline de repositório)  
**Estado:** Consolidação de regras aprovadas e contexto confirmado  
**Projeto:** MMORPG original para Roblox, inspirado em Grand Fantasia

> Este arquivo é um índice normativo resumido. Não substitui os documentos completos aprovados no histórico do projeto. Onde o texto integral não está disponível nesta consolidação, não se presume recuperação literal.

## 1. Identidade e direção

- Criar um MMORPG original inspirado em Grand Fantasia, sem cópia literal de conteúdo protegido.
- Desenvolver para Roblox com arquitetura modular, expansível e multiplataforma.
- Considerar PC, dispositivos móveis, tablets e consoles compatíveis com Roblox desde o planejamento técnico inicial.
- Construir documentação e implementação em etapas controladas, preservando decisões aprovadas.

## 2. Arquitetura e autoridade

- Separar responsabilidades de cliente e servidor.
- O servidor é autoridade para resultados críticos: combate, dano, recompensas, inventário, economia, comércio, progressão e persistência.
- O cliente cuida de apresentação, entrada do jogador e efeitos locais; não pode decidir resultados críticos.
- Projetar sistemas modulares e integráveis, com contratos explícitos.
- Suportar mundo compartilhado e instâncias conforme as especificações do projeto.
- Segurança, integridade dos dados e prevenção de exploração são requisitos fundamentais.

## 3. Mundo e progressão territorial

- Aethermoor possui sete mapas com IDs permanentes.
- A sequência territorial e as faixas de nível registradas no Map Registry são a referência atual.
- Acesso geográfico e acesso ao conteúdo são conceitos distintos.
- É permitido explorar áreas perigosas quando o perigo estiver sinalizado de forma clara.
- A progressão pode usar chefes, missões, mecanismos, obstáculos, caminhos alternativos e barreiras narrativas.
- Não é obrigatório exigir derrota de chefe para toda travessia.
- Cooperação entre jogadores de níveis diferentes deve ser considerada.
- Contribuição em atividades cooperativas pode incluir dano, cura, suporte, proteção, controle e mecânicas/objetivos.
- Não existe um limiar universal de dano para definir contribuição; presença passiva não equivale automaticamente a contribuição válida.

## 4. Personagens, classes e combate

- Cinco famílias iniciais de classes.
- Especializações e troca gratuita de especialização conforme decisões aprovadas.
- Sistema completo de atributos, habilidades, talentos, equipamentos e progressão.
- Fórmulas e parâmetros numéricos precisam de definição e validação; não inventar valores.
- Combate e operações críticas devem ser validados no servidor.

## 5. Sprites, profissões e fabricação

- Dois Sprites ativos simultaneamente.
- Quatro profissões independentes: Mineração, Coleta, Caça e Reciclagem.
- Distinguir nível geral do Sprite e níveis profissionais.
- Preservar progressão individual dos Sprites.
- Coleta e fabricação devem integrar mundo, inventário e economia.
- Forja da Alma é um sistema complementar posterior, com requisitos de desenvolvimento profissional/capacidade e sem condição de monetização.
- Títulos de proficiência podem afetar tempo/qualidade conforme regras a especificar.
- O nome do Sprite produtor pode aparecer como autoria, sem conceder atributos automaticamente.

## 6. Itens, economia e monetização

- Equipamentos valiosos mantêm obtenção por drops específicos de chefes; não simplificar indevidamente sua aquisição.
- Itens vinculados precisam de aviso e identificação clara: negociável, vinculado ao personagem ou à conta.
- Transmog é cosmético e não concede atributos.
- Aceleradores pagos de fortificação/aprimoramento só podem acelerar processos; objetivos finais equivalentes devem ser alcançáveis sem pagamento.
- Não criar poder exclusivo pago nem influência econômica indevida.
- Não exigir monetização para acessar sistemas centrais.

## 7. Narrativa e conteúdo

- A narrativa e os sete mapas seguem o planejamento de Aethermoor.
- Cinco fragmentos: Fogo (mapa 3), Natureza (mapa 4), Memória (mapa 5), Água (mapa 6) e Alma (mapa 7).
- O jogador começa neutro em relação às três facções; escolhas narrativas podem alterar o apoio recebido.
- Eventos sazonais são temporários, anunciados e sem pagamento obrigatório; recompensas conquistadas devem permanecer com o jogador.
- Conteúdo sazonal e sistemas avançados podem ser faseados sem apagar seus requisitos aprovados.

## 8. Processo e qualidade

- Documentação aprovada é preservada; mudanças devem ser registradas por adendo/decisão.
- Distinguir reconstrução editorial de recuperação literal.
- Distinguir falta de evidência histórica de contradição real.
- Cada entrega de código deve registrar escopo, dependências, arquivos, testes, resultados e limitações.
- Não declarar código testado sem execução real do teste.
