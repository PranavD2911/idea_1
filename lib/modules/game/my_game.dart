import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GameWidget.controlled(
        gameFactory: MyGame.new,
        backgroundBuilder: (context) => Container(color: Colors.amber),
        overlayBuilderMap: {
          'PauseMenu': (context, game) {
            return Container(
              color: Colors.amber,
              child: Text('A pause menu'),
            );
          },
        },
      ),
    );
  }
}

class MyGame extends FlameGame {
  late final JoystickComponent joystick;
  late final Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await images.loadAllImages();
    var env = await loadParallaxComponent([ParallaxImageData('goku.png')],
        baseVelocity: Vector2(10, 0), velocityMultiplierDelta: Vector2(1.5, 0));
    add(env);
    // Create a joystick with a circular knob and background.
    joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 20,
        paint: Paint()..color = Colors.blueAccent,
      ),
      background: CircleComponent(
        radius: 50,
        paint: Paint()..color = Colors.blue.withOpacity(0.5),
      ),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    add(joystick);

    // Add the player component
    player = Player(joystick: joystick);
    add(player);
  }
}

class Player extends SpriteComponent with HasGameRef<MyGame> {
  final JoystickComponent joystick;
  final double speed = 200.0; // Movement speed in pixels per second

  Player({required this.joystick})
      : super(
          size: Vector2.all(50.0),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Start the player at the center of the screen.
    position = gameRef.size / 2;
    // Load your player image. Ensure the asset is included in pubspec.yaml.
    sprite = await Sprite.load('player.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update player position based on joystick input.
    position.add(joystick.relativeDelta * speed * dt);
  }
}
