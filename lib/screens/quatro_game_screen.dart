import 'package:flutter/material.dart';
import 'package:quatro_app/model/game_state.dart';
import 'package:quatro_app/widgets/play_board.dart';
import 'package:provider/provider.dart';

class QuatroGameScreen extends StatelessWidget {
  static String get route => '/QuatroGameScreen';


  @override
  Widget build(BuildContext context) {
    GameState gameState = Provider.of<GameState>(context);
    bool leftActive = gameState.activePlayer == Player.LEFT;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: <Widget>[
          Expanded(
            flex: leftActive ? 3 : 1,
            child: Container(
              child: AspectRatio(
                  aspectRatio: 1.0,
                  child: gameState.determineShowActivePiece(Player.LEFT)
                      ? gameState.activePiece!.buildTilePiece()
                      : null),
            ),
          ),
          Expanded(
              flex: 10,
              child: PlayBoard()),
          Expanded(
            flex: !leftActive ? 3 : 1,
            child: Container(
              child: AspectRatio(
                  aspectRatio: 1.0,
                  child: gameState.determineShowActivePiece(Player.RIGHT)
                      ? gameState.activePiece!.buildTilePiece()
                      : null),
            ),
          ),
        ],
      ),
    );
  }
}
