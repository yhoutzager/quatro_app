import 'package:flutter/material.dart';

class BoardPiece {

  final bool square;
  final bool solid;
  final bool light;
  final bool big;

  BoardPiece(this.square, this.solid, this.light, this.big);

  Container buildTilePiece() {

    BoxShape shape = square ? BoxShape.rectangle : BoxShape.circle;
    Color colour = (light ? Colors.lightBlue[500] : Colors.indigo[700])!;
    double sizeFactor = big ? 0.8 : 0.5;
    Decoration decoration;
    if (solid) {
      decoration = BoxDecoration(
        shape: shape,
        color: colour,
      );
    } else {
      decoration = BoxDecoration(
        shape: shape,
        border: Border.all(
          color: colour,
          //TODO: grote van de borders moet ook relatief worden!
          width: big ? 15.0 : 10.0,
        )
      );
    }

    return Container(
      color: Colors.black,
      child: FractionallySizedBox(
        heightFactor: sizeFactor,
        widthFactor: sizeFactor,
        child: Container(
            decoration: decoration
          ),
      ),
    );
  }


}
