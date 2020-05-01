import 'dart:convert';

import 'package:los_7_pasos/model/MRecomendaciones.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:los_7_pasos/utils/responsive_screen.dart';
import 'package:los_7_pasos/widget/gradient_text.dart';

class VRecomendacion extends StatelessWidget{
   VRecomendacion({Key key, this.recomenUnico}) : super(key: key);
  final Recomendaciones recomenUnico;

  Future<List<Map<dynamic, dynamic>>> _cargarRecomendaciones() async {
    List<Map> listRecomendaciones = [];
    var response = await http.get('http://diabetesapi.somee.com/api/Recomendaciones');

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      
      for(var item in jsonData){
        Map<dynamic, dynamic> recom = item;
        listRecomendaciones.add(recom);
      }

      return listRecomendaciones;
    }else{
      return null;
    }
  }

  Screen size;
  double widht;
  double height;

  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    height = MediaQuery.of(context).size.height;
    widht = MediaQuery.of(context).size.width;
    return Center(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            _recomendacionesGradientText(),
            SizedBox(height: 25),
            Container(
              child: FutureBuilder(
                future: _cargarRecomendaciones(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.data == null){
                    return Container(child: Center(child: Text("Cargando..."),),);
                  }else{
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Colors.purpleAccent,
                            ),                         
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0)
                          )
                        ),
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(20.0),
                        child: Text(snapshot.data[index]['txtRecomendacion'])
                        );
                      },
                    );
                  }
                },
              )
            ),
          ],
        )
      ),
    );
  }

  GradientText _recomendacionesGradientText() {
    return GradientText('Recomendaciones',
      gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
      style: TextStyle(
      fontFamily: 'Exo2', fontSize: 30, fontWeight: FontWeight.bold)
    );
  }
}