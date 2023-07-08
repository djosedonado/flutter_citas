import 'package:flutter/material.dart';
import 'package:flutter_citas/app/controllers/loginController.dart';
import 'package:flutter_citas/app/controllers/usuarioController.dart';
import 'package:flutter_citas/app/ui/pages/crear_cuenta.dart';
import 'package:flutter_citas/app/ui/pages/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group('CrearCuentaPage', () {
    late CrearCuentaPage crearCuentaPage;
    final loginController = Get.put(LoginController());
    final usuarioController = Get.put(UsuarioController());

    setUp(() {
      // Configurar los controladores y otros objetos necesarios para las pruebas
      crearCuentaPage = CrearCuentaPage();
      // Puedes simular la inyección de dependencias necesaria para los controladores si es necesario
    });

    testWidgets('Se muestra la página correctamente', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: crearCuentaPage));

      // Verificar que los elementos esperados se muestren en la página
      expect(find.text('Crea tu cuenta'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      // Agrega más expectativas según los elementos que desees verificar
    });

    testWidgets('Crear cuenta con datos válidos', (WidgetTester tester) async {
      // Configurar el estado de los controladores o widgets necesarios para las pruebas

      await tester.pumpWidget(MaterialApp(home: crearCuentaPage));

      // Simular la entrada de datos en los campos de texto
      await tester.enterText(find.byType(InputLogin).first, '123456789'); // Cedula
      await tester.enterText(find.byType(InputLogin).at(1), 'John'); // Nombres
      await tester.enterText(find.byType(InputLogin).at(2), 'Doe'); // Apellidos
      // Agrega más simulaciones de entrada de datos según los campos que desees probar

      // Simular el toque en el botón de registro
      await tester.tap(find.text('Registrarse'));

      // Esperar a que se procese el evento de toque
      await tester.pumpAndSettle();

      // Verificar que se muestre el mensaje de éxito o cualquier otro resultado esperado
      expect(find.text('Se creo correctamente'), findsOneWidget);
    });

    // Agrega más pruebas según los escenarios que desees probar

    tearDown(() {
      // Liberar los recursos utilizados en las pruebas
      Get.reset();
    });
  });
}
