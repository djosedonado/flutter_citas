import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/loginController.dart';
import 'crear_cuenta.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _keyFrom = GlobalKey<FormState>();
  TextEditingController correoController = TextEditingController();

  TextEditingController contrasenaController = TextEditingController();

  LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Form(
        key: _keyFrom,
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 50,
            ),
            InputLogin(
              controller: correoController,
              texto: 'Correo',
              placeholder: 'Ingrese su correo',
            ),
            const SizedBox(
              height: 20,
            ),
            InputLogin(
              controller: contrasenaController,
              texto: 'Contraseña',
              esContrasena: true,
              placeholder: 'Ingrese la contraseña',
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (_keyFrom.currentState!.validate()) {
                        if (correoController.text.isEmpty ||
                            contrasenaController.text.isEmpty) {
                          Get.snackbar(
                              'Error', 'Todos los campos son requridos',
                              snackPosition: SnackPosition.BOTTOM);
                          return;
                        }
                        loginController.ingresarEmail(
                            correoController.text, contrasenaController.text);
                      }
                    },
                    child: const Text('Iniciar sesion')),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(CrearCuentaPage());
                  },
                  child: const Text('Registrarse'),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class InputLogin extends StatelessWidget {
  final TextEditingController? controller;
  final String texto;
  final dynamic funcion;
  final String? placeholder;
  final bool? esContrasena;
  final TextInputType tipoTeclado;
  final bool editable;

  const InputLogin(
      {Key? key,
      this.controller,
      this.funcion,
      required this.texto,
      this.esContrasena,
      this.placeholder,
      this.tipoTeclado = TextInputType.text,
      this.editable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Campo Vacio";
          } else {
            if (texto == "Contraseña") {
              if (value.length < 6 || value.length > 11) {
                return "El rango es de 6 a 20";
              }
            }
            if (texto == "Correo") {
              if (value!.isEmpty == value.isEmail) {
                return "Dominio Icorrecto";
              }
            }
            if (texto == "Cedula") {
              if (value.length <= 5 || value.length >= 11) {
                return "El nombre es 5 a 11";
              }
            }
            if (texto == 'Telefono') {
              if (value.length != 10) {
                return "Numero Telefono Incorrecto";
              }
            }
            if (texto == 'Direccion') {
              if (value.length <= 5 || value.length >= 40) {
                return "Perro huputa esta la direccion mala";
              }
            }
            if (texto == 'Nombres' || texto == 'Apellidos') {
              if (value.length <= 3 || value.length >= 40) {
                return "Rango es de 3 a 40";
              }
            }
          }
          return null;
        },
        onEditingComplete: funcion,
        controller: controller,
        obscureText: esContrasena ?? false,
        keyboardType: tipoTeclado,
        enabled: editable,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.blue),
          labelText: texto,
          hintText: placeholder ?? '',
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
    );
  }
}
