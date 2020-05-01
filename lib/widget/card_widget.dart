import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  
  final String platica;
  //final String fechaP;

  const CardWidget(this.platica);
  
  @override
  _CardTrabajosState createState() => _CardTrabajosState();
}

class _CardTrabajosState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(children: <Widget>[
        ListTile(
          title: Text(widget.platica),
          //subtitle: Text(widget.fechaP),
        ),
      ]),
    );
  }
}