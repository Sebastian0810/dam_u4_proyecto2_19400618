import 'package:dam_u4_proyecto2_19400618/servicios/servicios.dart';
import 'package:flutter/material.dart';

class AgregarAsignacion extends StatefulWidget {
  const AgregarAsignacion({Key? key}) : super(key: key);

  @override
  State<AgregarAsignacion> createState() => _AgregarAsignacionState();
}

List Salon = ["CV1", "CV2", "CV3", "TSO","CISCO1","CISCO2", "L1", "L2", "L3", "UVP1", "UVP2", "UVP3",
"UD1", "UD2", "UD3", "A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"];
String _Salon = Salon.first;

List Edificio = ["CV", "LC", "LICBI", "UVP", "UD", "A", "B", "C"];
String _Edificio = Edificio.first;

class _AgregarAsignacionState extends State<AgregarAsignacion> {
  TextEditingController horario = TextEditingController(text: "");
  TextEditingController docente = TextEditingController(text: "");
  TextEditingController materia = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Agregar asignación"),
            centerTitle: true,
            backgroundColor: Colors.purple
        ),

        body: ListView(padding: EdgeInsets.all(15),
            children: [
              Column(
                children:[
                  DropdownButtonFormField(
                    value: _Edificio,
                    items: Edificio.map((value){
                      return DropdownMenuItem(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        _Edificio = value.toString();
                      });
                    }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.purple),
                    decoration: InputDecoration(labelText: "Selecciona el edificio",
                        prefixIcon: Image.asset('assets/maestro.png', width: 10, height: 10, scale: 15),
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10),

                  DropdownButtonFormField(
                    value: _Salon,
                    items: Salon.map((value){
                      return DropdownMenuItem(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        _Salon = value.toString();
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
                    await agregarAsignacion(_Edificio.toString(), _Salon.toString(), horario.text, docente.text,
                    materia.text).then((_) {
                      Navigator.pop(context);
                    });
                  }, child: const Text("Guardar"),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.purple
                    ),
                  )
                ],
              )
            ]
        )
    );
  }
}