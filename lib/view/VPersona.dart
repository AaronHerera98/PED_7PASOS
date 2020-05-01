import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:los_7_pasos/model/MPersona.dart';
import 'package:los_7_pasos/model/StaticPersona.dart';
import 'package:los_7_pasos/utils/responsive_screen.dart';
import 'package:los_7_pasos/widget/foto_perfil.dart';
import 'package:los_7_pasos/widget/gradient_text.dart';

class VPersona extends StatefulWidget {
  @override
  _VPersonaState createState() => _VPersonaState();
}

class _VPersonaState extends State<VPersona> {
  
  File _foto;
  String _url;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  Screen size;
  double widht;
  double height;

  @override
  void initState() {
    // TODO: implement initState
    http.get('http://diabetesapi.somee.com/api/Personas/${SPersona.idPersona}')
    .then((var response){
        Map jsonData = jsonDecode(response.body);
        
        if(jsonData['fotoUrl'] != null){
          _url = jsonData['fotoUrl'];
        }
        setState(() {});
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    size = Screen(MediaQuery.of(context).size);
    height= MediaQuery.of(context).size.height;
    widht = MediaQuery.of(context).size.width;

    // return Scaffold(
    //   body: Column(children: <Widget>[
    //     Text('Nombre: ${SPersona.nombre}\n',
    //       style: TextStyle(fontSize: 20.0),
    //     ),
    //     Text('Apellido:  ${SPersona.apellidoPater}' +
    //           ' ' +
    //           '${SPersona.apellidoMater}\n',
    //       style: TextStyle(fontSize: 20.0),
    //     ),
    //     Text('Edad: ${SPersona.edad}\n',
    //       style: TextStyle(fontSize: 20.0),
    //     ),
    //   ]),
    // );

    return Center(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            _perfilGradientText(),
            SizedBox(height:25),
            Container(
              child: registerFields(context, _url)
              // child: FutureBuilder(
              //   future: ,
              //   builder: (BuildContext context, AsyncSnapshot snapshot){
              //     if(snapshot.data == null){
              //       return Container(child: Center(child: Text("CARGANDO..."),));
              //     } else{
              //       return registerFields(context, snapshot.data.fotoUrl);
              //     }
              //   },
              // )
            )

          ],
        )
      ),
    );
  }

  GradientText _perfilGradientText() {
    return GradientText('Perfil de usuario',
      gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
      style: TextStyle(
      fontFamily: 'Exo2', fontSize: 30, fontWeight: FontWeight.bold)
    );
  }

  FotoPerfilWidget _fotoPerfil(String fotoUrl){
    return FotoPerfilWidget(_foto, fotoUrl);
  }

  Widget _botonFoto() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: size.getWidthPx(5)),
        IconButton(
          icon: Icon(Icons.add_a_photo, color: Colors.black),
          onPressed: _tomarFoto,  
        ),
        FlatButton(
          onPressed: (){
            if(_foto != null){
             _uploadImg();
            }
          }, 
          child: Text("Subir"),
          textColor: Colors.black,
        ),
        // SizedBox(width: size.getWidthPx(90)),
        IconButton(
          icon: Icon(Icons.add_photo_alternate, color: Colors.black),
          onPressed: _seleccionarFoto,
        ),
      ],
    );
  }

  Widget _nombrePersona(){
    return Padding(
      padding: EdgeInsets.only(top:15, left:2),
      child: Center(
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "${SPersona.nombre} ${SPersona.apellidoPater}",
              style: TextStyle(
                //fontFamily: 'SFUIDisplay',
                fontWeight: FontWeight.w800,
                color: Colors.black,
                fontSize: 18,
              )
            ),
          ]),
        ),
      ),
    );
  }


  Widget _datos(){
    return Padding(
      padding: EdgeInsets.only(top:15, left:2),
      child: Center(
        child: Column(
          children: <Widget>[
            RichText(
              text: TextSpan(
                children:[
                  TextSpan(
                    text: "Años con diabetes: ${SPersona.anioscondiabetes}",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color:  Colors.black,
                      fontSize: 18,
                    )
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  registerFields(BuildContext context, String fotoUrl) => Container(
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _fotoPerfil(fotoUrl),
          _botonFoto(),
          _nombrePersona(),
          _datos(),
          Divider(
            height: 15,
            color: Colors.indigo,
          )
          //_confirmPasswordWidget(),
        ],
      )
    ),
  );

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    _foto = await ImagePicker.pickImage(source: origen);

    if (_foto != null) {
      //Limpieza

    }
    setState(() {});
  }

  _uploadImg() async {

    String username = SPersona.nombre+SPersona.apellidoPater;
    print(username);

    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("foto_perfil/$username" + ".jpg");
    StorageUploadTask uploadTask = reference.putFile(_foto);
    
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var downURL = await (taskSnapshot).ref.getDownloadURL();
    _url = downURL;
    print('La _foto se subió');
    print(_url);

    if (_url.isEmpty) {
      mostrarAlerta(context);
      return '';
    } else {
      _updatePerson(_url);
    }

  }

  Future _updatePerson(String _url) async {

    await http.get('http://diabetesapi.somee.com/api/Personas/${SPersona.idPersona}')
    .then((var response){
        Map jsonData = jsonDecode(response.body);

        Map<String, dynamic> _persona={
          'idPersona' : jsonData['idPersona'],
          'edad': jsonData['edad'],
          'nombre': jsonData['nombre'],
          'anioscondiabetes': jsonData['anioscondiabetes'],
          'apellidoPater': jsonData['apellidoPater'],
          'apellidoMater': jsonData['apellidoMater'],
          'fechaInicio': jsonData['fechaInicio'],
          'telefono':jsonData['telefono'],
          'direccion':jsonData['direccion'],
          'fotoUrl': _url,
        };

        print(_persona);

        http.put(
          'http://diabetesapi.somee.com/api/Personas/${SPersona.idPersona}',
          body: jsonEncode(_persona),
          headers: {"content-Type": "application/json"},
        )
        .then((var resp){
          print("Cod resp: ${resp.statusCode}");
          if(resp.statusCode == 204){
            print("Actualización exitosa");
          }
        });
    });
  }

  void mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('ERROR'),
          content: Text(
              'Es necesaría una fotografía'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }
    );
  }



}
