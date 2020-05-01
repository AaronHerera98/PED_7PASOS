

class TipoCita {
  final int idTipoCita;
  final String nombreTipo;

  TipoCita(
      {this.idTipoCita,
      this.nombreTipo});

  TipoCita.fromJson(Map<String, dynamic> jsonMap)
      : idTipoCita = jsonMap['ID_TIPO_CITAS'],
        nombreTipo= jsonMap['NIOMBRE_TIPO_CITAS'];


  
}
