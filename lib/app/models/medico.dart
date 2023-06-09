

import 'package:flutter_citas/app/models/usuario.dart';

class Medico {
  String? id;
  Usuario? usuario;
  String? tipoMedico;
  String? experiencia;
  String? horaInicio;
  String? horaFin;

  Medico({
    this.id, 
    this.tipoMedico, 
    this.experiencia, 
    this.horaInicio, 
    this.horaFin,
    this.usuario
  });

  factory Medico.fromJson(json,id){
    return Medico(
      id: id,
      tipoMedico: json['tipoMedico'],
      experiencia: json['experiencia'],
      horaInicio: json['horaInicio'],
      horaFin: json['horaFin'],
    );
  }

  toJson(){
    return {
      'tipoMedico':tipoMedico,
      'experiencia':experiencia,
      'horaInicio':horaInicio,
      'horaFin':horaFin,
    };
  }

}