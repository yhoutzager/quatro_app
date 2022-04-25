import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quatro_app/model/game_state.dart';
import 'package:quatro_app/routes.dart';

void main() => runApp(QuatroApp());

class QuatroApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        // builder: (context) => GameState(),
        create: (context) => GameState(),
        child: MaterialApp(
          title: "Games",
          initialRoute: "/",
          routes: Routes.routes,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
//      theme: appTheme,
        ));
  }
}
