import 'package:flutter/material.dart';
import '../models/plant_state.dart';
import '../widgets/custom_app_bar.dart';

class CloudScreen extends StatefulWidget {
  final PlantState plantState;

  const CloudScreen({
    super.key,
    required this.plantState,
  });

  @override
  State<CloudScreen> createState() => _CloudScreenState();
}

class _CloudScreenState extends State<CloudScreen> {
  late bool _isCloud;
  late TextEditingController _deviceIdController;
  late TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    _isCloud = widget.plantState.isCloudMode;
    _deviceIdController = TextEditingController(text: widget.plantState.firebaseDeviceId);
    _urlController = TextEditingController(text: widget.plantState.firebaseDatabaseUrl);
  }

  @override
  void dispose() {
    _deviceIdController.dispose();
    _urlController.dispose();
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
                      Icon(Icons.cloud_sync, color: Colors.white, size: 28),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Conectividade & Nuvem IoT',
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
                      // Seletor de Modo (Local vs Nuvem)
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
                              'Modo de Operação:',
                              style: TextStyle(
                                fontFamily: 'fredoka-bold',
                                fontSize: 18,
                                color: Color(0xFF104862),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _isCloud = false),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: !_isCloud
                                            ? const Color(0xFF0076DB)
                                            : Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: const Color(0xFF104862),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Modo Local (WiFi)',
                                          style: TextStyle(
                                            fontFamily: 'fredoka-bold',
                                            fontSize: 16,
                                            color: !_isCloud
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _isCloud = true),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: _isCloud
                                            ? const Color(0xFF0076DB)
                                            : Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: const Color(0xFF104862),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Nuvem (Firebase)',
                                          style: TextStyle(
                                            fontFamily: 'fredoka-bold',
                                            fontSize: 16,
                                            color: _isCloud
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _isCloud
                                  ? 'Sincronização remota via Firebase Realtime Database.'
                                  : 'Comunicação direta com o servidor web assíncrono do ESP32 na rede local.',
                              style: const TextStyle(
                                fontFamily: 'fredoka',
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Campos de Configuração
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
                              'Identificação do Dispositivo:',
                              style: TextStyle(
                                fontFamily: 'fredoka-bold',
                                fontSize: 16,
                                color: Color(0xFF104862),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _deviceIdController,
                              style: const TextStyle(fontFamily: 'fredoka'),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.memory, color: Color(0xFF0076DB)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'URL do Banco Firebase:',
                              style: TextStyle(
                                fontFamily: 'fredoka-bold',
                                fontSize: 16,
                                color: Color(0xFF104862),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _urlController,
                              style: const TextStyle(fontFamily: 'fredoka'),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.link, color: Color(0xFF0076DB)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Card de Status
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF06DC34), width: 2),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.check_circle, color: Color(0xFF06DC34), size: 28),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Conexão ativa com o dispositivo ESP32 Parrot',
                                style: TextStyle(
                                  fontFamily: 'fredoka-bold',
                                  fontSize: 15,
                                  color: Color(0xFF104862),
                                ),
                              ),
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
                            widget.plantState.setCloudMode(_isCloud);
                            widget.plantState.firebaseDeviceId = _deviceIdController.text;
                            widget.plantState.firebaseDatabaseUrl = _urlController.text;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Configurações de conectividade salvas!',
                                  style: TextStyle(fontFamily: 'fredoka'),
                                ),
                                backgroundColor: Color(0xFF06DC34),
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Salvar e Conectar',
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
