import 'package:los_7_pasos/model/MCita.dart';
import 'package:flutter/material.dart';
import 'package:los_7_pasos/model/StaticPersona.dart';
import 'package:los_7_pasos/widget/WCitas_Title.dart';
import 'package:los_7_pasos/widget/gradient_text.dart';
import '../services/repositorio.dart';
import 'dart:convert';

class VCitas extends StatefulWidget {
  @override
  _citaState createState() => _citaState();
}

class _citaState extends State<VCitas> {
  List<Cita> _cita = <Cita>[];
  
  initState() {
    super.initState();
    _getUsers(SPersona.idPersona);
  }

  void listenForReceta() async {
    final Stream<Cita> stream = await getCita();
    stream.listen((Cita beer) => setState(() => _cita.add(beer)));
  }
  var citas = new List<Cita>();
_getUsers(int i) {
    API.getCita(i).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
      citas = list.map((model) => Cita.fromJson(model)).toList();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            _citasGradientText(),
            SizedBox(height:20),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: citas.length,
              itemBuilder: (context, index) => CitaTitle(citas[index]),
            ),

          ],
        )
      )
    );
  }

  GradientText _citasGradientText() {
    return GradientText('Citas',
      gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
      style: TextStyle(
      fontFamily: 'Exo2', fontSize: 30, fontWeight: FontWeight.bold)
    );
  }

  
}
