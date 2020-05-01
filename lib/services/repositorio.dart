import 'package:los_7_pasos/model/MCita.dart';
import '../model/MMedicionDiaria.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../model/MPersona.dart';
import '../model/MUsuario.dart';

final String url = 'http://www.dbdiabetes.somee.com/api';
class API {
  static Future getPerso(int id) {
    var url = 'http://www.dbdiabetes.somee.com/api/usuario/${id}/obperson';
    return http.get(url);
  }
  static Future getCita(int i) {
    var url = 'http://dbdiabetes.somee.com/api/citas/${i}/obcitas';
    return http.get(url);
  }
  static Future gettipocita(int i) {
    var url = 'http://dbdiabetes.somee.com/api/citas/${i}/tipocita';
    return http.get(url);
  }
  static Future gettDatos(int i) {
    var url = 'http://dbdiabetes.somee.com/api/citas/${i}//datoscita';
    return http.get(url);
  }
  static Future getEspe(int i) {
    var url = 'http://dbdiabetes.somee.com/api/citas/${i}/obesp';
    return http.get(url);
  }
}




Future<Stream<Cita>> getCita() async {
  final String link = '${url}/Cita/';
  final Client = new http.Client();
  final streamedRest = await Client.send(http.Request('get', Uri.parse(link)));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Cita.fromJson(data));
}

Future<Stream<Persona>> getPersona(int id) async {
  final String link ='http://www.dbdiabetes.somee.com/api/usuario/${id}/obperson';
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(link)));

  if (streamedRest.statusCode == 200) {
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((data) => (data as List))
        .map((data) => Persona.fromJson(data));
  } else {
    print("Error get Persona");
  }
}


Future<Stream<Usuario>> getUsuario() async {
  final String url = 'http://www.dbdiabetes.somee.com/api/usuario/allusuarios';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
  if (streamedRest.statusCode == 200) {
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((data) => (data as List))
        .map((data) => Usuario.fromJson(data));
  } else {
    print("Error getUsuario");
  }
}
Future<dynamic> login(String tel,String con) async {
String url='http://www.dbdiabetes.somee.com/api/usuario/login';
  Map body={"TELEFONO":"${tel}","CONTRASENA":"${con}"};
  final response = await http.post(url, body: body);
  return http.post(url, body: body).then((http.Response response) {
    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Usuario.fromJson(json.decode(response.body));
  });
}
Future<dynamic> medicion(String tel,String con) async {
String url='http://www.dbdiabetes.somee.com/api/usuario/login';
  Map body={"TELEFONO":"${tel}","CONTRASENA":"${con}"};
  final response = await http.post(url, body: body);
  return http.post(url, body: body).then((http.Response response) {
    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Usuario.fromJson(json.decode(response.body));
  });
}
Future<http.Response> crearmedicion(Medicion medicion) async {
  final response = await http.post('${url}/api/glucosa/saveglucosa',
      headers: {
        HttpHeaders.contentEncodingHeader: 'application/json',
        HttpHeaders.contentTypeHeader:'application/json'
      },
      body: medicionJson(medicion));
  return response;
}
//