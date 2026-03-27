import 'package:flutter/material.dart';

/// Lightweight UI shell for integration tests (no Modular, HTTP, or Firebase).
class FlowOneStart extends StatelessWidget {
  const FlowOneStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Integration landing'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const MainShellPage(),
                  ),
                );
              },
              child: const Text('Ir para principal'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Principal')),
      body: const Center(
        child: Text('Conteúdo principal do app'),
      ),
    );
  }
}

/// Fake login: any non-empty credentials navigate to a simple workspace.
class FakeLoginPage extends StatefulWidget {
  const FakeLoginPage({super.key});

  @override
  State<FakeLoginPage> createState() => _FakeLoginPageState();
}

class _FakeLoginPageState extends State<FakeLoginPage> {
  final _user = TextEditingController();
  final _pass = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _user.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _submit() {
    if (_user.text.isEmpty || _pass.text.isEmpty) {
      setState(() => _error = 'Preencha usuário e senha');
      return;
    }
    setState(() => _error = null);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const FakeWorkspacePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login (fake)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              key: const Key('login_user'),
              controller: _user,
              decoration: const InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              key: const Key('login_pass'),
              controller: _pass,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class FakeWorkspacePage extends StatefulWidget {
  const FakeWorkspacePage({super.key});

  @override
  State<FakeWorkspacePage> createState() => _FakeWorkspacePageState();
}

class _FakeWorkspacePageState extends State<FakeWorkspacePage> {
  final _item = TextEditingController();
  final List<String> _items = [];

  @override
  void dispose() {
    _item.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workspace')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              key: const Key('item_name'),
              controller: _item,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            ElevatedButton(
              onPressed: () {
                final t = _item.text.trim();
                if (t.isEmpty) return;
                setState(() {
                  _items.add(t);
                  _item.clear();
                });
              },
              child: const Text('Adicionar'),
            ),
            Expanded(
              child: ListView(
                children: _items
                    .map((e) => ListTile(title: Text(e)))
                    .toList(),
              ),
            ),
            const Text('Pedido salvo (fake)', key: Key('fake_saved_hint')),
          ],
        ),
      ),
    );
  }
}
