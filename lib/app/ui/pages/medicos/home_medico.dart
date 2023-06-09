import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'opciones_medico.dart';
import 'pacientes_lista.dart';

class HomePageMedico extends StatelessWidget {
  const HomePageMedico({super.key});

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconoCategorias(
                    color: Colors.blue, 
                    imagen: Icons.person,
                    es_icono: true,
                    accion: ()=>Get.to(PacientesLista()),
                  ),
                  const SizedBox(width: 10,),
                  IconoCategorias(
                    color: const Color(0xFF6482C1), 
                    imagen: 'assets/mas.png',
                    accion: ()=>Get.to(OpcionesPageMedico()),
                  ),
                ],
              ),
              const SizedBox(height: 120,)
            ],
          ),
        ),
      ),
    );
  }
}

class IconoCategorias extends StatelessWidget {

  final Color color;
  final imagen;
  final accion;
  final es_icono;

  const IconoCategorias({
    Key? key, required this.color, required this.imagen, this.accion, this.es_icono = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: accion,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        width: 80,
        height: 80,
        child: es_icono ? Icon(imagen, color: Colors.white, size: 50,) : Image.asset(
          imagen
        ),
      ),
    );
  }
}