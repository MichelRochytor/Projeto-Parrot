import 'package:flutter/material.dart';
import '../models/plant_state.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/recommendations_screen.dart';
import '../screens/cloud_screen.dart';

class CustomDrawer extends StatelessWidget {
  final PlantState plantState;
  final String currentRoute;

  const CustomDrawer({
    super.key,
    required this.plantState,
    this.currentRoute = 'home',
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(36),
        bottomRight: Radius.circular(36),
      ),
      child: Drawer(
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(36),
            bottomRight: Radius.circular(36),
          ),
          side: BorderSide(color: Color(0xFF104862), width: 2),
        ),
        child: Container(
          color: const Color(0xFF0076DB),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho Branco Curvado
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 24, top: 48, bottom: 24, right: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(36),
                  ),
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF104862), width: 2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ícone do Parrot
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/icon/icone.png',
                        width: 62,
                        height: 62,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Nome da planta
                    Text(
                      plantState.plantName,
                      style: const TextStyle(
                        fontFamily: 'fredoka-bold',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // Itens de Navegação
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMenuItem(
                        context,
                        title: 'Início',
                        isSelected: currentRoute == 'home',
                        onTap: () {
                          Navigator.pop(context);
                          if (currentRoute != 'home') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HomeScreen(plantState: plantState),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 22),
                      _buildMenuItem(
                        context,
                        title: 'Configurações',
                        isSelected: currentRoute == 'settings',
                        onTap: () {
                          Navigator.pop(context);
                          if (currentRoute != 'settings') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SettingsScreen(plantState: plantState),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 22),
                      _buildMenuItem(
                        context,
                        title: 'Recomendações',
                        isSelected: currentRoute == 'recommendations',
                        onTap: () {
                          Navigator.pop(context);
                          if (currentRoute != 'recommendations') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RecommendationsScreen(plantState: plantState),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 22),
                      _buildMenuItem(
                        context,
                        title: 'Nuvem',
                        isSelected: currentRoute == 'cloud',
                        onTap: () {
                          Navigator.pop(context);
                          if (currentRoute != 'cloud') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CloudScreen(plantState: plantState),
                              ),
                            );
                          }
                        },
                      ),
                      const Spacer(),
                      // Botão Desconectar
                      InkWell(
                        onTap: () => _confirmLogout(context),
                        borderRadius: BorderRadius.circular(8),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Desconectar',
                            style: TextStyle(
                              fontFamily: 'fredoka-bold',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF0000),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'fredoka-bold',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isSelected ? const Color(0xFF06DC34) : Colors.white,
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF0076DB), width: 2),
        ),
        title: const Text(
          'Desconectar',
          style: TextStyle(
            fontFamily: 'fredoka-bold',
            fontSize: 22,
            color: Color(0xFF104862),
          ),
        ),
        content: const Text(
          'Deseja realmente encerrar a sessão do dispositivo?',
          style: TextStyle(fontFamily: 'fredoka', fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                fontFamily: 'fredoka-bold',
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF0000),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(dialogCtx); // Fecha o dialog
              Navigator.pop(context); // Fecha o drawer
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text(
              'Sair',
              style: TextStyle(fontFamily: 'fredoka-bold', fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
