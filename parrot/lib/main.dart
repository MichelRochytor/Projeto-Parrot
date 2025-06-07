import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Parrot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TelaAnimacao(),
    );
  }
}

class TelaAnimacao extends StatefulWidget {
  const TelaAnimacao({super.key});

  @override
  State<TelaAnimacao> createState() => _TelaAnimacaoState();
}

class _TelaAnimacaoState extends State<TelaAnimacao>
    with TickerProviderStateMixin {
  late final AnimationController controladorAnimacao;

  @override
  void initState() {
    super.initState();
    controladorAnimacao = AnimationController(vsync: this);

    controladorAnimacao.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TelaImagemEAnimacao()),
        );
      }
    });
  }

  @override
  void dispose() {
    controladorAnimacao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/abertura.json',
          controller: controladorAnimacao,
          onLoaded: (composicao) {
            controladorAnimacao
              ..duration = composicao.duration
              ..forward();
          },
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}

class TelaImagemEAnimacao extends StatefulWidget {
  const TelaImagemEAnimacao({super.key});

  @override
  State<TelaImagemEAnimacao> createState() => _TelaImagemEAnimacaoState();
}

class _TelaImagemEAnimacaoState extends State<TelaImagemEAnimacao>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controladorAnimacao;

  @override
  void initState() {
    super.initState();
    _controladorAnimacao = AnimationController(vsync: this);

    _controladorAnimacao.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          _controladorAnimacao.value > 0.89) {
        _controladorAnimacao.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controladorAnimacao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Conteúdo principal
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Imagem no topo
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/image/imagem.png',
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Texto "Bem-vindo"
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Bem-vindo!',
                      style: TextStyle(
                        fontFamily: 'fredoka-bold',
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 117, 216, 1),
                      ),
                    ),
                  ),

                  // Animação centralizada
                  Expanded(
                    child: Center(
                      child: Lottie.asset(
                        'assets/papaguaio.json',
                        controller: _controladorAnimacao,
                        onLoaded: (composicao) {
                          _controladorAnimacao
                            ..duration = composicao.duration
                            ..forward();
                        },
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Botão no canto inferior direito
            Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TelaPrincipal(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Primeiros passos'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar flutuante personalizada
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Builder(
        // Usar Builder aqui para obter o contexto certo do Scaffold
        builder:
            (context) => Container(
              height: 50,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.only(left: 10, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      size: 28,
                      color: Colors.black87,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Center(
                      //alignment: Alignment.center,
                      child: Image.asset(
                        'assets/image/imagem.png',
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),

      // Drawer lateral
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              //padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 2.0),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // Corpo principal
      body: Center(
        child: Text(
          'Conteúdo principal da tela',
          style: TextStyle(fontSize: 20, color: Colors.grey[800]),
        ),
      ),
    );
  }
}
