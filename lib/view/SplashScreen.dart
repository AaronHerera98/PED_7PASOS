import 'package:los_7_pasos/model/MPersona.dart';
import 'package:los_7_pasos/model/StaticPersona.dart';
import 'package:los_7_pasos/services/repositorio.dart';
import 'package:los_7_pasos/view/Inicio.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import '../model/MUsuario.dart';

class splash extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 8,
      navigateAfterSeconds: new Inicio(),
      title: new Text(
        'PED',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image(image: AssetImage('Assets/Splash.gif')),
      gradientBackground: new LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.purpleAccent,
    );
  }

  
}
