import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:los_7_pasos/utils/responsive_screen.dart';
import 'package:los_7_pasos/widget/card_widget.dart';
import 'package:los_7_pasos/widget/gradient_text.dart';


class VConferencias extends StatefulWidget{
  @override
  _VConferenciasState createState() => _VConferenciasState();
}

class _VConferenciasState extends State<VConferencias> {
  
  Screen size;
  double widht;
  double height;
  
  @override
  Widget build(BuildContext context){
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
            Container(
              child: FutureBuilder(
                future: _cargarNomConferencias(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.data == null){
                    return Container(child: Center(child: Text("Sin conferencias."),),);
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder:  (BuildContext context, int index){
                        return _cardConferencias(snapshot.data[index]['nombreConf']);
                      },
                    );
                  }
                },
              )
            )
            //registerFields(context)
          ],
        )
      ),
    );
  }

  GradientText _medicionesGradientText() {
    return GradientText('Conferencias',
      gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
      style: TextStyle(
      fontFamily: 'Exo2', fontSize: 30, fontWeight: FontWeight.bold)
    );
  }
  
  CardWidget _cardConferencias(String platica){
    return CardWidget(platica);
  }

  Future<List<Map<dynamic, dynamic>>> _cargarNomConferencias() async{
    List<Map> listNomConferencias = [];
    var resp = await http.get('http://diabetesapi.somee.com/api/NomConferencias');

    if(resp.statusCode == 200){
      var jsonData = jsonDecode(resp.body);

      for(var item in jsonData){
        Map<dynamic, dynamic> nomConf = item;
        listNomConferencias.add(nomConf);
      }
      return listNomConferencias;
    } else {
      return null;
    } 
  }

  // Future<List<Map<dynamic, dynamic>>> _cargarConferencias() async{
  //   List<Map> listConferencias = [];
  //   var resp = await  http.get('http://diabetesapi.somee.com/api/Conferencias');

  //   if(resp.statusCode == 200){
  //     var jsonData = jsonDecode(resp.body);

  //     for(var item in jsonData){
  //       Map<dynamic, dynamic> conf = item;
  //       listConferencias.add(conf);
  //     }

  //     return listConferencias;
  //   } else {
  //     return null;
  //   }
  // }

  
}