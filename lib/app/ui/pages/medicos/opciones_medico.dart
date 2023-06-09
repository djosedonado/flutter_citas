import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/loginController.dart';
import '../../../controllers/medicoController.dart';
import '../../../models/medico.dart';
import '../admin/crear_cuenta_medico.dart';
import '../login.dart';

class OpcionesPageMedico extends StatefulWidget {
  const OpcionesPageMedico({super.key});

  @override
  State<OpcionesPageMedico> createState() => _OpcionesPageMedicoState();
}

class _OpcionesPageMedicoState extends State<OpcionesPageMedico> {

  TextEditingController claveActualController = TextEditingController();
  TextEditingController claveNuevaController = TextEditingController();
  TextEditingController confirmacionClaveNuevaController = TextEditingController();
  LoginController loginController = Get.find();
  MedicoController medicoController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opciones'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo.png')
          )
        ),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: ()async{
                Medico medico = await medicoController.obtener(loginController.usuario.value.id);
                medico.usuario = loginController.usuario.value;
                Get.to(CrearCuentaPageMedico(medico: medico));
              },
            ), 
            ListTile(
              onTap: (){
                claveActualController.clear();
                claveNuevaController.clear();
                Get.defaultDialog(
                  title: 'Cambiar clave',
                  radius: 10,
                  content: Column(
                    children: [
                      InputLogin(texto: 'Contraseña actual', controller: claveActualController, esContrasena: true,),
                      const SizedBox(height: 10,),
                      InputLogin(texto: 'Contraseña nueva', controller: claveNuevaController, esContrasena: true,),
                      const SizedBox(height: 10,),
                      InputLogin(texto: 'confirmacion Contraseña nueva', controller: confirmacionClaveNuevaController, esContrasena: true,),
                    ],
                  ),
                  confirm: TextButton(
                    onPressed: ()async{
                      if(claveActualController.text.isEmpty || claveNuevaController.text.isEmpty || confirmacionClaveNuevaController.text.isEmpty){
                        Get.snackbar('Error', 'todos los campos son obligatorios', snackPosition: SnackPosition.BOTTOM);
                        return;
                      }
                      if(claveNuevaController.text != confirmacionClaveNuevaController.text){
                        Get.snackbar('Error', 'Las contraseñas no coinciden', snackPosition: SnackPosition.BOTTOM);
                        return;
                      }

                      bool response = await loginController.cambiarClave(claveActualController.text, claveNuevaController.text);
                      if(response){
                        Get.back();
                        Get.snackbar('Ok', 'Contraseña cambiada', snackPosition: SnackPosition.BOTTOM);
                      }else{
                        Get.back();
                        Get.snackbar('Error', 'Error.....', snackPosition: SnackPosition.BOTTOM);
                        Get.offAll(LoginPage());
                      }
                    }, 
                    child: Text('Aceptar')
                  ),
                  cancel: TextButton(onPressed: ()=>Get.back(), child: Text('Cancelar')),
                );
              },
              title: const Text('Cambiar contraseña'),
              leading: const Icon(Icons.lock),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_sharp),
              title: const Text('Cerrar sesion'),
              onTap: ()=>Get.offAll(LoginPage()),
            ),
          ],
        ),
      ),
    );
  }
}