import 'package:flutter/material.dart';
import '../models/plant_state.dart';
import '../widgets/custom_app_bar.dart';

class ManualConfigScreen extends StatefulWidget {
  final PlantState plantState;

  const ManualConfigScreen({
    super.key,
    required this.plantState,
  });

  @override
  State<ManualConfigScreen> createState() => _ManualConfigScreenState();
}

class _ManualConfigScreenState extends State<ManualConfigScreen> {
  late TextEditingController _plantNameController;
  late double _simulatedTemp;
  late double _simulatedSoil;
  late double _simulatedAir;

  @override
  void initState() {
    super.initState();
    _plantNameController = TextEditingController(text: widget.plantState.plantName);
    _simulatedTemp = widget.plantState.temperature;
    _simulatedSoil = widget.plantState.soilHumidity;
    _simulatedAir = widget.plantState.airHumidity;
  }

  @override
  void dispose() {
    _plantNameController.dispose();
    super.dispose();
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
                  child: const Row(
                    children: [
                      Icon(Icons.tune, color: Colors.white, size: 28),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Configuração Manual',
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
                      // Nome da Espécie / Planta
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF104862), width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nome da Espécie / Planta:',
                              style: TextStyle(
                                fontFamily: 'fredoka-bold',
                                fontSize: 16,
                                color: Color(0xFF104862),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _plantNameController,
                              style: const TextStyle(
                                fontFamily: 'fredoka-bold',
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.eco, color: Color(0xFF06DC34)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Simulação e Calibração dos Sensores
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF104862), width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Simulador / Calibração de Sensores',
                              style: TextStyle(
                                fontFamily: 'fredoka-bold',
                                fontSize: 17,
                                color: Color(0xFF104862),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Ajuste os valores para testar o cálculo automático de estresse e alertas:',
                              style: TextStyle(
                                fontFamily: 'fredoka',
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Slider Temp
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Temperatura do Ar:', style: TextStyle(fontFamily: 'fredoka-bold')),
                                Text('${_simulatedTemp.toStringAsFixed(0)}°C', style: const TextStyle(fontFamily: 'fredoka-bold', color: Color(0xFF0076DB))),
                              ],
                            ),
                            Slider(
                              value: _simulatedTemp,
                              min: 0,
                              max: 50,
                              divisions: 50,
                              activeColor: const Color(0xFF0076DB),
                              onChanged: (v) => setState(() => _simulatedTemp = v),
                            ),

                            // Slider Umidade Solo
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Umidade do Solo:', style: TextStyle(fontFamily: 'fredoka-bold')),
                                Text('${_simulatedSoil.toStringAsFixed(0)}%', style: const TextStyle(fontFamily: 'fredoka-bold', color: Color(0xFF0076DB))),
                              ],
                            ),
                            Slider(
                              value: _simulatedSoil,
                              min: 0,
                              max: 100,
                              divisions: 100,
                              activeColor: const Color(0xFF06DC34),
                              onChanged: (v) => setState(() => _simulatedSoil = v),
                            ),

                            // Slider Umidade Ar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Umidade Relativa do Ar:', style: TextStyle(fontFamily: 'fredoka-bold')),
                                Text('${_simulatedAir.toStringAsFixed(0)}%', style: const TextStyle(fontFamily: 'fredoka-bold', color: Color(0xFF0076DB))),
                              ],
                            ),
                            Slider(
                              value: _simulatedAir,
                              min: 0,
                              max: 100,
                              divisions: 100,
                              activeColor: const Color(0xFF0076DB),
                              onChanged: (v) => setState(() => _simulatedAir = v),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

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
                            if (_plantNameController.text.trim().isNotEmpty) {
                              widget.plantState.plantName = _plantNameController.text.trim();
                            }
                            widget.plantState.updateSensors(
                              temp: _simulatedTemp,
                              soil: _simulatedSoil,
                              air: _simulatedAir,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Parâmetros e calibração atualizados com sucesso!',
                                  style: TextStyle(fontFamily: 'fredoka'),
                                ),
                                backgroundColor: Color(0xFF06DC34),
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Aplicar Configurações',
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
}
