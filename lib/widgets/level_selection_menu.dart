import 'package:flutter/material.dart';

import '../../game/dino_run.dart';
import 'main_menu.dart';
import 'hud.dart';

// Represents the level selection menu overlay.
class LevelSelectionMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'LevelSelectionMenu';

  final DinoRun game;

  const LevelSelectionMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(100),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selecciona un Nivel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await game.startGamePlay('forest');
                game.overlays.remove(id);
                game.overlays.add(Hud.id);
              },
              child: const Text('El Bosque'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await game.startGamePlay('desert');
                game.overlays.remove(id);
                game.overlays.add(Hud.id);
              },
              child: const Text('Desierto'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await game.startGamePlay('snow');
                game.overlays.remove(id);
                game.overlays.add(Hud.id);
              },
              child: const Text('Nieve'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.overlays.remove(id);
                game.overlays.add(MainMenu.id);
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
