import 'package:flutter/material.dart';
import 'package:flutter_citas/app/ui/pages/validacion.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test de correo vacio', () {
    var validaciones = Validacion().ValidacionCorreo("");
    expect(validaciones, "Campo Vacio");
  });

  test('correo', (){
    
  });
}
