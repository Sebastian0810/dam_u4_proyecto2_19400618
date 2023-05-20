import 'package:dam_u4_proyecto2_19400618/servicios/servicios.dart';
import 'package:flutter/material.dart';

class Asistencia extends StatefulWidget {
  const Asistencia({Key? key}) : super(key: key);

  @override
  State<Asistencia> createState() => _AsistenciaState();
}

class _AsistenciaState extends State<Asistencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Asistencia"), centerTitle: true, backgroundColor: Colors.purple),

      body: FutureBuilder(
          future: obtenerAsistencia(),
          builder: ((context, snapshot){
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: Text("Revisor:\n${snapshot.data?[index]['revisor']}", textAlign: TextAlign.center,),
                      subtitle: Text("Fecha de asistencia: ${snapshot.data?[index]['fecha']}"),
                      title: Text("Docente: ${snapshot.data?[index]['docente']}"),
                    );
                  }
              );
            } else { return const Center(child: CircularProgressIndicator());}
          }
          )
      ),

      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () async{
            await Navigator.pushNamed(context, '/agregarAsistencia');
            setState(() {});
          }, child: const Icon(Icons.add)
      ),
    );
  }
}