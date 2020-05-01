import 'package:flutter/material.dart';
import 'package:los_7_pasos/model/MPersona.dart';
import 'dart:io';

class FotoPerfilWidget extends StatefulWidget {
  
  final File foto;
  final String fotoUrl;

  const FotoPerfilWidget(this.foto, this.fotoUrl);
  
  _FotoPerfilWidgetState createState() => _FotoPerfilWidgetState();
}

class _FotoPerfilWidgetState extends State<FotoPerfilWidget> {

  Persona _persona = Persona();

  @override
  Widget build(BuildContext context) {
    _persona.fotoUrl = widget.fotoUrl;
    return CircleAvatar(
      radius: 80,
      child: ClipOval(
        child: SizedBox(
          width: 200.0,
          height: 200.0,
          child: (widget.foto != null)
              ? Image.file(
                  widget.foto,
                  fit: BoxFit.fill,
                  ):(widget.fotoUrl!=null)?Image.network(
                    widget.fotoUrl,
                    fit: BoxFit.fill,
                )
              : Image.asset(
                  'Assets/non_user.png',
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }
}