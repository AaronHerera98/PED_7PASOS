import 'package:los_7_pasos/utils/responsive_screen.dart';
import 'package:los_7_pasos/widget/gradient_text.dart';

import '../services/repositorio.dart';
import 'package:flutter/material.dart';
import '../model/MMedicionDiaria.dart';
import '../model/StaticPersona.dart';

class VMediciones extends StatefulWidget {
  @override
  _Registrostate createState() => _Registrostate();
}

class _Registrostate extends State<VMediciones> {
  
  final _nombre = TextEditingController();
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    _nombre.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    
  }

  Screen size;
  double widht;
  double height;



  

  callAPI() {
    Medicion medicion = Medicion(
      primeraMedicion: 1,
      resul_medi: double.parse( _nombre.text),
      fecha_medi: DateTime.now(),
      hora_medi:  DateTime.now().hour,
      idTipomedi: 1,
      idpersona: SPersona.idPersona,
    );
    crearmedicion(medicion).then((response) {
      if (response.statusCode > 200) {
        print(response.body + '\n');

        
      } else
        print(response.statusCode);
    }).catchError((error) {
      print('error');
    });
  }

  Widget nombreInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: TextFormField(
        keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'Resultado de medicion'),
          controller: _nombre,
          textCapitalization: TextCapitalization.sentences,
          
    ));
  }

  

  

  Future<void> _cuadroDialogo() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Hay Campos Vacios'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _cuadroDialogoCorre() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Listo'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  validarVacio() {
    if (_nombre.text.isEmpty) {
      _cuadroDialogo();
    } else {
      callAPI();
    }
  }

  Widget registrarButtom(context) {
    return Center(
      child: Container(
          padding: EdgeInsets.symmetric(
            vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)
          ),
          width: size.getWidthPx(200),
          child: RaisedButton(
            elevation: 3.0,
            padding: EdgeInsets.all(size.getWidthPx(12)),
            child: Text('Registrar',
              style: TextStyle(
                fontFamily: 'Exo2', color: Colors.white, fontSize: 20,
              ),
            ),
            shape: StadiumBorder(),
            textColor: Colors.white,
            color: Colors.purpleAccent,
            onPressed: () {
              callAPI();
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    height = MediaQuery.of(context).size.height;
    widht = MediaQuery.of(context).size.height;
    return Center(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            _medicionesGradientText(),
            SizedBox(height: 25,),
            registerFields(context)
          ],
        )
      ),
    );
  }

  GradientText _medicionesGradientText() {
    return GradientText('Mediciones',
      gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
      style: TextStyle(
      fontFamily: 'Exo2', fontSize: 30, fontWeight: FontWeight.bold)
    );
  }

  registerFields(BuildContext context) => Container(
    child: Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          nombreInput(),
          registrarButtom(context)
        ],
      )
    ),
  );
  

}
