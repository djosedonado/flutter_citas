import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/pages/crear_cuenta.dart';
import 'ui/pages/login.dart';
import 'ui/pages/paciente/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(),
        '/crearcuenta': (context) => CrearCuentaPage(),
        '/home': (context) => HomePage(),
      },
      initialRoute: '/login',
    );
  }
}