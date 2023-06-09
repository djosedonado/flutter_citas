import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/loginController.dart';
import '../../../models/cita.dart';
import '../../../models/usuario.dart';
import 'asignar_receta.dart';

class PacientesLista extends StatelessWidget {

  LoginController loginController = Get.find();
  TextEditingController busqueda = TextEditingController();
  final cambia = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: busqueda,
          onChanged: (a)=>cambia.value = !cambia.value,
          decoration: InputDecoration(
            prefixIcon: IconButton(onPressed: () => Get.back(),icon:Icon(Icons.arrow_back)),
            labelText: 'Buscar Paciente',
            suffixIcon: IconButton(onPressed: () => Get.back(),icon:Icon(Icons.search)),
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: null,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Obx(
            (){
              cambia.value;
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('citas')
                    .where('uidMedico',
                        isEqualTo: loginController.usuario.value.id)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return SizedBox(
                      height: Get.height - 100,
                      width: Get.width,
                      child:
                          const Center(child: Text('No hay citas')),
                    );
                  }

                  List recetas = snapshot.data!.docs;

                  return Column(
                    children: List.generate(recetas.length, (index) {
                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('usuarios')
                              .doc('${recetas[index].data()['uidPaciente']}')
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot2) {
                            if (!snapshot2.hasData) {
                              return const Center();
                            }

                            Usuario usuario = Usuario.fromJson(
                                snapshot2.data!.data(), snapshot2.data!.id);

                            return 
                            usuario.nombreCompleto.toString().toLowerCase().contains(busqueda.text.toLowerCase()) ||
                            usuario.cedula.toString().toLowerCase().contains(busqueda.text.toLowerCase())
                            ? ListTile(
                              title: Text('${usuario.nombreCompleto}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(usuario.cedula!),
                                  Text(recetas[index].data()['estado']
                                      ? 'Atendido(a)'
                                      : 'Pendiente'),
                                ],
                              ),
                              onTap: () {
                                Get.to(AsignarRecetaPage(usuario: usuario, cita: Cita.fromMap(recetas[index].data(), recetas[index].id,)));
                              },
                            ):Container();
                          });
                    }),
                  );
                }); 
            }
          )
        ],
      )
    );
  }
}