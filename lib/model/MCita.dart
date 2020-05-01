
class Cita {
  int id_Cita;
  final String fecha_cita;
  final String hora_cita;
  final int id_datosCita;
  final int id_tipocita;
  final int id_persona;

  Cita(
      {this.id_Cita,
      this.fecha_cita,
      this.hora_cita,
      this.id_datosCita,
      this.id_tipocita,
      this.id_persona});

  Cita.fromJson(Map<String, dynamic> jsonMap)
      : id_Cita = jsonMap['ID_CITAS'],
        fecha_cita = jsonMap['FECHA_CITA'],
        hora_cita = jsonMap['HORA_CITA'],
        id_datosCita = jsonMap['ID_DATOSCITA'],
        id_tipocita = jsonMap['ID_TIPO_CITAS'],
        id_persona = jsonMap['ID_PERSONA'];
}
