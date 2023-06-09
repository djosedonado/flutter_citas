import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/medicoController.dart';
import '../../../models/medico.dart';
import '../../../models/usuario.dart';
import '../login.dart';

class CrearCuentaPageMedico extends StatefulWidget {  

  final Medico? medico;

  const CrearCuentaPageMedico({super.key, this.medico});

  @override
  State<CrearCuentaPageMedico> createState() => _CrearCuentaPageMedicoState();
}

class _CrearCuentaPageMedicoState extends State<CrearCuentaPageMedico> {

  MedicoController medicoController = Get.find();

  TextEditingController cedulaController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController experienciaController = TextEditingController();
  TextEditingController horaInicioContrasController = TextEditingController();
  TextEditingController horaFinContrasController = TextEditingController();
  
  bool estado = true;
  List<String> list = <String>['Seleccione','Masculino', 'Femenino', 'No Binario'];
  List<String> tipoMedicos = <String>['Seleccione tipo de medico','General','Optometrista', 'Cardiologo', 'Odontologo'];

  String dropdownValue = 'Seleccione';
  bool esEditar = false;

  String tipoMedicoSeleccionado = 'Seleccione tipo de medico';
  Medico? medico;

  @override
  void initState(){
    super.initState();

    if(widget.medico != null){
      medico = widget.medico;
      esEditar = true;
      cedulaController.text = medico!.usuario!.cedula!;
      nombreController.text = medico!.usuario!.nombres!;
      apellidoController.text = medico!.usuario!.apellido!;
      telefonoController.text = medico!.usuario!.telefono!;
      direccionController.text = medico!.usuario!.direccion!;
      correoController.text = medico!.usuario!.correo!;
      dropdownValue = medico!.usuario!.genero!;
      estado = medico!.usuario!.estado!;
      tipoMedicoSeleccionado = medico!.tipoMedico!;      
      experienciaController.text = medico!.experiencia!;
      horaInicioContrasController.text = medico!.horaInicio!;
      horaFinContrasController.text = medico!.horaFin!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(esEditar ?'Editar Cuenta': 'Registrar Medico'),
        titleTextStyle: const TextStyle(
          color: Colors.blue,
          // fontSize: 30,
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
          const SizedBox(height: 20,),
          Container(
            margin:const EdgeInsets.symmetric(horizontal:20),
            padding:const EdgeInsets.symmetric(horizontal:10),
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.green),
              borderRadius: BorderRadius.circular(10)
            ),
            child: DropdownButton(
              value: tipoMedicoSeleccionado,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 0,
              ),
              onChanged: (String? value) {
                setState(() {
                  tipoMedicoSeleccionado = value!;
                });
              },
              items: tipoMedicos.map((e) => DropdownMenuItem(value: e, child: Text(e),)).toList()
              ),
          ),
          // const SizedBox(height: 10,),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Cedula', controller: cedulaController,),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Nombres', controller: nombreController,),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Apellidos', controller: apellidoController,),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Telefono', controller: telefonoController,),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Direccion', controller: direccionController,),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Correo', controller: correoController, editable: !esEditar),
          const SizedBox(height: 10,),
          InputLogin(texto: 'Experiencia', controller: experienciaController,),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Genero')
            ],
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal:10),
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     Text('Horario de atencion')
          //   ],
          // ),
          // const SizedBox(height: 20,),
          // Row(
          //   children: [
          //     Expanded(child: InputLogin(texto: 'Inicio', controller: horaInicioContrasController,)),
          //     Expanded(child: InputLogin(texto: 'Fin', controller: horaFinContrasController,)),
          //   ],
          // ),
          medico!=null && medico!.usuario!.tipoUsuario != 3 ? SizedBox( height: 10,) : Padding(
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
                const Text('Activar medico'),
              ],
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: ()async{

                  if(
                    cedulaController.text.isEmpty ||
                    nombreController.text.isEmpty ||
                    apellidoController.text.isEmpty ||
                    telefonoController.text.isEmpty ||
                    direccionController.text.isEmpty ||
                    correoController.text.isEmpty ||
                    experienciaController.text.isEmpty ||
                    dropdownValue == 'Seleccione' ||
                    tipoMedicoSeleccionado == 'Seleccione tipo de medico'
                  ){
                    Get.snackbar('Advertencia', 'Todos los datos son obligatorios',snackPosition: SnackPosition.BOTTOM);
                    return;
                  }

                  Usuario tempUsuario = Usuario(
                    correo: correoController.text,
                    contras: cedulaController.text, 
                    tipoUsuario: 2,
                    nombres: nombreController.text,
                    apellido: apellidoController.text,
                    cedula: cedulaController.text,
                    direccion: direccionController.text,
                    genero: dropdownValue,
                    telefono: telefonoController.text,
                    estado: estado
                  );
                  Medico tempMedico = Medico(
                    usuario: tempUsuario,
                    experiencia: experienciaController.text,
                    horaInicio: horaInicioContrasController.text,
                    horaFin: horaFinContrasController.text,
                    tipoMedico: tipoMedicoSeleccionado
                  );
                  bool respuesta;
                  if(esEditar){
                    tempMedico.id = medico!.id!;
                    tempMedico.usuario!.id = medico!.id!;
                    respuesta= await medicoController.actualizarUsuario(tempMedico);
                  }else{
                    respuesta= await medicoController.crearMedico(tempMedico);
                  }
                  if(respuesta){
                    Get.back();
                    Get.snackbar('ok','${!esEditar ? 'Registrado':'Actualizado'} correctamente', snackPosition: SnackPosition.BOTTOM);
                  }else{
                    Get.snackbar('error','error al ${!esEditar?'editar':'registrar'}', snackPosition: SnackPosition.BOTTOM);
                  }
                }, 
                child: Text(esEditar ? 'Modificar' : 'Registrar')
              ),
            ],
          ), 
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
