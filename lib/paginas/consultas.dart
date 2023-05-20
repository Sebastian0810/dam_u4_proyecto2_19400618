import 'package:dam_u4_proyecto2_19400618/servicios/servicios.dart';
import 'package:flutter/material.dart';

class Consultas extends StatefulWidget {
  const Consultas({Key? key}) : super(key: key);

  @override
  State<Consultas> createState() => _ConsultasState();
}

List Revisor = ["Selecciona el nombre del revisor"];
String _Revisor = Revisor.first;

List Docente = ["Selecciona el nombre del docente"];
String _Docente = Docente.first;

class _ConsultasState extends State<Consultas> {
  TextEditingController fecha = TextEditingController(text: "");
  DateTime date = DateTime.now();
  String mes = "";
  double tam1 = 0;
  double tam2 = 0;
  double tam3 = 0;

  void _fecha(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025)).then((value){
      setState(() {
        date = value!;
        if(date.month.toString() == "1"){mes = "Enero";}
        else if(date.month.toString() == "2"){mes = "Febrero";}
        else if(date.month.toString() == "3"){mes = "Marzo";}
        else if(date.month.toString() == "4"){mes = "Abril";}
        else if(date.month.toString() == "5"){mes = "Mayo";}
        else if(date.month.toString() == "6"){mes = "Junio";}
        else if(date.month.toString() == "7"){mes = "Julio";}
        else if(date.month.toString() == "8"){mes = "Agosto";}
        else if(date.month.toString() == "9"){mes = "Septiembre";}
        else if(date.month.toString() == "10"){mes = "Octubre";}
        else if(date.month.toString() == "11"){mes = "Noviembre";}
        else if(date.month.toString() == "12"){mes = "Diciembre";}

        fecha.text = " ${date.day.toString()} / ${mes} / ${date.year.toString()}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Consultas")
          ,centerTitle: true,
          backgroundColor: Colors.purple),

      body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            //----------------------------CONSULTA 1----------------------------
            Text("(1) Consultar las asistencia de un docente",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center
            ),
            SizedBox(height: 20),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: obtenerDocentes(),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  Docente.clear();
                  Docente.add("Selecciona el nombre del docente");
                  return Container(
                    height: 0,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Docente.add(snapshot.data![index]['docente'].toString());
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
                setState(() {
                  Docente;
                  _Docente = value.toString();
                  tam1 = 100;
                });
              }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.purple),
              decoration: InputDecoration(labelText: "Selecciona al docente",
                  prefixIcon: Image.asset('assets/maestro.png', width: 10, height: 10, scale: 15),
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: obtenerAsistenciaDocente(_Docente),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: tam1,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('\n Revisor: ${snapshot.data![index]['revisor']} '
                            '\n Fecha: ${snapshot.data![index]['fecha']} ',
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  );
                }else {return Text("");
                }
              },
            ),
            SizedBox(height: 20),

            //----------------------------CONSULTA 2----------------------------
            Text("(2) Consultar las asistencia de un revisor",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center
            ),
            SizedBox(height: 20),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: obtenerRevisores(),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  Revisor.clear();
                  Revisor.add("Selecciona el nombre del revisor");
                  return Container(
                    height: 0,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Revisor.add(snapshot.data![index]['revisor'].toString());
                        return Text(snapshot.data![index]['reviosr'].toString());
                      },
                    ),
                  );
                }else {return Text("");}
              },
            ),

            DropdownButtonFormField(
              value: _Revisor,
              items: Revisor.map((value){
                return DropdownMenuItem(
                    child: Text(value), value: value);
              }).toList(),
              onChanged: (value){
                setState(() {
                  Revisor;
                  _Revisor = value.toString();
                  tam2 = 100;
                });
              }, icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.purple),
              decoration: InputDecoration(labelText: "Selecciona al revisor",
                  prefixIcon: Image.asset('assets/revisor.png', width: 10, height: 10, scale: 15),
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: obtenerAsistenciaRevisor(_Revisor),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: tam2,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('\n Docente: ${snapshot.data![index]['docente']} '
                            '\n Fecha: ${snapshot.data![index]['fecha']} ',
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  );
                }else {return Text("");
                }
              },
            ),
            SizedBox(height: 20),
          ]
      ),
    );
  }
}