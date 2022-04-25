import 'dart:math';

import 'package:quatro_app/model/board_piece.dart';


class Board {

  late List<List<BoardPiece?>> board;

  Board() {
    board = List.generate(4, (index) => List.generate(4, (index) => null, growable: false), growable: false);
  }

  void testFillBoard() {
    Random random = Random();
    for (int i in [0,1,2,3]) {
      for (int j in [0,1,2,3]) {
        board[i][j] = BoardPiece(random.nextBool(), random.nextBool(), random.nextBool(), random.nextBool());
      }
    }
  }

  void placePiece(BoardPiece boardPiece, int x, int y) {
    board[x][y] = boardPiece;
  }

  BoardPiece? getPiece(int x, int y) {
    return board[x][y];
  }

  bool fourInARow(int x, int y) {
    // Horizontal
    if (isFourTheSame(board[x])) return true;
    // Vertical
    List<BoardPiece?> check = List.empty(growable: true);
    for (int i in [0,1,2,3]) {
      check.add(board[i][y]);
    }
    if (isFourTheSame(check)) return true;
    // Diagonal top left -> bottom right
    if (x == y) {
      check.clear();
      for (int i in [0,1,2,3]) {
        check.add(board[i][i]);
      }
      if (isFourTheSame(check)) return true;
    }
    // Diagonal bottom left -> top right
    if (x + y == 3) {
      check.clear();
      for (int i in [0,1,2,3]) {
        check.add(board[i][3-i]);
      }
      if (isFourTheSame(check)) return true;
    }
    return false;
  }

  bool isFourTheSame(List<BoardPiece?> list) {
    if (list.length != 4 || list[0] == null) return false;

    bool startSquare, startSolid, startLight, startBig;
    bool isSameSquare = true, isSameSolid = true, isSameLight = true, isSameBig = true;
    startSquare = list[0]!.square;
    startSolid = list[0]!.solid;
    startLight = list[0]!.light;
    startBig = list[0]!.big;
    for (int i in [1,2,3]) {
      if (list[i] == null) {
        return false;
      }
      if (isSameSquare && startSquare != list[i]!.square) {
        isSameSquare = false;
      }
      if (isSameSolid && startSolid != list[i]!.solid) {
        isSameSolid = false;
      }
      if (isSameLight && startLight != list[i]!.light) {
        isSameLight = false;
      }
      if (isSameBig && startBig != list[i]!.big) {
        isSameBig = false;
      }
    }
    return isSameSquare || isSameSolid || isSameLight || isSameBig;
  }

//  Widget buildTilePiece(int x, int y) {
//    Container container;
//    if (board[x][y] == null) {
//      container = Container(color: Colors.black,
//      child: FlatButton(
//        onPressed: ,
//      ),);
//    } else {
//      container = board[x][y].buildTilePiece();
//    }
//
//    return Padding(
//      padding: const EdgeInsets.all(1.0),
//      child: container,
//    );
//  }
}