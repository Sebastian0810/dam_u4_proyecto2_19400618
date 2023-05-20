import 'package:dam_u4_proyecto2_19400618/servicios/servicios.dart';
import 'package:flutter/material.dart';

class Asignacion extends StatefulWidget {
  const Asignacion({Key? key}) : super(key: key);

  @override
  State<Asignacion> createState() => _AsignacionState();
}

class _AsignacionState extends State<Asignacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Asignacion"), centerTitle: true, backgroundColor: Colors.purple),

      body: FutureBuilder(
          future: obtenerAsignacion(),
          builder: ((context, snapshot){
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      background: Container(child: const Icon(Icons.delete)),
                      key: Key(snapshot.data?[index]['id']),
                      onDismissed: (direction) async{
                        await borrarAsignacion(snapshot.data?[index]['id']);
                        snapshot.data?.removeAt(index);
                      },
                      direction: DismissDirection.startToEnd,
                      confirmDismiss: (direction) async{
                        bool resultado = false;
                        resultado = await showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text("Estas seguro que quieres eliminar a ${snapshot.data?[index]['docente']}"),
                            actions: [
                              TextButton(onPressed: (){ return Navigator.pop(context, false);},
                                  child: const Text("No", style: TextStyle(color: Colors.red))),
                              TextButton(onPressed: (){ return Navigator.pop(context, true);},
                                  child: const Text("Si"))
                            ],
                          );
                        });
                        return resultado;
                      },
                      child: ListTile(
                        title: Text(snapshot.data?[index]['docente']),
                        leading: Text(snapshot.data?[index]['horario'],),
                        trailing: Text(snapshot.data?[index]['salon']),
                        subtitle: Text(snapshot.data?[index]['materia']),
                        onTap: () async{
                          await Navigator.pushNamed(context, '/actualizarAsignacion', arguments: {
                            "salon": snapshot.data?[index]['salon'],
                            "edificio": snapshot.data?[index]['edificio'],
                            "horario": snapshot.data?[index]['horario'],
                            "docente": snapshot.data?[index]['docente'],
                            "materia": snapshot.data?[index]['materia'],
                            "id": snapshot.data?[index]['id']
                          });
                          setState(() {});
                        },
                      ),
                    );
                  }
              );
            } else { return const Center(child: CircularProgressIndicator());}
          })),

      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () async{
            await Navigator.pushNamed(context, '/agregarAsignacion');
            setState(() {});
          }, child: const Icon(Icons.add)
      ),
    );
  }
}