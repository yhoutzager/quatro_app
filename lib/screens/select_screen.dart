import 'package:flutter/material.dart';
import 'package:quatro_app/screens/quatro_game_screen.dart';

class SelectScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, QuatroGameScreen.route);
            },
            color: Colors.purple,
            child: Text(
              'Play Quatro',
              style: TextStyle(
                color: Colors.black
              ),
            ),
          ),
          Container(),
        ],
      ),
    );
  }

}