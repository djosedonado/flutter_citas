import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/loginController.dart';
import '../../../controllers/medicoController.dart';
import '../../../models/medico.dart';
import '../../../models/usuario.dart';
import '../crear_cuenta.dart';
import '../login.dart';
import 'crear_cuenta_medico.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {

  MedicoController medicoController = Get.find();
  LoginController loginController = Get.find();

  TextEditingController textobuscarController = TextEditingController();
  TextEditingController claveActualController = TextEditingController();
  TextEditingController claveNuevaController = TextEditingController();
  TextEditingController confirmacionClaveNuevaController = TextEditingController();


  final lista = [].obs;
  final cambiaBusqueda = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Administrador'),
        actions: <Widget>[
          PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: ListTile(
                        onTap: (){
                          Get.back();
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
                        trailing: const Icon(Icons.lock),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        onTap: ()=>Get.offAll(LoginPage()) ,
                        title: const Text('Cerrar sesion'),
                        trailing: const Icon(Icons.exit_to_app),
                      ),
                    ),
                  ]),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: textobuscarController,
              onChanged: (e){
                cambiaBusqueda.value = !cambiaBusqueda.value;
              },
              decoration: const InputDecoration(
                labelText: 'buscar',
              ),
            )
          ),
        ),
      ),
      body: ListView(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('usuarios').where('tipoUsuario', isNotEqualTo: 3 ).snapshots(),
            builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('no hay medicos'),
                  ],
                ));
              }else{
                lista.value = snapshot.data!.docs;
                return Obx(
                  (){
                    cambiaBusqueda.value;
                    return Column(
                      children: List.generate(
                        lista.length, 
                        (index) {
                          Usuario usuario = Usuario.fromJson(lista[index], lista[index].id);
                          return usuario.nombreCompleto.toString().toLowerCase().contains(textobuscarController.text.toLowerCase()) ? ListTile(
                            title: Text(usuario.nombreCompleto),
                            subtitle: Text(usuario.tipoUsuario == 1 ? 'Paciente' : 'Medico'),
                            onTap: ()async{
                              if(usuario.tipoUsuario == 1){
                                Get.to(CrearCuentaPage(usuario: usuario,));
                              }else{
                                Medico medico = await medicoController.obtener(usuario.id);
                                medico.usuario = usuario;
                                Get.to(CrearCuentaPageMedico(medico: medico,));
                              }
                            },
                          ):Container();
                        }
                      ),
                    );
                  }
                );
              }
            }
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Get.to(const CrearCuentaPageMedico()),
        child: const Icon(Icons.add),
      ),
    );
  }
}