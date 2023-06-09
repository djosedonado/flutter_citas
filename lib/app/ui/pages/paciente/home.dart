import 'package:flutter/material.dart';
import 'package:flutter_citas/app/ui/pages/paciente/receta.dart';
import 'package:get/get.dart';
import 'medicos_lista.dart';
import 'opciones.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home.jpg'),
            fit: BoxFit.cover
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: const [
                  Text('Categorias', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                ],
              ),
              const SizedBox(height: 20,),
               Row(
                children: [
                   IconoCategorias(
                    color: const Color(0xFF6482C1), 
                    rutaIMG: 'assets/medicinaGeneral.png',
                    accion: ()=>Get.to(MedicosListPage(tipoMedico: 0,)),
                  ),
                  const SizedBox(width: 10,),
                  IconoCategorias(
                    color: const Color(0xFFFFC80B), 
                    rutaIMG: 'assets/cardiologia.png',
                    accion: ()=>Get.to(MedicosListPage(tipoMedico: 1,)),
                  ),
                  const SizedBox(width: 10,),
                  IconoCategorias(
                    color: const Color(0xFF68C291), 
                    rutaIMG: 'assets/optometria.png',
                    accion: ()=>Get.to(MedicosListPage(tipoMedico: 2,)),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                   IconoCategorias(
                    color: const Color(0xFFFFC80B), 
                    rutaIMG: 'assets/odontologia.png',
                    accion: ()=>Get.to(MedicosListPage(tipoMedico: 3,)),
                  ),
                  const SizedBox(width: 10,),
                  IconoCategorias(
                    color: Color(0xFF68C291), 
                    rutaIMG: 'assets/medicamento.png',
                    accion: ()=>Get.to(RecetasPage()),
                  ),
                  const SizedBox(width: 10,),
                  IconoCategorias(
                    color: const Color(0xFF6482C1), 
                    rutaIMG: 'assets/mas.png',
                    accion: ()=>Get.to(OpcionesPage()),
                  ),
                ],
              ),
              const SizedBox(height: 80,)
            ],
          ),
        ),
      ),
    );
  }
}

class IconoCategorias extends StatelessWidget {

  final Color color;
  final String rutaIMG;
  final accion;

  const IconoCategorias({
    Key? key, required this.color, required this.rutaIMG, this.accion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: accion,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          width: 50,
          height: 80,
          child: Image.asset(
            rutaIMG
          ),
        ),
      )
    );
  }
}