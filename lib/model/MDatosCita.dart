
class DatosCita {
  final int idDatosCita;
  final String asis;
  final String fecha;
  final String hora;


  DatosCita(
      {this.idDatosCita,this.asis,this.fecha,this.hora});

  DatosCita.fromJson(Map<String, dynamic> jsonMap)
      : idDatosCita = jsonMap['ID_CITAS'],
        asis = jsonMap['ASISTENCIA'],
        fecha = jsonMap['FECHA_CITA'],
        hora=jsonMap['HORA_CITA'];
        
}
