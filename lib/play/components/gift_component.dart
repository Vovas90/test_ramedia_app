import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:test_ra_media/play/components/santa_component.dart';
import 'package:test_ra_media/play/constants/globals.dart';
import 'package:test_ra_media/play/game/gift_grab_game.dart';

class GiftComponent extends SpriteComponent
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {

  final double _spriteHeight = 100;

  final Random _random = Random();

  GiftComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.coinSprite);

    position = _createRandomPosition();

    width = _spriteHeight;
    height = _spriteHeight;

    anchor = Anchor.center;

    add(CircleHitbox()..radius = 1);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is SantaComponent) {
      // Play gift grab sound.
      FlameAudio.play(Globals.itemGrabSound);

      // Remove the just collided gift.
      removeFromParent();

      // Update Santa's score by one.
      gameRef.score += 1;

      // Add a new gift to the field.
      gameRef.add(GiftComponent());
    }
  }

  Vector2 _createRandomPosition() {
    final double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    final double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();

    return Vector2(x, y);
  }
}