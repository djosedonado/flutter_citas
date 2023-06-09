

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/loginController.dart';
import '../../controllers/usuarioController.dart';
import '../../models/usuario.dart';
import 'login.dart';

class CrearCuentaPage extends StatefulWidget {  

  final Usuario? usuario;

  const CrearCuentaPage({super.key, this.usuario});

  @override
  State<CrearCuentaPage> createState() => _CrearCuentaPageState();
}

class _CrearCuentaPageState extends State<CrearCuentaPage> {

  LoginController loginController = Get.find();
  UsuarioController usuarioController = Get.find();

  TextEditingController cedulaController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController contrasController = TextEditingController();
  TextEditingController confirmContrasController = TextEditingController();
  
  List<String> list = <String>['Seleccione','Masculino', 'Femenino', 'No Binario'];

  String dropdownValue = 'Seleccione';
  bool esEditar = false;
  bool estado = true;

  @override
  void initState() {
    if(widget.usuario != null){
      Usuario usuario = widget.usuario!;
      esEditar = true;
      cedulaController.text = usuario.cedula!;
      nombreController.text = usuario.nombreCompleto!;
      apellidoController.text = usuario.apellido!;
      telefonoController.text = usuario.telefono!;
      direccionController.text = usuario.direccion!;
      correoController.text = usuario.correo!;
      dropdownValue = usuario.genero!;
    }
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(esEditar ?'Editar Cuenta': 'Crea tu cuenta'),
        titleTextStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(
              'assets/logo.png',
              width: 50,
              height: 50,
            ),
          )
        ],
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10,),
          InputLogin(texto: 'Cedula',controller: cedulaController,tipoTeclado: TextInputType.number,),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Nombres',controller: nombreController,),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Apellidos',controller: apellidoController,),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Telefono',controller: telefonoController,tipoTeclado: TextInputType.number,),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Direccion',controller: direccionController,),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Correo', controller: correoController, editable: !esEditar,),
          const SizedBox(height: 10,),
          esEditar ? Container() : Column(
            children: [
              InputLogin(texto: 'Contraseña', controller: contrasController, esContrasena: true,),
              const SizedBox(height: 10,),
              InputLogin(texto: 'Confirmacion de Contraseña',controller: confirmContrasController, esContrasena: true,),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Genero')
            ],
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(horizontal:10),
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.green),
              borderRadius: BorderRadius.circular(10)
            ),
            child: DropdownButton(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 0,
              ),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map((e) => DropdownMenuItem(value: e, child: Text(e),)).toList()
              ),
          ),

          esEditar && loginController.usuario.value.tipoUsuario == 3 ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  value: estado,
                  onChanged: (bool? value) {                    
                    setState(() {
                      estado = value!;
                    });
                  },
                ),
                const Text('Activar paciente'),
              ],
            ),
          ) : Container(),
          Column(
            children: [
              ElevatedButton(
                onPressed: () async {

                  if(!cedulaController.text.isNum){
                    Get.snackbar('Error', 'La cedula es numerica', snackPosition: SnackPosition.BOTTOM);
                    return;
                  }
                  if(!telefonoController.text.isNum){
                    Get.snackbar('Error', 'La cedula es numerica', snackPosition: SnackPosition.BOTTOM);
                    return;
                  }
                  if(
                    cedulaController.text.isEmpty ||
                    nombreController.text.isEmpty ||
                    apellidoController.text.isEmpty ||
                    telefonoController.text.isEmpty ||
                    direccionController.text.isEmpty ||
                    correoController.text.isEmpty
                  ){
                    Get.snackbar('Error', 'Todos los datos son obligatorios', snackPosition: SnackPosition.BOTTOM);
                    return;
                  }
                  if(!esEditar){
                    if(contrasController.text.isEmpty || confirmContrasController.text.isEmpty){
                      Get.snackbar('Error', 'Todos los datos son obligatorios', snackPosition: SnackPosition.BOTTOM);
                      return;
                    }
                    if(contrasController.text != confirmContrasController.text){
                      Get.snackbar('Error', 'Las contraseñas no coinciden', snackPosition: SnackPosition.BOTTOM);
                      return;
                    }
                  }

                  Usuario tempUsuario = Usuario(
                    correo: correoController.text,
                    contras: contrasController.text, 
                    tipoUsuario: 1,
                    nombres: nombreController.text,
                    apellido: apellidoController.text,
                    cedula: cedulaController.text,
                    direccion: direccionController.text,
                    genero: dropdownValue,
                    telefono: telefonoController.text,
                    estado: estado
                  );
                  if(esEditar){
                    tempUsuario.id = widget.usuario!.id!;
                    bool response = await usuarioController.actualizarUsuario(tempUsuario);
                    if(response){
                      Get.snackbar('Actualizado', 'Se actualizó correctamente', snackPosition: SnackPosition.BOTTOM);
                    }else{
                      Get.snackbar('Error', 'Ha ocurrido un error al actualizar la cuenta', snackPosition: SnackPosition.BOTTOM);
                    }
                  }else{
                    Usuario? usuRes = await loginController.registraEmail(tempUsuario);
                    if(usuRes!=null){
                      Get.snackbar('Creado', 'Se creo correctamente', snackPosition: SnackPosition.BOTTOM);
                    }else{
                      Get.snackbar('Error', 'Ha ocurrido un error al crear la cuenta', snackPosition: SnackPosition.BOTTOM);
                    }
                  }
                }, 
                child: Text(esEditar ? 'Modificar' : 'Registrarse')
              ),
            ],
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
