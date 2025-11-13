// lib/widgets/main_menu.dart

import 'dart:ui';

import 'package:flutter/material.dart';

import '/game/dino_run.dart';
import '/widgets/inventory_menu.dart';
import '/widgets/level_selection_menu.dart';
import '/widgets/settings_menu.dart';
import '/widgets/store_menu.dart'; // 1. IMPORTAMOS EL MENÚ DE LA TIENDA

// This represents the main menu overlay.
class MainMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'MainMenu';

  // Reference to parent game.
  final DinoRun game;

  const MainMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 100,
              ),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  const Text(
                    'Carlos Run',
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      game.overlays.add(LevelSelectionMenu.id);
                      game.overlays.remove(MainMenu.id);
                    },
                    child: const Text('Jugar', style: TextStyle(fontSize: 30)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      game.overlays.add(InventoryMenu.id);
                      game.overlays.remove(MainMenu.id);
                    },
                    child: const Text('Inventario', style: TextStyle(fontSize: 30)),
                  ),

                  // ---------- NUEVO BOTÓN DE LA TIENDA ---------- //
                  ElevatedButton(
                    onPressed: () {
                      game.overlays.remove(MainMenu.id);
                      game.overlays.add(StoreMenu.id);
                    },
                    child: const Text(
                      'Tienda',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  // ------------------------------------------------ //

                  ElevatedButton(
                    onPressed: () {
                      game.overlays.remove(MainMenu.id);
                      game.overlays.add(SettingsMenu.id);
                    },
                    child: const Text(
                      'Ajustes',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
