import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_ra_media/play/game/gift_grab_game.dart';
import 'package:test_ra_media/play/screens/game_over_menu.dart';

final GiftGrabGame _giftGrabGame = GiftGrabGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _giftGrabGame,
      overlayBuilderMap: {
        GameOverMenu.ID: (BuildContext context, GiftGrabGame gameRef) =>
            GameOverMenu(gameRef: gameRef),
      },
    );
  }
}
