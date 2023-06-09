import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/cita.dart';
import 'loginController.dart';


class RecetaController extends GetxController {
  
  String coleccion = 'citas';
  FirebaseFirestore db = FirebaseFirestore.instance;

  LoginController loginController = Get.find();

  Future<void> actualizarCita(Cita cita) async {
    await db.collection(coleccion).doc(cita.id).update(cita.toMap()).catchError(
      (e) {
        Get.snackbar('Error', 'Ha ocurrido un error', snackPosition: SnackPosition.BOTTOM);
      }
    ).then(
      (value){
        Get.back();
        Get.snackbar('Ok', 'Se guardaron los cambios', snackPosition: SnackPosition.BOTTOM);
      }
    );
  }
}