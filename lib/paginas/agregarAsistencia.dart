import 'package:dam_u4_proyecto2_19400618/servicios/servicios.dart';
import 'package:flutter/material.dart';

class AgregarAsistencia extends StatefulWidget {
  const AgregarAsistencia({Key? key}) : super(key: key);

  @override
  State<AgregarAsistencia> createState() => _AgregarAsistenciaState();
}

List Docente = ["Selecciona el docente"];
String _Docente = Docente.first;

class _AgregarAsistenciaState extends State<AgregarAsistencia> {
  TextEditingController revisor = TextEditingController(text: "");
  TextEditingController fecha = TextEditingController(text: "");
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: const Text("Agregar asistencia"),
            centerTitle: true,
            backgroundColor: Colors.purple
        ),

        body: ListView(padding: EdgeInsets.all(15),
            children: [
              Column(
                children:[
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: obtenerDocentes(),
                    builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.hasData) {
                        Docente.clear();
                        Docente.add("Selecciona el docente");
                        return Container(
                          height: 0,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Docente.add(snapshot.data![index]['docente'].toString());
                              fecha.text = date.toString();
                              return Text(snapshot.data![index]['docente'].toString());
                            },
                          ),
                        );
                      }else {return Text("");}
                    },
                  ),

                  DropdownButtonFormField(
                    value: _Docente,
                    items: Docente.map((value){
                      return DropdownMenuItem(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (value){
                      _Docente = value.toString();
                      setState(() {});
                    }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.purple),
                    decoration: InputDecoration(labelText: "Selecciona el docente",
                        prefixIcon: Image.asset('assets/maestro.png', width: 10, height: 10, scale: 15),
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 25),

                  TextFormField(decoration: InputDecoration(labelText: "Fecha",
                      border: OutlineInputBorder(),
                      prefixIcon: Image.asset("assets/calendario.png", height: 30, width: 30, scale: 15,)),
                      controller: fecha,
                      readOnly: true),
                  SizedBox(height: 20),

                  TextField(decoration: const InputDecoration(labelText: "Revisor",
                      hintText: "Ingrese el nombre del revisor"),
                      controller: revisor),
                  SizedBox(height: 20),

                  ElevatedButton(onPressed: () async{
                    await agregarAsistencia(_Docente.toString(), fecha.text, revisor.text).then((_) {
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