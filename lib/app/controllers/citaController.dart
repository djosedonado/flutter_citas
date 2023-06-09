import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/cita.dart';
import '../models/medico.dart';
import 'loginController.dart';

class CitaController extends GetxController {
  String coleccion = 'citas';
  FirebaseFirestore db = FirebaseFirestore.instance;

  LoginController loginController = Get.find();

  Future<void> agregar(Medico medico, DateTime fecha) async {
    Cita cita = Cita(
      uidMedico: medico.id,
      uidPaciente: loginController.usuario.value.id,
      estado: false,
      fecha: fecha
    );
    await db.collection(coleccion).doc().set(cita.toMap()).catchError(
      (e) {
        Get.snackbar('Error', 'Ha ocurrido un error', snackPosition: SnackPosition.BOTTOM);
      }
    ).then(
      (value){
        Get.back();
        Get.snackbar('Ok', 'Se aparto la cita', snackPosition: SnackPosition.BOTTOM);
      }
    );
  }
}