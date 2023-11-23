import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:test_ra_media/play/components/gift_component.dart';
import 'package:test_ra_media/play/components/ice_component.dart';
import 'package:test_ra_media/play/inputs/joystick.dart';

import '../components/background_component.dart';
import '../components/santa_component.dart';
import '../constants/globals.dart';
import '../screens/game_over_menu.dart';

class GiftGrabGame extends FlameGame with DragCallbacks, HasCollisionDetection {
  int score = 0;

  late Timer _timer;

  int _remainingTime = 30;

  late TextComponent _scoreText;

  late TextComponent _timeText;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());

    add(SantaComponent(joystick: joystick));

    add(GiftComponent());

    add(joystick);

    FlameAudio.audioCache.loadAll(
      [
        Globals.itemGrabSound,
        Globals.freezeSound,
      ],
    );

    add(IceComponent(startPosition: Vector2(200, 200)));

    add(IceComponent(startPosition: Vector2(size.x - 200, size.y - 200)));

    add(ScreenHitbox());

    _scoreText = TextComponent(
      text: 'Score: $score',
      position: Vector2(40, 50),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(),
    );

    add(_scoreText);

    _timeText = TextComponent(
      text: 'Time: $score',
      position: Vector2(size.x - 40, 50),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(),
    );

    add(_timeText);

    _timer = Timer(1, repeat: true, onTick: () {
      if (_remainingTime == 0) {
        pauseEngine();
        overlays.add(GameOverMenu.ID);
      } else {
        _remainingTime -= 1;
      }
    });
    _timer.start();
  }

  @override
  void update(dt) {
    super.update(dt);

    _timer.update(dt);

    _scoreText.text = 'Score: $score';
    _timeText.text = 'Time: $_remainingTime secs';
  }

  void reset() {
    score = 0;
    _remainingTime = 30;
  }
}
