// main.dart

import 'package:flame/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // 1. IMPORTAR SUPABASE

import 'widgets/hud.dart';
import 'game/dino_run.dart';
import 'models/settings.dart';
import 'widgets/main_menu.dart';
import 'models/player_data.dart';
import 'widgets/pause_menu.dart';
import 'widgets/settings_menu.dart';
import 'widgets/game_over_menu.dart';
import 'widgets/inventory_menu.dart';
import 'widgets/level_selection_menu.dart';
import 'widgets/store_menu.dart'; // 2. IMPORTAR EL NUEVO WIDGET DE LA TIENDA (lo crearemos en el siguiente paso)

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 3. INICIALIZAR SUPABASE ANTES DE CORRER LA APP
  await Supabase.initialize(
    url: 'https://zhjrqdnriqcpojcxbxfp.supabase.co', // Pega tu URL aquí
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpoanJxZG5yaXFjcG9qY3hieGZwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI4OTQzODQsImV4cCI6MjA3ODQ3MDM4NH0.XKGF13f8H3wvN58sYK0ZzBYkCLTTMK5JLLz1SPvZLEU', // Pega tu Anon Key aquí
  );

  await initHive();
  runApp(const DinoRunApp());
}

Future<void> initHive() async {
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }
  Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
  Hive.registerAdapter<Settings>(SettingsAdapter());
}

class DinoRunApp extends StatelessWidget {
  const DinoRunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dino Run',
      theme: ThemeData(
        fontFamily: 'Audiowide',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            fixedSize: const Size(200, 60),
          ),
        ),
      ),
      home: Scaffold(
        body: GameWidget<DinoRun>.controlled(
          loadingBuilder: (conetxt) => const Center(
            child: SizedBox(width: 200, child: LinearProgressIndicator()),
          ),
          overlayBuilderMap: {
            MainMenu.id: (_, game) => MainMenu(game),
            PauseMenu.id: (_, game) => PauseMenu(game),
            Hud.id: (_, game) => Hud(game),
            GameOverMenu.id: (_, game) => GameOverMenu(game),
            SettingsMenu.id: (_, game) => SettingsMenu(game),
            InventoryMenu.id: (_, game) => InventoryMenu(game: game),
            LevelSelectionMenu.id: (_, game) => LevelSelectionMenu(game: game),
            StoreMenu.id: (_, game) =>
                StoreMenu(game), // 4. AÑADIR EL OVERLAY DE LA TIENDA
          },
          initialActiveOverlays: const [MainMenu.id],
          gameFactory: () => DinoRun(
            camera: CameraComponent.withFixedResolution(
              width: 360,
              height: 180,
            ),
          ),
        ),
      ),
    );
  }
}
