import '../model/MPersona.dart';
import '../model/StaticPersona.dart';
import 'dart:convert';
import 'package:los_7_pasos/view/SplashScreen.dart';
import '../services/repositorio.dart';
import 'package:flutter/material.dart';
import '../model/MUsuario.dart';

class Loginpage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<Loginpage> {
  TextEditingController nombre = TextEditingController();
  TextEditingController pass = TextEditingController();

  List<Usuario> _usuarios = <Usuario>[];
  List<Persona> _personaUnica = <Persona>[];

  @override
  void initState() {
    super.initState();
    listenForUsuarios();
  }

  void listenForUsuarios() async {
    final Stream<Usuario> stream = await getUsuario();
    stream.listen((Usuario usuario) => setState(() => _usuarios.add(usuario)));
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Assets/Image1.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter)),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SFUIDisplay',
                          fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      controller: nombre,
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'SFUIDisplay'),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Usuario',
                          prefixIcon: Icon(Icons.person_outline),
                          labelStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xfff5f5f5),
                  child: TextFormField(
                    autofocus: true,
                    obscureText: true,
                    controller: pass,
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'SFUIDisplay'),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock_outline),
                        labelStyle: TextStyle(fontSize: 15)),
                  ),
                ),
                //Botón Inicio
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () {
                      onSearchTextChanged(nombre.text, pass.text);
                    }, //since this is only a UI app
                    child: Text(
                      'Ingresar',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'SFUIDisplay',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.purpleAccent,
                    elevation: 0,
                    minWidth: 400,
                    height: 50,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                //Botón Fin
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                          fontFamily: 'SFUIDisplay',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "¿No tienes una cuenta?",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Colors.black,
                              fontSize: 15,
                            )),
                        TextSpan(
                            text: "sign up",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Color(0xffff2d55),
                              fontSize: 15,
                            ))
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  _getUsuario(String tel, String con){
    final Future<Usuario> usu = login(tel,con);
    
    Navigator.pushReplacementNamed(context, "/logout");
  }
  
  
 
var persons = new List<Persona>();
  _getPersona(int i) {
    API.getPerso(i).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        persons = list.map((model) => Persona.fromJson(model)).toList();
        SPersona.idPersona=persons[0].idPersona;
        SPersona.nombre=persons[0].nombre;
        SPersona.apellidoPater=persons[0].apellidoPater;
        SPersona.apellidoMater=persons[0].apellidoMater;      
        SPersona.anioscondiabetes=persons[0].anioscondiabetes;
        SPersona.edad=persons[0].edad;
        SPersona.direccion=persons[0].direccion;
        SPersona.fechaInicio=persons[0].fechaInicio;
      });
    });
  }

  void onSearchTextChanged(String _nombre, String _pass) async {
    if (_nombre.isEmpty || _pass.isEmpty) {
      setState(() {});
      return;
    }

    _usuarios.forEach((userDetail) {
      if (userDetail.telefono == _nombre && userDetail.contrasena == _pass) {
        _getPersona(userDetail.idPersona);
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => splash()),
        );
      }
    });

    setState(() {});
  }
}
