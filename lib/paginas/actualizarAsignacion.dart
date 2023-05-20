import 'package:dam_u4_proyecto2_19400618/servicios/servicios.dart';
import 'package:flutter/material.dart';

class ActualizarAsignacion extends StatefulWidget {
  const ActualizarAsignacion({Key? key}) : super(key: key);

  @override
  State<ActualizarAsignacion> createState() => _ActualizarAsignacionState();
}

List Salon = ["A1", "A2", "UD1", "MTI"];
List Edificio = ["A", "J", "UVP", "LICBI"];

class _ActualizarAsignacionState extends State<ActualizarAsignacion> {
  TextEditingController horario = TextEditingController(text: "");
  TextEditingController docente = TextEditingController(text: "");
  TextEditingController materia = TextEditingController(text: "");

  String edificio = "";
  String salon = "";

  @override
  Widget build(BuildContext context) {
    final Map argumentos = ModalRoute.of(context)!.settings.arguments as Map;
    horario.text = argumentos['horario'];
    docente.text = argumentos['docente'];
    materia.text = argumentos['materia'];

    //Combobox
    edificio = argumentos['salon'];
    salon = argumentos['edificio'];

    return Scaffold(
        appBar: AppBar( title: const Text("Editar asignación"), centerTitle: true, backgroundColor: Colors.purple),

        body: ListView(padding: EdgeInsets.all(15),
            children: [
              Column(
                children: [
                  DropdownButtonFormField(
                    value: edificio,
                    items: Edificio.map((value){
                      return DropdownMenuItem(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        edificio = value.toString();
                      });
                    }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.purple),
                    decoration: InputDecoration(labelText: "Selecciona el edificio",
                        prefixIcon: Image.asset('assets/maestro.png', width: 10, height: 10, scale: 15),
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10),

                  DropdownButtonFormField(
                    value: salon,
                    items: Salon.map((value){
                      return DropdownMenuItem(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        salon = value.toString();
                      });
                    }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.purple),
                    decoration: InputDecoration(labelText: "Selecciona el salon",
                        prefixIcon: Image.asset('assets/maestro.png', width: 10, height: 10, scale: 15),
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10),

                  TextField(decoration: const InputDecoration(labelText: "Materia",
                      hintText: "Ingrese la materia"),
                      controller: materia),
                  SizedBox(height: 30),

                  TextField(decoration: const InputDecoration(labelText: "Horario",
                      hintText: "Ingrese el horario de la materia"),
                      controller: horario),
                  SizedBox(height: 30),

                  TextField(decoration: const InputDecoration(labelText: "Docente",
                      hintText: "Ingrese el docente"),
                      controller: docente),
                  SizedBox(height: 30),

                  ElevatedButton(onPressed: () async{
                    await actualizarAsignacion(salon.toString(), edificio.toString(), horario.text,
                    docente.text, materia.text, argumentos['id']).then((_) {
                      Navigator.pop(context);
                    });
                  },child: const Text("Actualizar"),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.purple)
                  )
                ],
              )
            ]
        )
    );
  }
}