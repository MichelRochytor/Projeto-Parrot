import 'package:flutter/foundation.dart';

class PlantState extends ChangeNotifier {
  // Dados principais
  String plantName = 'Rosa do Deserto';
  bool isWateringOn = true;
  double temperature = 32.0;
  double soilHumidity = 0.0;
  double airHumidity = 0.0;

  // Métricas agronômicas avançadas
  double waterStress = 3.2; // Escala 0 a 5 (ex: 3.2/5)
  String waterNeed = r'5L\m2'; // Necessidade hídrica
  String wateringMoment = 'Urgente'; // Momento ideal para regar
  String diseaseRisk = 'Baixo'; // Risco de doenças
  double photosynthesisHours = 5.8; // Horas de fotossíntese eficiente
  int growthPercent = 12; // Crescimento semanal estimado
  bool frostForecast = true; // Previsão de geada
  int recoveryTimeMinutes = 45; // Tempo de recuperação pós-rega

  // Parâmetros de irrigação
  double autoWateringThreshold = 30.0; // Umidade para acionamento
  double autoWateringStopThreshold = 70.0; // Umidade para parada
  int maxPumpDurationSeconds = 30; // Tempo máximo de segurança

  // Conectividade
  bool isCloudMode = true; // true = Modo Nuvem (Firebase), false = Modo Local
  String firebaseDeviceId = 'parrot-esp32-01';
  String firebaseDatabaseUrl = 'https://parrot-iot-default-rtdb.firebaseio.com';
  bool isConnected = true;

  // Alternar irrigação
  void toggleWatering() {
    isWateringOn = !isWateringOn;
    notifyListeners();
  }

  // Atualizar parâmetros de irrigação
  void updateIrrigationSettings({
    required double startThreshold,
    required double stopThreshold,
    required int maxDuration,
  }) {
    autoWateringThreshold = startThreshold;
    autoWateringStopThreshold = stopThreshold;
    maxPumpDurationSeconds = maxDuration;
    notifyListeners();
  }

  // Alternar modo de nuvem
  void setCloudMode(bool cloud) {
    isCloudMode = cloud;
    notifyListeners();
  }

  // Atualizar métricas (para simulação ou sensores reais)
  void updateSensors({
    required double temp,
    required double soil,
    required double air,
  }) {
    temperature = temp;
    soilHumidity = soil;
    airHumidity = air;

    // Recalcular índice de estresse hídrico conforme fórmula do projeto:
    // Iest = (T - 25)/10 + (100 - Ua)/100 + (40 - Us)/40
    waterStress = ((temp - 25) / 10) + ((100 - air) / 100) + ((40 - soil) / 40);
    if (waterStress < 0) waterStress = 0;
    if (waterStress > 5) waterStress = 5;

    // Atualizar momento ideal
    if (soil < autoWateringThreshold) {
      wateringMoment = 'Urgente';
    } else if (soil < (autoWateringThreshold + 20)) {
      wateringMoment = 'Em breve';
    } else {
      wateringMoment = 'Ideal';
    }

    notifyListeners();
  }
}
