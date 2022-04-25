import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quatro_app/model/game_state.dart';

// TODO: dit moet een mooie gelijkmatige grid worden whoe dat te doen is nog niet duidelijk.

class PlayBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameState gameState = Provider.of<GameState>(context);

    return Container(
      color: Colors.blue,
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.blue,
            height: 10.0,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: gameState.buildFreePieceTile(index),
              );
            },
            itemCount: gameState.freePiecesCount(),
          ),
          Container(
            color: Colors.blue,
            height: 10.0,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              int gridStateLength = 4;
              int x, y = 0;
              x = (index / gridStateLength).floor();
              y = (index % gridStateLength);
              return gameState.buildTilePiece(context, x, y);
            },
            itemCount: 16,
          ),
        ],
      ),
    );

//      Center(
//        child: Container(
//        color: Colors.deepPurple,
////        child: AspectRatio(
////          aspectRatio: 1.0,
////          child: Container(
//////            padding: EdgeInsets.all(5.0),
//////            margin: EdgeInsets.all(5.0),
////            decoration: BoxDecoration(
////                border: Border.all(color: Colors.black, width: 2.0)),
//            child: GridView.builder(
//              shrinkWrap: true,
//              physics: NeverScrollableScrollPhysics(),
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                crossAxisCount: 4,
//              ),
//              itemBuilder: _buildGridItems,
//              itemCount: 16,
//            ),
////          ),
////        ),
//      ),
//    );
  }
}
