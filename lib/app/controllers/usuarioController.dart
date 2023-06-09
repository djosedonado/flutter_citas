import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/usuario.dart';

class UsuarioController extends GetxController {
  
  String coleccion = 'usuarios';
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Usuario?> obtenerUsuario(id) async {
    Usuario? usuario;
    await db.collection(coleccion).doc(id).get().catchError(
      (e) {}
    ).then(
      (value){
        usuario = Usuario.fromJson(value, value.id);
      }
    );
    return usuario;    
  }
  Future<bool> crearUsuario(Usuario usuario) async {
    bool respuesta = false;
    await db.collection(coleccion).doc(usuario.id).set(usuario.toJson()).catchError(
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
  Future<bool> actualizarUsuario(Usuario usuario) async {
    bool respuesta = false;
    await db.collection(coleccion).doc(usuario.id).update(usuario.toJson()).catchError(
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
  Future<bool> eliminarUsuario(Usuario usuario) async {
    bool respuesta = false;
    await db.collection(coleccion).doc(usuario.id).update({'estado':false}).catchError(
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