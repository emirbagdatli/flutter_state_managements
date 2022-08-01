import 'package:flutter/material.dart';
import 'package:flutter_state_managements/feature/onboard/onboard_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home:  OnBoardView(),
        theme: ThemeData.light().copyWith(
            floatingActionButtonTheme:
                const FloatingActionButtonThemeData(backgroundColor: Color.fromRGBO(11, 23, 84, 1))));
  }
}
