Você é um engenheiro Flutter sênior focado em testes automatizados. Quero que você implemente uma base completa de testes no meu projeto Flutter existente, de forma incremental e sem refatorações grandes, priorizando cobertura de regressão pós-upgrade.

OBJETIVO
1) Configurar e criar uma suíte de testes com:
   - Unit tests (regras/serviços/mappers)
   - Widget tests (telas e componentes críticos)
   - Integration tests (fluxos E2E principais)
2) Garantir que todos os testes rodem via CLI e passem localmente.
3) Adicionar um arquivo de documentação TESTING.md com comandos e boas práticas para o time.

REGRAS IMPORTANTES
- Não faça mudanças arquiteturais grandes.
- Se precisar alterar código de produção, mantenha alterações mínimas (injeção de dependência por construtor, wrappers/adapters simples, etc.).
- Evite testar plugins diretamente; crie interfaces/adapters e use mocks/fakes.
- Os testes devem ser determinísticos (sem depender de rede real, tempo real, delays frágeis).
- Prefira mocktail para mocks.
- Se houver chamadas HTTP, usar HttpOverrides / mock client / repositório fake.
- Se houver storage (SharedPreferences/SecureStorage), criar um StorageAdapter e mockar.
- Sempre que encontrar flakiness, estabilize (pumpAndSettle com cuidado, waits explícitos, seeds fixas).

PASSO A PASSO (EXECUTE)
A) Inspeção do projeto
1. Identifique:
   - Gerenciamento de estado (Provider/Riverpod/Bloc/GetX/SetState)
   - Camada de dados (HTTP, Dio, GraphQL etc.)
   - Principais features/telas e rotas
   - Pontos críticos pós-upgrade (erros recorrentes)
2. Liste (no final) o que foi escolhido como “fluxos críticos” e “módulos críticos”.

B) Dependências e configuração
1. Atualize pubspec.yaml adicionando dev_dependencies:
   - flutter_test (já vem)
   - mocktail
   - integration_test (SDK)
   - fake_async (se precisar lidar com timers)
   - golden_toolkit (opcional, só se fizer golden)
2. Crie/ajuste:
   - test/helpers/ (mocks, fakes, builders)
   - test/test_config.dart (setup padrão)
   - integration_test/ (estrutura E2E)
3. Garanta que `flutter test` rode sem falhar.

C) Unit tests (mínimo viável)
1. Crie pelo menos 6 unit tests cobrindo:
   - Pelo menos 2 mappers (JSON -> Model e Model -> JSON)
   - Pelo menos 2 validações (ex.: email/senha/campos obrigatórios)
   - Pelo menos 2 services/usecases (ex.: login, carregar lista, salvar entidade)
2. Use mocktail para dependências (repositories/clients).
3. Se não existir camada separada, crie funções utilitárias pequenas e testáveis com mudanças mínimas.

D) Widget tests (mínimo viável)
1. Crie pelo menos 4 widget tests cobrindo:
   - Renderização inicial de 2 telas principais
   - Interação (tap, input) e mudança de estado em 2 casos
2. Use pumps adequados:
   - pumpWidget com MaterialApp
   - pumpAndSettle com cuidado
3. Se houver navegação, teste routes e transitions de forma estável.

E) Integration tests (fluxos críticos)
1. Crie pelo menos 2 testes E2E em integration_test/:
   - Fluxo 1: abrir app -> navegar para tela principal -> validar conteúdo
   - Fluxo 2: login (com fake backend) -> navegar -> criar/editar algo -> verificar
2. Não usar backend real. Crie FakeRepository/FakeApi e injete no app (por main_test.dart, flags, ou um AppFactory).
3. Garanta comando de execução:
   - `flutter test integration_test`

F) CI (opcional, mas se o projeto tiver GitHub)
1. Se houver .github/workflows, adicione workflow rodando:
   - flutter analyze
   - flutter test
   - flutter test integration_test
2. Se não houver CI, apenas crie um exemplo de workflow comentado em docs/ci_flutter.yml.

G) Documentação
Crie TESTING.md com:
- Como rodar unit/widget: `flutter test`
- Como rodar integration: `flutter test integration_test`
- Como depurar testes
- Como escrever novos tests (padrões do projeto)
- Boas práticas anti-flake

CRITÉRIOS DE ACEITE
- Testes criados e passando.
- Estrutura organizada.
- Sem dependência de rede real.
- Mudanças mínimas em produção, bem justificadas em comentários (em inglês).
- Entregue um resumo final com:
  - Lista de arquivos criados/alterados
  - Como rodar
  - Próximos passos (o que aumentar de cobertura)

AGORA EXECUTE
1) Comece verificando o pubspec.yaml e a estrutura do projeto.
2) Em seguida implemente as mudanças e testes.
3) Rode os testes e corrija falhas até passar.