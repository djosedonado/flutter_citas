import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/medico.dart';
import '../models/usuario.dart';
import 'loginController.dart';
import 'usuarioController.dart';

class MedicoController extends GetxController {
  String coleccion = 'medicos';
  FirebaseFirestore db = FirebaseFirestore.instance;

  LoginController loginController = Get.find();

  Future<Medico> obtener(id) async {
    Medico medico = Medico();
    await db.collection(coleccion).doc(id).get().catchError(
      (e) {
        medico = Medico();
      }
    ).then(
      (value){
        medico = Medico.fromJson(value, value.id);
      }
    );
    return medico;    
  }
  Future<bool> crearMedico(Medico medico) async {
    // bool respuesta = false;

    Usuario? respuesta = await loginController.registraEmail(medico.usuario!);

    if(respuesta == null){
      return false;
    }

    bool creado = false;

    await db.collection(coleccion).doc(respuesta.id).set(medico.toJson()).catchError(
      (e) {
        creado = false;
      }
    ).then(
      (value){
        creado = true;
      }
    );
    return creado;    
  }
  Future<bool> actualizarUsuario(Medico medico) async {

    bool respuesta = await UsuarioController().actualizarUsuario(medico.usuario!);

    if(!respuesta){
      return false;
    }

    bool actualizado = false;
    
    await db.collection(coleccion).doc(medico.id).update(medico.toJson()).catchError(
      (e) {
        actualizado = false;
      }
    ).then(
      (value){
        actualizado = true;
      }
    );
    return actualizado;   
  }
  Future<bool> eliminarUsuario(Medico medico) async {
    bool respuesta = false;
    await db.collection(coleccion).doc(medico.id).update({'estado':false}).catchError(
      (e) {
        respuesta = false;
      }
    ).then(
      (value){
        respuesta = true;
      }
    );
    return respuesta;    
  }
}