import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/app.dart';
import 'app/controllers/loginController.dart';
import 'app/controllers/medicoController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyC9z0KK7DczHBLDU9wIWrAejtKFC9FQvCw",
              authDomain: "tuappcita-b99f6.firebaseapp.com",
              projectId: "tuappcita-b99f6",
              storageBucket: "tuappcita-b99f6.appspot.com",
              messagingSenderId: "1000840696549",
              appId: "1:1000840696549:web:7c5fa30c12f7f0261fba0c",
              measurementId: "G-56TE44PVVM"))
      : await Firebase.initializeApp();
  Get.put(LoginController());
  Get.put(MedicoController());
  runApp(const App());
}
