import 'package:los_7_pasos/model/MPersona.dart';
import '../model/StaticPersona.dart';
import 'package:los_7_pasos/view/VCitas.dart';
import 'package:los_7_pasos/view/VConferencia.dart';
import 'package:los_7_pasos/view/VMediciones.dart';
import 'package:los_7_pasos/view/VPersona.dart';
import 'package:los_7_pasos/view/VRecomendaciones.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Inicio extends StatefulWidget {
  @override
  _inicioState createState() => _inicioState();
}

class _inicioState extends State<Inicio> {
  Persona personaUnica;
  void initState() {
    super.initState();
    print(SPersona.nombre.toString());
  }

  int _pageIndex = 1;

  final VPersona _personas = new VPersona();
  final VMediciones _mediciones = new VMediciones();
  final VConferencias _conferencias = new VConferencias();
  final VCitas _cita = new VCitas();
  final VRecomendacion _recomendacion = new VRecomendacion();
  Widget _showPage = new VPersona();
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _cita;
        break;
      case 1:
        return _personas;
        break;
      case 2:
        return _mediciones;
        break;
      case 3:
        return _conferencias;
        break;
      case 4:
        return _recomendacion;
      default:
        return _personas;
    }
  }

  @override
  Widget build(BuildContext context) {
    int i;
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: _pageIndex,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.calendar_today, size: 30),
            Icon(Icons.person, size: 30),
            Icon(Icons.content_paste, size: 30),
            Icon(Icons.live_tv, size: 30),
            Icon(Icons.favorite, size: 30),
          ],
          color: Colors.purpleAccent,
          buttonBackgroundColor: Colors.purpleAccent,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeOutBack,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              i = index;
              _showPage = _pageChooser(index);
            });
          },
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: _showPage,
          ),
        ));
  }
}
