class Cita {
  String? id;
  String? uidPaciente;
  String? uidMedico;
  bool? estado;
  String? receta;
  dynamic fecha;
  bool? sePresento;
  Cita({
    this.id,
    this.uidPaciente,
    this.uidMedico,
    this.estado,
    this.receta = '',
    this.fecha,
    this.sePresento,
  });

  Map<String, dynamic> toMap() {
    return {
      'uidPaciente': uidPaciente,
      'uidMedico': uidMedico,
      'estado': estado,
      'receta': receta,
      'fecha': fecha,
      'sePresento': sePresento,
    };
  }

  factory Cita.fromMap(Map<String, dynamic> map, id) {
    return Cita(
      id: id,
      uidPaciente: map['uidPaciente'],
      uidMedico: map['uidMedico'],
      estado: map['estado'],
      receta: map['receta'],
      fecha: map['fecha'],
      sePresento: map['sePresento'],
    );
  }
}
