import 'package:flutter/material.dart';
import 'package:quatro_app/screens/quatro_game_screen.dart';
import 'package:quatro_app/screens/select_screen.dart';

class Routes {

  static var routes = <String, WidgetBuilder> {
    "/" : (BuildContext context) => SelectScreen(),
    QuatroGameScreen.route : (BuildContext context) => QuatroGameScreen(),
  };

}