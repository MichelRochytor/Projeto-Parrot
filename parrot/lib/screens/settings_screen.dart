import 'package:flutter/material.dart';
import '../models/plant_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import 'irrigation_screen.dart';
import 'cloud_screen.dart';
import 'manual_config_screen.dart';

class SettingsScreen extends StatefulWidget {
  final PlantState plantState;

  const SettingsScreen({
    super.key,
    required this.plantState,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    widget.plantState.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    widget.plantState.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.plantState;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(
        plantState: state,
        currentRoute: 'settings',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            children: [
              // Card Principal com Borda Azul
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF7EE),
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(
                    color: const Color(0xFF0076DB),
                    width: 3.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Cabeçalho Azul com "Rosa do Deserto" e regador
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0076DB),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              state.plantName,
                              style: const TextStyle(
                                fontFamily: 'fredoka-bold',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/icons/header_can.png',
                                height: 28,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                state.isWateringOn ? 'on' : 'off',
                                style: TextStyle(
                                  fontFamily: 'fredoka-bold',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: state.isWateringOn
                                      ? const Color(0xFF06DC34)
                                      : Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Conteúdo interno
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Aba "Configurações"
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0076DB),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xFF104862),
                                width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Configurações',
                                style: TextStyle(
                                  fontFamily: 'fredoka-bold',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Quadro de Opções (Regador, Nuvem IoT, Config. Manual)
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF7EE),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color(0xFF104862),
                                width: 2.5,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 26,
                            ),
                            child: Column(
                              children: [
                                _buildGreenButton(
                                  title: 'Regador',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            IrrigationScreen(plantState: state),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                _buildGreenButton(
                                  title: 'Nuvem IoT',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CloudScreen(plantState: state),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                _buildGreenButton(
                                  title: 'Config. Manual',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ManualConfigScreen(plantState: state),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Botão Voltar
                          _buildGreenButton(
                            title: 'Voltar',
                            onPressed: () => Navigator.pop(context),
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreenButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF06DC34),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF104862),
          width: 2.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'fredoka-bold',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
