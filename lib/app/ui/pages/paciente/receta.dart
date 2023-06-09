import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/loginController.dart';
import '../../../models/usuario.dart';

class RecetasPage extends StatefulWidget {
  const RecetasPage({super.key});

  @override
  State<RecetasPage> createState() => _RecetasPageState();
}

class _RecetasPageState extends State<RecetasPage> {
  LoginController loginController = Get.find();
  final tipo = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citas'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Obx(
            () {
            return  Column(
                children: [
                  Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () => tipo.value = true,
                            child: Text('Atendidas', style: TextStyle(color: tipo.value == true ? Colors.blue : Colors.grey),))),
                    Expanded(
                        child: TextButton(
                            onPressed: () => tipo.value = false,
                            child: Text('Pendientes', style: TextStyle(color: tipo.value == false ? Colors.blue : Colors.grey),))),
                  ],
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('citas')
                        .where('uidPaciente',
                            isEqualTo: loginController.usuario.value.id)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return SizedBox(
                          height: Get.height - 100,
                          width: Get.width,
                          child:
                              const Center(child: Text('Aun no tienes citas')),
                        );
                      }

                      List recetas = snapshot.data!.docs;

                      return Column(
                        children: List.generate(recetas.length, (index) {
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('usuarios')
                                  .doc('${recetas[index].data()['uidMedico']}')
                                  .snapshots(),
                              builder:
                                  (BuildContext context, AsyncSnapshot snapshot2) {
                                if (!snapshot2.hasData) {
                                  return const Center();
                                }

                                Usuario usuario = Usuario.fromJson(
                                    snapshot2.data!.data(), snapshot2.data!.id);

                                return recetas[index].data()['estado'] == tipo.value ?

                                ListTile(
                                  title: Text('Dr. ${usuario.nombreCompleto}'),
                                  subtitle: Text(recetas[index].data()['estado']
                                      ? 'Atendida'
                                      : 'Pendiente'),
                                  onTap: () {
                                    Get.to(DetalleReceta(
                                      nombreMedico: usuario.nombreCompleto,
                                      tipoMendico: '',
                                      strReceta: recetas[index].data()['receta'] ??
                                          'Pendiente',
                                    ));
                                  },
                                ) : Container();
                              });
                        }),
                      );
                    })
                ],
              );
            }
          ),
          
        ],
      ),
    );
  }
}

class DetalleReceta extends StatefulWidget {
  String nombreMedico;
  String tipoMendico;
  String strReceta;

  DetalleReceta({
    Key? key,
    required this.nombreMedico,
    required this.tipoMendico,
    required this.strReceta,
  }) : super(key: key);

  @override
  State<DetalleReceta> createState() => _DetalleRecetaState();
}

class _DetalleRecetaState extends State<DetalleReceta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Nombre del medico:'),
          const SizedBox(height: 10,),
          Text('Dr. ${widget.nombreMedico}'),
          const SizedBox(height: 10,),
          Text('Receta:'),
          const SizedBox(
            height: 10,
          ),
          Text(widget.strReceta)
        ],
      ),
    );
  }
}
