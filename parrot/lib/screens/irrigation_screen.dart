import 'package:flutter/material.dart';
import '../models/plant_state.dart';
import '../widgets/custom_app_bar.dart';

class IrrigationScreen extends StatefulWidget {
  final PlantState plantState;

  const IrrigationScreen({
    super.key,
    required this.plantState,
  });

  @override
  State<IrrigationScreen> createState() => _IrrigationScreenState();
}

class _IrrigationScreenState extends State<IrrigationScreen> {
  late double _startThreshold;
  late double _stopThreshold;
  late double _maxDuration;
  bool _isManualPumping = false;

  @override
  void initState() {
    super.initState();
    _startThreshold = widget.plantState.autoWateringThreshold;
    _stopThreshold = widget.plantState.autoWateringStopThreshold;
    _maxDuration = widget.plantState.maxPumpDurationSeconds.toDouble();
  }

  void _triggerManualWatering() {
    setState(() => _isManualPumping = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Bomba de irrigação acionada!',
          style: TextStyle(fontFamily: 'fredoka'),
        ),
        backgroundColor: Color(0xFF06DC34),
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isManualPumping = false);
      }
    });
  }

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
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/header_can.png',
                        height: 28,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Parâmetros do Regador',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Atual da Irrigação
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF0076DB), width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Irrigação Automática:',
                              style: TextStyle(
                                fontFamily: 'fredoka-bold',
                                fontSize: 18,
                                color: Color(0xFF104862),
                              ),
                            ),
                            Switch(
                              value: widget.plantState.isWateringOn,
                              activeThumbColor: const Color(0xFF06DC34),
                              onChanged: (val) {
                                widget.plantState.toggleWatering();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Limiar de início
                      _buildSliderCard(
                        title: 'Limiar para Acionamento',
                        subtitle: 'Rega ao atingir umidade inferior a:',
                        value: _startThreshold,
                        min: 10,
                        max: 50,
                        unit: '%',
                        onChanged: (val) => setState(() => _startThreshold = val),
                      ),

                      const SizedBox(height: 16),

                      // Limiar de parada
                      _buildSliderCard(
                        title: 'Limiar de Parada',
                        subtitle: 'Interrompe a rega ao atingir:',
                        value: _stopThreshold,
                        min: 50,
                        max: 90,
                        unit: '%',
                        onChanged: (val) => setState(() => _stopThreshold = val),
                      ),

                      const SizedBox(height: 16),

                      // Duração máxima
                      _buildSliderCard(
                        title: 'Duração Máxima de Segurança',
                        subtitle: 'Tempo limite da bomba ligado:',
                        value: _maxDuration,
                        min: 10,
                        max: 120,
                        unit: 's',
                        onChanged: (val) => setState(() => _maxDuration = val),
                      ),

                      const SizedBox(height: 24),

                      // Botão Acionar Regador Manual
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isManualPumping
                                ? Colors.grey
                                : const Color(0xFF0076DB),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                color: Color(0xFF104862),
                                width: 2,
                              ),
                            ),
                          ),
                          onPressed: _isManualPumping ? null : _triggerManualWatering,
                          icon: const Icon(Icons.water_drop),
                          label: Text(
                            _isManualPumping ? 'Regando...' : 'Regar Agora Manualmente',
                            style: const TextStyle(
                              fontFamily: 'fredoka-bold',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Botão Salvar
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
                          onPressed: () {
                            widget.plantState.updateIrrigationSettings(
                              startThreshold: _startThreshold,
                              stopThreshold: _stopThreshold,
                              maxDuration: _maxDuration.toInt(),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Configurações de irrigação salvas!',
                                  style: TextStyle(fontFamily: 'fredoka'),
                                ),
                                backgroundColor: Color(0xFF06DC34),
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Salvar Alterações',
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

  Widget _buildSliderCard({
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required String unit,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF104862), width: 2),
      ),
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
                  fontSize: 18,
                  color: Color(0xFF104862),
                ),
              ),
              Text(
                '${value.toInt()}$unit',
                style: const TextStyle(
                  fontFamily: 'fredoka-bold',
                  fontSize: 20,
                  color: Color(0xFF0076DB),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'fredoka',
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            activeColor: const Color(0xFF0076DB),
            inactiveColor: Colors.grey.shade300,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
