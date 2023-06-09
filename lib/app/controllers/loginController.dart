import 'package:flutter_citas/app/controllers/usuarioController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/usuario.dart';
import '../ui/pages/admin/home_admin.dart';
import '../ui/pages/medicos/home_medico.dart';
import '../ui/pages/paciente/home.dart';

class LoginController extends GetxController {
  
  final usuario = Usuario().obs;
  
  FirebaseAuth authf = FirebaseAuth.instance;
  final usuarioSesion = Usuario().obs;

  UsuarioController usuarioController = Get.put(UsuarioController());

  Future<Usuario?> registraEmail(Usuario usuario) async {
    try {
      UserCredential user = await authf.createUserWithEmailAndPassword(email: usuario.correo!, password: usuario.contras!);
      usuario.id = await user.user!.uid;
      bool respuesta = await usuarioController.crearUsuario(usuario);
      if(respuesta){
        return usuario;
      }else{
        return null;
      }
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  Future<bool> cambiarClave(String actual, String nuevaClave) async {
    datosSesion();
    try {
      await authf.signOut();
      await authf.signInWithEmailAndPassword(email: usuario.value.correo!, password: actual);
      await authf.currentUser!.updatePassword(nuevaClave).then((value) => print('si')).catchError((e)=>print(e));
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }
  Future<void> ingresarEmail(String email, String passwd) async {
    try {
      UserCredential user = await authf.signInWithEmailAndPassword(email: email, password: passwd);
      usuario.value = await usuarioController.obtenerUsuario(user.user!.uid) ?? Usuario();

      if(usuario.value.id == null){
        Get.snackbar('Error', 'Usuario y o contraseñas no validos', snackPosition: SnackPosition.BOTTOM);
      }else if(usuario.value.tipoUsuario == 3){
        Get.to(const HomeAdminPage());
      }else if(usuario.value.tipoUsuario == 2){
        Get.to(const HomePageMedico());
      }else{
        Get.to(const HomePage());
      }
    } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', 'Usuario y o contraseñas no validos', snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<void> cerrarSesion() async {
    try {
      await authf.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void datosSesion() {
    User? user;
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        print(user);
      }
    );
  }
}