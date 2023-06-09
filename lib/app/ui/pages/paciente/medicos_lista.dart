import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/medico.dart';
import '../../../models/usuario.dart';
import 'apartar_cita.dart';

class MedicosListPage extends StatelessWidget {

  final int tipoMedico;
  TextEditingController busqueda = TextEditingController();
  final cambia = false.obs;

  MedicosListPage({super.key, required this.tipoMedico});

  Map medico = {
    0:{
      'imagen':'assets/medicinaGeneral.png',
      'tipo':'General'
    },
    1:{
      'imagen':'assets/cardiologia.png',
      'tipo':'Cardiologo'
    },
    2:{
      'imagen':'assets/optometria.png',
      'tipo':'Optometria'
    },
    3:{
      'imagen':'assets/odontologia.png',
      'tipo':'Odontologo'
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: busqueda,
          onChanged: (a){
            cambia.value = !cambia.value;
          },
          decoration: InputDecoration(
            prefixIcon: IconButton(onPressed: () => Get.back(),icon:Icon(Icons.arrow_back)),
            labelText: 'Buscar medico ${medico[tipoMedico]['tipo']}',
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
                stream: FirebaseFirestore.instance.collection('medicos').where('tipoMedico', isEqualTo: '${medico[tipoMedico]['tipo']}').snapshots(),
                builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                    return SizedBox(
                      height: Get.height - 100,
                      width: Get.width,
                      child: const Center(child: Text('No hay medicos registrados')),
                    );
                  }

                  List medicos = snapshot.data!.docs;
                  return Column(
                    children: List.generate(
                      medicos.length, 
                      (index){
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('usuarios').doc('${medicos[index].id}').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot snapshot2) {
                            if(!snapshot2.hasData){
                              return const Center();
                            }

                            Medico medico = Medico.fromJson(medicos[index].data(), medicos[index].id);
                            Usuario usuario = Usuario.fromJson(snapshot2.data!.data(), snapshot2.data!.id);
                            
                            return usuario.nombreCompleto.toString().toLowerCase().contains(busqueda.text.toLowerCase()) ? ListTile(
                              title: Text('Dr. ${usuario.nombreCompleto}'),
                              subtitle: Text('${medico.experiencia!} ${medico.experiencia == '1' ? 'año':'años'} de experiencia'),
                              onTap: (){
                                Get.to(ApartarCitaPage(medico:  medico,));
                              },
                            ) : Container();
                          }
                        );
                      }
                    ),
                  );
                }
              );
            }
          )
        ],
      ),
    );
  }
}

// class TarjetaMedico extends StatelessWidget {
//   const TarjetaMedico({
//     Key? key,
//     required this.medico,
//     required this.tipoMedico,
//   }) : super(key: key);

//   final Map medico;
//   final int tipoMedico;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         Get.to(ApartarCitaPage());
//       },
//       child: Container(
//           padding: const EdgeInsets.all(20),
//           margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           decoration: BoxDecoration(
//             color: Colors.green,
//             borderRadius: BorderRadius.circular(20)
//           ),
//           child: Row(
//             children: [
//               const Expanded(
//                 flex: 2,
//                 child:  CircleAvatar(
//                   backgroundColor: Color(0xFFFEFEFE),
//                   radius: 20,
//                 ),
//               ),
//               const SizedBox(width :20),
//               Expanded(
//                 flex: 6,
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Dr. David Gilmour',
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                     const Text('10 años de experiencia'),
//                     const SizedBox(height: 10,),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFCCDCF4),
//                         borderRadius: BorderRadius.circular(5)
//                       ),
//                       padding: const EdgeInsets.symmetric(horizontal:20,vertical: 10),
//                       child: Text(
//                         '${medico[tipoMedico]['tipo']}',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF3F6BF3)
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: IconButton(
//                   onPressed: (){
//                     Get.to(ApartarCitaPage());
//                   },
//                   icon: const Icon(
//                     Icons.calendar_month,
//                     size: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//     );
//   }
// }