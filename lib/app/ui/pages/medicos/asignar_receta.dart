import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/recetaController.dart';
import '../../../models/cita.dart';
import '../../../models/usuario.dart';

class AsignarRecetaPage extends StatefulWidget {

  final Usuario usuario;
  final Cita cita;
  const AsignarRecetaPage({super.key, required this.usuario, required this.cita});

  @override
  State<AsignarRecetaPage> createState() => _AsignarRecetaPageState();
}

class _AsignarRecetaPageState extends State<AsignarRecetaPage> {

  RecetaController recetaController = Get.put(RecetaController());

  Usuario usuario = Usuario();
  Cita cita = Cita();

  TextEditingController recetatexto = TextEditingController();

  @override
  void initState() {
    
    usuario = widget.usuario;
    cita = widget.cita;
    recetatexto.text = cita.receta ?? '';
    print(cita.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text('Nombre Completo: ${usuario.nombreCompleto!}'),
          Text('cedula: ${usuario.cedula!}'),
          Text('correo: ${usuario.correo!}'),
          Text('telefono: ${usuario.telefono!}'),
          Text('se presento: ${cita.sePresento == null ? '' : cita.sePresento! ? '👍' : '👎'}'),
          SizedBox(height: 20,),
          TextField(
            controller: recetatexto,
            maxLines: 10,
            decoration: InputDecoration(
            labelStyle: const TextStyle(
              color: Colors.green
            ),
            labelText: 'receta',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.green, width: 3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.green, width: 3),
            ),
          ),
          ), 
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            cita.estado = true;
            cita.sePresento = true;
            cita.receta = recetatexto.text;
            recetaController.actualizarCita(cita);
          }, child: Text('Aceptar')),
          cita.estado! ? Container() : ElevatedButton(onPressed: (){
            cita.estado = true;
            cita.sePresento = false;
            cita.receta = recetatexto.text;
            recetaController.actualizarCita(cita);
          }, child: Text('No se presento')),
        ],
      ),
    );
  }
}