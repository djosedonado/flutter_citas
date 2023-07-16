import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Principal {
  testPrincipal(String texto,dynamic formKey,dynamic controller){
    return MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo Vacio';
                } else {
                  if (texto == 'Contraseña') {
                    if (value.length < 6 || value.length > 11) {
                      return 'El rango es de 6 a 20';
                    }
                  }
                  if (texto == 'Correo') {
                    if (!value.isEmail) {
                      return 'Dominio Incorrecto';
                    }
                  }
                  if (texto == 'Cedula') {
                    if (value.length <= 5 || value.length >= 11) {
                      return 'El rango es de 5 a 11';
                    }
                  }
                  if (texto == 'Telefono') {
                    if (value.length != 10) {
                      return 'Numero Telefono Incorrecto';
                    }
                  }
                  if (texto == 'Direccion') {
                    if (value.length <= 5 || value.length >= 40) {
                      return 'La dirección debe tener entre 5 y 40 caracteres';
                    }
                  }
                  if (texto == 'Nombres' || texto == 'Apellidos') {
                    if (value.length <= 3 || value.length >= 40) {
                      return 'El rango es de 3 a 40';
                    }
                  }
                }
                return null;
              },
              controller: controller,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.blue),
                labelText: texto,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue, width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue, width: 3),
                ),
              ),
            ),
          ),
        ),
      );
  }
}