import 'package:los_7_pasos/view/Home.dart';
import 'package:flutter/material.dart';


void main() => runApp(MYapp());

class MYapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      
      theme: ThemeData(
        dividerColor: Colors.grey,
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(height: 50),
        textTheme: TextTheme(
          subhead: TextStyle(
            fontSize: 18,
          ),
          button: TextStyle(
            fontSize: 16,
          )
        )
      ),
    );
  }
}
