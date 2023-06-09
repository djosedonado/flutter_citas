class Usuario {
  String? id;
  int? tipoUsuario;
  String? cedula;
  String? nombres;
  String? apellido;
  String? telefono;
  String? direccion;
  String? correo;
  dynamic foto;
  String? genero;
  String? contras;
  bool? estado;
  
  Usuario({
    this.id, 
    this.tipoUsuario, 
    this.cedula, 
    this.nombres, 
    this.apellido, 
    this.telefono, 
    this.direccion, 
    this.correo, 
    this.foto, 
    this.genero, 
    this.contras,
    this.estado
  });

  get nombreCompleto{
    return '$nombres $apellido';
  }

  factory Usuario.fromJson(json,id){
    return Usuario(
      id: id,
      tipoUsuario: json['tipoUsuario'],
      cedula: json['cedula'],
      nombres: json['nombres'],
      apellido: json['apellido'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      correo: json['correo'],
      foto: json['foto'],
      genero: json['genero'],
      estado: json['estado'],
    );
  }

  toJson(){
    return {
      'tipoUsuario':tipoUsuario,
      'cedula':cedula,
      'nombres':nombres,
      'apellido':apellido,
      'telefono':telefono,
      'direccion':direccion,
      'correo':correo,
      'foto':foto,
      'genero':genero,
      'estado':estado,
    };
  }
}