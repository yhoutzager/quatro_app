import 'dart:core';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quatro_app/model/board.dart';
import 'package:quatro_app/model/board_piece.dart';

//TODO notify listeners op goede plaatsten zetten.
class GameState extends ChangeNotifier {
  late Board board;
  late List<BoardPiece> freePieces;
  late Player activePlayer;
  late Player winningPlayer;
  late QuatroState state;
  BoardPiece? activePiece;

  GameState() {
    _init();
  }

  _init() {
    winningPlayer = Player.NONE;
    freePieces = List.empty(growable: true);
    board = Board();
    state = QuatroState.PLACE_PIECE;

    fillFreePieces();
    pickStartingPlayer();
    pickStartingPiece();
    notifyListeners();
  }

  int freePiecesCount() {
    return freePieces.length;
  }

  void fillFreePieces() {
    for (bool square in [true, false]) {
      for (bool solid in [true, false]) {
        for (bool light in [true, false]) {
          for (bool big in [true, false]) {
            freePieces.add(BoardPiece(square, solid, light, big));
          }
        }
      }
    }
    freePieces.shuffle();
  }

  void switchActivePlayer() {
    activePlayer = activePlayer == Player.RIGHT ? Player.LEFT : Player.RIGHT;
  }

  void pickStartingPlayer() {
    Random random = Random();
    activePlayer = random.nextBool() ? Player.RIGHT : Player.LEFT;
  }

  void pickStartingPiece() {
    pickFreePiece(1);
  }

  void pickFreePiece(int index) {
    activePiece = freePieces.removeAt(index);
  }

  void goToNextState() {
    switch (state) {
      case QuatroState.PLACE_PIECE:
        state = QuatroState.PICK_PIECE;
        break;
      case QuatroState.PICK_PIECE:
        switchActivePlayer();
        state = QuatroState.PLACE_PIECE;
        break;
    }
    notifyListeners();
  }

  void pickActivePiece(index) {
    if (QuatroState.PICK_PIECE != state) {
      return;
    }
    pickFreePiece(index);
    goToNextState();
  }

  void placeActivePiece(int x, int y) {
    if (QuatroState.PLACE_PIECE != state) {
      return;
    }
    board.board[x][y] = activePiece;
    activePiece = null;
    if (board.fourInARow(x, y)) {
      winningPlayer = activePlayer;
    }
    goToNextState();
  }

  Widget buildFreePieceTile(int index) {
    return Container(
      color: Colors.black,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          pickActivePiece(index);
        },
        child: freePieces[index].buildTilePiece(),
      ),
    );
  }

  Widget buildTilePiece(BuildContext context, int x, int y) {
    Container container;
    if (board.board[x][y] == null) {
      container = Container(
        color: Colors.black,
        child: TextButton(
          onPressed: () {
            placeActivePiece(x, y);
            if (winningPlayer != Player.NONE) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Gewonnen!"),
                    content: Text("$winningPlayer heeft gewonnen"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          _init();
                          Navigator.pop(context);
                        },
                        child: Text("Play again"),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: SizedBox.shrink(),
        ),
      );
    } else {
      container = board.board[x][y]!.buildTilePiece();
    }

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: container,
    );
  }

  bool determineShowActivePiece(Player player) {
    if (QuatroState.PLACE_PIECE == state && player == activePlayer) {
      return true;
    }
    return false;
  }

  void playerWins(Player winningPlayer) {
    bool test;
  }
}

enum Player {
  RIGHT,
  LEFT,
  NONE,
}

enum QuatroState {
  PLACE_PIECE,
  PICK_PIECE,
}
