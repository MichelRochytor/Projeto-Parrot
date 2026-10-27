import 'package:flutter/material.dart';
import '../models/plant_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import 'irrigation_screen.dart';

class HomeScreen extends StatefulWidget {
  final PlantState plantState;

  const HomeScreen({
    super.key,
    required this.plantState,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        currentRoute: 'home',
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
                    // Cabeçalho Azul: Rosa do Deserto + Regador Status
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
                          // Botão Regador / Status on/off
                          GestureDetector(
                            onTap: () {
                              state.toggleWatering();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    state.isWateringOn
                                        ? 'Irrigação automática ativada (ON)'
                                        : 'Irrigação automática desativada (OFF)',
                                    style: const TextStyle(fontFamily: 'fredoka'),
                                  ),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: const Color(0xFF0076DB),
                                ),
                              );
                            },
                            child: Row(
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
                          ),
                        ],
                      ),
                    ),

                    // Conteúdo interno do Card
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          // Linha 1: Temperatura e Umidade
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Coluna Temperatura
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Temperatura',
                                      style: TextStyle(
                                        fontFamily: 'fredoka-bold',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Card da ilustração com badge de temperatura
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Container(
                                        height: 165,
                                        width: double.infinity,
                                        color: const Color(0xFFFAF7EE),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Image.asset(
                                              'assets/image/temp_beach.png',
                                              fit: BoxFit.cover,
                                            ),
                                            // Se a temperatura for diferente de 32°C, sobrepõe o pill dinâmico
                                            if (state.temperature != 32.0)
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 14,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF104862),
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(
                                                      color: const Color(0xFF042433),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    '${state.temperature.toStringAsFixed(0)}°C',
                                                    style: const TextStyle(
                                                      fontFamily: 'fredoka-bold',
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 14),

                              // Coluna Umidade
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Umidade',
                                      style: TextStyle(
                                        fontFamily: 'fredoka-bold',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 165,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFAF7EE),
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          color: const Color(0xFF0076DB),
                                          width: 3.5,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Sensor do Solo
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/icons/icon_probe.png',
                                                  height: 62,
                                                  fit: BoxFit.contain,
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '${state.soilHumidity.toStringAsFixed(0)}%',
                                                  style: const TextStyle(
                                                    fontFamily: 'fredoka-bold',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Sensor do Ar
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/icons/icon_waves.png',
                                                  height: 62,
                                                  fit: BoxFit.contain,
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '${state.airHumidity.toStringAsFixed(0)}%',
                                                  style: const TextStyle(
                                                    fontFamily: 'fredoka-bold',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Dashboard de Métricas Avançadas
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF7EE),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: const Color(0xFF0076DB),
                                width: 3.5,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 18,
                            ),
                            child: Column(
                              children: [
                                // Linha 1 de Métricas (4 colunas)
                                Row(
                                  children: [
                                    _buildMetricItem(
                                      iconPath: 'assets/icons/metric_stress.png',
                                      value: '${state.waterStress.toStringAsFixed(1)}/5',
                                      title: 'Estresse Hídrico',
                                      explanation:
                                          'Índice de estresse hídrico da planta (0 a 5). Valores > 3.0 indicam necessidade de atenção.',
                                    ),
                                    _buildMetricItem(
                                      iconPath: 'assets/icons/metric_need.png',
                                      value: state.waterNeed,
                                      title: 'Necessidade de Água',
                                      explanation:
                                          'Estimativa da evapotranspiração da planta por metro quadrado.',
                                    ),
                                    _buildMetricItem(
                                      iconPath: 'assets/icons/metric_urgent.png',
                                      value: state.wateringMoment,
                                      title: 'Momento Ideal',
                                      explanation:
                                          'Ação imediata com base no limiar de umidade do solo.',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                IrrigationScreen(plantState: state),
                                          ),
                                        );
                                      },
                                    ),
                                    _buildMetricItem(
                                      iconPath: 'assets/icons/metric_disease.png',
                                      value: state.diseaseRisk,
                                      title: 'Risco de Doenças',
                                      explanation:
                                          'Probabilidade de proliferação de fungos (míldio) por umidade e calor.',
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 22),

                                // Linha 2 de Métricas (4 colunas)
                                Row(
                                  children: [
                                    _buildMetricItem(
                                      iconPath: 'assets/icons/metric_photo.png',
                                      value: '${state.photosynthesisHours.toStringAsFixed(1)}h',
                                      title: 'Fotossíntese',
                                      explanation:
                                          'Horas de fotossíntese eficiente no dia (temperatura 20-28°C e umidade 40-70%).',
                                    ),
                                    _buildMetricItem(
                                      iconPath: 'assets/icons/metric_growth.png',
                                      value: '${state.growthPercent}%',
                                      title: 'Crescimento Estimado',
                                      explanation:
                                          'Taxa de desenvolvimento semanal estimada para as condições atuais.',
                                    ),
                                    _buildMetricItem(
                                      iconPath: 'assets/icons/metric_frost.png',
                                      value: state.frostForecast ? 'Sim' : 'Não',
                                      title: 'Previsão de Geada',
                                      explanation:
                                          'Alerta calculado com base na temperatura mínima e ponto de orvalho.',
                                    ),
                                    _buildMetricItem(
                                      iconPath: 'assets/icons/metric_recovery.png',
                                      value: '${state.recoveryTimeMinutes}min',
                                      title: 'Tempo de Recuperação',
                                      explanation:
                                          'Tempo decorrido para a planta atingir umidade ideal após última rega.',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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

  Widget _buildMetricItem({
    required String iconPath,
    required String value,
    required String title,
    required String explanation,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap ??
            () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (ctx) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(iconPath, height: 36),
                          const SizedBox(width: 12),
                          Text(
                            title,
                            style: const TextStyle(
                              fontFamily: 'fredoka-bold',
                              fontSize: 20,
                              color: Color(0xFF0076DB),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Valor atual: $value',
                        style: const TextStyle(
                          fontFamily: 'fredoka-bold',
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        explanation,
                        style: const TextStyle(
                          fontFamily: 'fredoka',
                          fontSize: 15,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              );
            },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 48,
              child: Image.asset(
                iconPath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'fredoka-bold',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
