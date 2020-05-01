import 'dart:convert';

String medicionJson(Medicion data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Medicion {
  final int idmediciones;
  final int primeraMedicion;
  final DateTime fecha_medi;
  final int hora_medi;
  final double resul_medi;
  final int idTipomedi;
  final int idpersona;
  
 

  Medicion(
      {this.idmediciones,
      this.primeraMedicion,
      this.fecha_medi,
      this.hora_medi,
      this.resul_medi,
      this.idTipomedi,
      this.idpersona
      });

  Medicion.fromJson(Map<String, dynamic> jsonMap)
      : idmediciones = jsonMap['ID_MEDICION_GLUCOSA'],
        primeraMedicion = jsonMap['PRIMERA_MEDICION'],
        fecha_medi = jsonMap['FECHA_MEDICION_GLUCOSA'],
        hora_medi = jsonMap['HORA_MEDICION_GLUCOSA'],
        resul_medi = jsonMap['RESULTADO_MEDICION_GLUCOSA'],
        idTipomedi = jsonMap['ID_TIPMEDICION'],
        idpersona = jsonMap['ID_PERSONA']
        ;

  Map<String, dynamic> toJson() => {
        "ID_MEDICION_GLUCOSA": idmediciones,
        "PRIMERA_MEDICION": primeraMedicion,
        "FECHA_MEDICION_GLUCOSA": fecha_medi,
        "HORA_MEDICION_GLUCOSA": hora_medi,
        "RESULTADO_MEDICION_GLUCOSA": resul_medi,
        "ID_TIPMEDICION": idTipomedi,
        "ID_PERSONA":idpersona,
        
      };
}
