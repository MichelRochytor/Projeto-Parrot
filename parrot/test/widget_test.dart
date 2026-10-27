import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parrot/models/plant_state.dart';
import 'package:parrot/screens/home_screen.dart';
import 'package:parrot/screens/settings_screen.dart';
import 'package:parrot/screens/irrigation_screen.dart';
import 'package:parrot/screens/cloud_screen.dart';
import 'package:parrot/screens/recommendations_screen.dart';
import 'package:parrot/screens/manual_config_screen.dart';

void main() {
  testWidgets('Test HomeScreen rendering and interactions', (tester) async {
    final plantState = PlantState();
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(fontFamily: 'fredoka'),
        home: HomeScreen(plantState: plantState),
      ),
    );

    // Verify main header elements
    expect(find.text('Rosa do Deserto'), findsOneWidget);
    expect(find.text('on'), findsOneWidget);
    expect(find.text('Temperatura'), findsOneWidget);
    expect(find.text('Umidade'), findsOneWidget);

    // Verify metrics
    expect(find.text('3.2/5'), findsOneWidget);
    expect(find.text(r'5L\m2'), findsOneWidget);
    expect(find.text('Urgente'), findsOneWidget);
    expect(find.text('Baixo'), findsOneWidget);
    expect(find.text('5.8h'), findsOneWidget);
    expect(find.text('12%'), findsOneWidget);
    expect(find.text('Sim'), findsOneWidget);
    expect(find.text('45min'), findsOneWidget);

    // Tap watering toggle
    await tester.tap(find.text('on'));
    await tester.pumpAndSettle();
    expect(find.text('off'), findsOneWidget);
  });

  testWidgets('Test SettingsScreen rendering', (tester) async {
    final plantState = PlantState();
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(fontFamily: 'fredoka'),
        home: SettingsScreen(plantState: plantState),
      ),
    );

    expect(find.text('Configurações'), findsOneWidget);
    expect(find.text('Regador'), findsOneWidget);
    expect(find.text('Nuvem IoT'), findsOneWidget);
    expect(find.text('Config. Manual'), findsOneWidget);
    expect(find.text('Voltar'), findsOneWidget);
  });

  testWidgets('Test IrrigationScreen rendering', (tester) async {
    final plantState = PlantState();
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(fontFamily: 'fredoka'),
        home: IrrigationScreen(plantState: plantState),
      ),
    );

    expect(find.text('Parâmetros do Regador'), findsOneWidget);
    expect(find.text('Limiar para Acionamento'), findsOneWidget);
    expect(find.text('Limiar de Parada'), findsOneWidget);
  });

  testWidgets('Test CloudScreen and RecommendationsScreen', (tester) async {
    final plantState = PlantState();
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(fontFamily: 'fredoka'),
        home: CloudScreen(plantState: plantState),
      ),
    );
    expect(find.text('Conectividade & Nuvem IoT'), findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(fontFamily: 'fredoka'),
        home: RecommendationsScreen(plantState: plantState),
      ),
    );
    expect(find.text('Recomendações Práticas'), findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(fontFamily: 'fredoka'),
        home: ManualConfigScreen(plantState: plantState),
      ),
    );
    expect(find.text('Configuração Manual'), findsOneWidget);
  });
}
