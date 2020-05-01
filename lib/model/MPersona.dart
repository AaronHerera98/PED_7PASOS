class Persona {
  final int idPersona;
  final int edad;
  final String nombre;
  final int anioscondiabetes;
  final String apellidoPater;
  final String apellidoMater;
  final String fechaInicio;
  final String telefono;
  final String direccion;
  String fotoUrl;

  Persona({
    this.idPersona,
    this.edad,
    this.nombre,
    this.anioscondiabetes,
    this.apellidoPater,
    this.apellidoMater,
    this.fechaInicio,
    this.telefono,
    this.direccion,
    this.fotoUrl,
  });

  Persona.fromJson(Map<String, dynamic> jsonMap)
      : idPersona = jsonMap['ID_PERSONA'],
        edad = jsonMap['EDAD'],
        nombre = jsonMap['NOMBRE'],
        anioscondiabetes = jsonMap['ANIOSCONDIABETES'],
        apellidoPater = jsonMap['APELLIDO_PATER'],
        apellidoMater = jsonMap['APELLIDO_MATER'],
        fechaInicio = jsonMap['FECHA_INICIO'],
        telefono = jsonMap['TELEFONO'],
        direccion = jsonMap['DIRECCION'],
        fotoUrl = jsonMap['FOTO_URL'];
}
