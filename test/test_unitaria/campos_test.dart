import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'principal_test.dart';

void main() {
  group('login', () {
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController();
    String texto = "";
    String? validationMessage;
    testWidgets('Correo test', (WidgetTester tester) async {
      texto = "Correo";
      await tester
          .pumpWidget(Principal().testPrincipal(texto, formKey, controller));
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Campo Vacio'), findsOneWidget);

      controller.text = 'example';
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Dominio Incorrecto'), findsOneWidget);
      //formKey.currentState!.save();
    });

    testWidgets('Password test', (WidgetTester tester) async {
      texto = "Contraseña";
      await tester
          .pumpWidget(Principal().testPrincipal(texto, formKey, controller));
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Campo Vacio'), findsOneWidget);

      controller.text = '12345';
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('El rango es de 6 a 20'), findsOneWidget);
    });

    testWidgets('Cedula test', (WidgetTester tester) async{
      texto = "Cedula";
      await tester
          .pumpWidget(Principal().testPrincipal(texto, formKey, controller));
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Campo Vacio'), findsOneWidget);

      controller.text = '12345';
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('El rango es de 5 a 11'), findsOneWidget);
    });

    testWidgets('Telefono test', (WidgetTester tester) async{
      texto = "Telefono";
      await tester
          .pumpWidget(Principal().testPrincipal(texto, formKey, controller));
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Campo Vacio'), findsOneWidget);

      controller.text = 'juan';
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Numero Telefono Incorrecto'), findsOneWidget);
    });

    testWidgets('Direccion test', (WidgetTester tester) async{
      texto = "Direccion";
      await tester
          .pumpWidget(Principal().testPrincipal(texto, formKey, controller));
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Campo Vacio'), findsOneWidget);

      controller.text = '1234';
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('La dirección debe tener entre 5 y 40 caracteres'), findsOneWidget);
    });

    testWidgets('Nombre test', (WidgetTester tester) async{
      texto = "Nombres";
      await tester
          .pumpWidget(Principal().testPrincipal(texto, formKey, controller));
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Campo Vacio'), findsOneWidget);

      controller.text = '123';
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('El rango es de 3 a 40'), findsOneWidget);
    });

    testWidgets('Apellido test', (WidgetTester tester) async{
      texto = "Apellidos";
      await tester
          .pumpWidget(Principal().testPrincipal(texto, formKey, controller));
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Campo Vacio'), findsOneWidget);

      controller.text = 'jks';
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('El rango es de 3 a 40'), findsOneWidget);
    });

  });
}
