import '../services/repositorio.dart';
import 'dart:convert';
import '../model/MTipoCita.dart';

class CTipoCita {
  static List<TipoCita> listaTcitas;
  static String tipoCita;
  CTipoCita.getTipocita(int i) {
    API.gettipocita(i).then((response) {
      listaTcitas = new List<TipoCita>();
      Iterable list = json.decode(response.body);
      listaTcitas = list.map((model) => TipoCita.fromJson(model)).toList();
      tipoCita = listaTcitas[0].nombreTipo;
    });
  }
  CTipoCita.getTipo(int i) {
    API.gettipocita(i).then((response) {
      listaTcitas = new List<TipoCita>();
      Iterable list = json.decode(response.body);
      listaTcitas = list.map((model) => TipoCita.fromJson(model)).toList();
      tipoCita = listaTcitas[0].nombreTipo;
      return tipoCita;
    });
  }
}
