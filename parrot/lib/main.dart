// Projeto Parrot v1.0
// Desenvolvido por: Michel Rochytor
// Interface fiel ao documento do projeto (Projeto Parrot)

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'models/plant_state.dart';
import 'screens/home_screen.dart';

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
      theme: ThemeData(
        fontFamily: 'fredoka',
        primaryColor: const Color(0xFF0076DB),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0076DB),
          primary: const Color(0xFF0076DB),
          secondary: const Color(0xFF06DC34),
        ),
      ),
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
        controladorAnimacao.dispose();
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
  final PlantState _plantState = PlantState();

  @override
  void initState() {
    super.initState();
    _controladorAnimacao = AnimationController(vsync: this);

    _controladorAnimacao.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
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
                        'assets/animation/papaguaio.json',
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
                      builder: (context) => HomeScreen(plantState: _plantState),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Primeiros passos',
                      style: TextStyle(fontFamily: 'fredoka-bold'),
                    ),
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
