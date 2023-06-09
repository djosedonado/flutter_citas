import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../controllers/citaController.dart';
import '../../../models/medico.dart';

class ApartarCitaPage extends StatefulWidget {

  final Medico medico;
  const ApartarCitaPage({super.key, required this.medico});

  @override
  State<ApartarCitaPage> createState() => _ApartarCitaPageState();
}

class _ApartarCitaPageState extends State<ApartarCitaPage> {

  CitaController citaController =  Get.put(CitaController());

  DateTime hora = DateTime(2022);
  DateTime dia = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apartar cita'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SfDateRangePicker(
            view: DateRangePickerView.month,
            initialSelectedDate: dia,
            enablePastDates : false,
            minDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1,),
            onSelectionChanged: (DateRangePickerSelectionChangedArgs arg){
              dia = arg.value;
              setState(() {});
            },
          ),
          TimePickerSpinner(
            is24HourMode: false,
            spacing: 20,
            itemHeight: 60,
            isForce2Digits: true,
            onTimeChange: (time) {
              hora = time;
              setState(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
              DateTime diaCita = DateTime(dia.year, dia.month, dia.day, hora.hour, hora.minute, hora.second);
              citaController.agregar(widget.medico, diaCita);
            }, child: Text('Aceptar')),
          )
        ],
      ),
    );
  }
}