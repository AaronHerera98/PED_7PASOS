import 'dart:convert';

String usuarioJson(Usuario data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Usuario {
  final int idUsuario;
  final String telefono;
  final String contrasena;
  final int idPersona;
  final int idTipoUsuario;
  final int idEstatus;
 

  Usuario(
      {this.idUsuario,
      this.telefono,
      this.contrasena,
      this.idPersona,
      this.idTipoUsuario,
      this.idEstatus
      });

  Usuario.fromJson(Map<String, dynamic> jsonMap)
      : idUsuario = jsonMap['ID_USUARIO'],
        telefono = jsonMap['TELEFONO'],
        contrasena = jsonMap['CONTRASENA'],
        idPersona = jsonMap['ID_PERSONA'],
        idTipoUsuario = jsonMap['ID_TIPO_USUARIO'],
        idEstatus = jsonMap['ID_ESTATUS']
        ;

  Map<String, dynamic> toJson() => {
        "<ID_USUARIO>k__BackingField": idUsuario,
        "<TELEFONO>k__BackingField": telefono,
        "<CONTRASENA>k__BackingField": contrasena,
        "<ID_PERSONA>k__BackingField": idPersona,
        "<ID_TIPO_USUARIO>k__BackingField": idTipoUsuario,
        "<ID_ESTATUS>k__BackingField": idEstatus,
        
      };
}
