import 'package:flutter/material.dart';
import '../models/plant_state.dart';
import '../widgets/custom_app_bar.dart';

class RecommendationsScreen extends StatelessWidget {
  final PlantState plantState;

  const RecommendationsScreen({
    super.key,
    required this.plantState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        showBackButton: true,
        onBack: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFAF7EE),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: const Color(0xFF0076DB), width: 3.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Azul
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0076DB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.yellowAccent, size: 28),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Recomendações Práticas',
                          style: TextStyle(
                            fontFamily: 'fredoka-bold',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      _buildRecommendationCard(
                        iconPath: 'assets/icons/metric_frost.png',
                        title: 'Alerta de Geada',
                        description: plantState.frostForecast
                            ? 'A previsão indica risco de geada nas próximas horas. Considere mover sua ${plantState.plantName} para um local protegido ou cobri-la esta noite.'
                            : 'Sem risco iminente de geada. Condições térmicas seguras para a planta.',
                        isUrgent: plantState.frostForecast,
                      ),
                      const SizedBox(height: 16),
                      _buildRecommendationCard(
                        iconPath: 'assets/icons/metric_urgent.png',
                        title: 'Manejo de Irrigação',
                        description: plantState.soilHumidity < plantState.autoWateringThreshold
                            ? 'A umidade do solo está em ${plantState.soilHumidity.toInt()}%, abaixo do ideal. A rega é recomendada com urgência para evitar murcha.'
                            : 'A umidade do solo está adequada (${plantState.soilHumidity.toInt()}%). O solo retém umidade suficiente para a transpiração.',
                        isUrgent: plantState.soilHumidity < plantState.autoWateringThreshold,
                      ),
                      const SizedBox(height: 16),
                      _buildRecommendationCard(
                        iconPath: 'assets/icons/metric_photo.png',
                        title: 'Eficiência de Fotossíntese',
                        description:
                            'Foram acumuladas ${plantState.photosynthesisHours}h em faixa térmica e de umidade favorável (20°C a 28°C e 40% a 70% UR). Mantenha boa incidência de luminosidade.',
                        isUrgent: false,
                      ),
                      const SizedBox(height: 16),
                      _buildRecommendationCard(
                        iconPath: 'assets/icons/metric_disease.png',
                        title: 'Sanidade e Risco Fitossanitário',
                        description:
                            'O risco de doenças fúngicas (como míldio) está avaliado como ${plantState.diseaseRisk}. Mantenha a circulação de ar adequada no ambiente.',
                        isUrgent: plantState.diseaseRisk.toLowerCase() == 'alto',
                      ),
                      const SizedBox(height: 20),
                      // Botão Voltar
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF06DC34),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                color: Color(0xFF104862),
                                width: 2.5,
                              ),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Voltar ao Início',
                            style: TextStyle(
                              fontFamily: 'fredoka-bold',
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard({
    required String iconPath,
    required String title,
    required String description,
    required bool isUrgent,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUrgent ? const Color(0xFFFF3B30) : const Color(0xFF104862),
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(iconPath, height: 42, fit: BoxFit.contain),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'fredoka-bold',
                        fontSize: 17,
                        color: Color(0xFF104862),
                      ),
                    ),
                    if (isUrgent)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Atenção',
                          style: TextStyle(
                            fontFamily: 'fredoka-bold',
                            fontSize: 11,
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'fredoka',
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
