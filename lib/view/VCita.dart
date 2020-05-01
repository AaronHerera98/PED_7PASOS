import 'package:los_7_pasos/model/MCita.dart';
import 'package:flutter/material.dart';
import 'package:los_7_pasos/utils/responsive_screen.dart';
import '../control/CtipoCita.dart';

class SecondRoute extends StatefulWidget {


  SecondRoute({Key key, @required this.citaUnica}) : super(key: key);
  final Cita citaUnica;

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  Screen size;
  double widht;
  double height;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    height = MediaQuery.of(context).size.height;
    widht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Información de la Cita"),
        backgroundColor: Colors.purpleAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.getWidthPx(20),
            vertical: size.getWidthPx(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              registerFields(context),
            ]
          ),
        ),
      ),
    );
  }

  registerFields(BuildContext context) => Container(
    child: Form(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Fecha: ${widget.citaUnica.fecha_cita}',
             style: TextStyle(fontSize:20.0),
            ),
          ),
          ListTile(
            title: Text('Hora: ${widget.citaUnica.hora_cita}',
             style: TextStyle(fontSize:20.0),
            ),
          ),
          ListTile(
            title: Text('Tipo de cita: ${CTipoCita.tipoCita}',
              style: TextStyle(fontSize:20.0),
            ),
          ),
        ],
      )
    ),
  );
}
