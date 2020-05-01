import 'package:flutter/material.dart';

class Recomendaciones{
  final int id_recomendacion;
  final String text;

  Recomendaciones({
    this.id_recomendacion,
    this.text});

  Recomendaciones.fromJson(Map<String, dynamic> jsonMap)
    : id_recomendacion = jsonMap['idRecomendacion'],
      text = jsonMap['txtRecomendacion'];
}

