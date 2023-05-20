import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//--------------------------------Asignacion--------------------------------------

//Obtener registros de la base de datos Asignacion
Future <List> obtenerAsignacion()async{
  List asignacion = [];
  QuerySnapshot consulta = await db.collection('Asignacion').get();
  for(var doc in consulta.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asignaciones ={
      "salon": data['salon'],
      "edificio": data['edificio'],
      "horario": data['horario'],
      "docente": data['docente'],
      "materia": data['materia'],
      "id": doc.id,
    };
    asignacion.add(asignaciones);
  }
  return asignacion;
}

//Guardar en la base de datos Asignacion
Future<void> agregarAsignacion(String salon, String edificio, String horario, String docente, String materia)
async{
  await db.collection("Asignacion").add({"salon": salon,
    "edificio": edificio,
    "horario": horario,
    "docente": docente,
    "materia": materia});
}

//Actualizar en la base de datos Asignacion
Future<void> actualizarAsignacion(String salon, String edificio, String horario, String docente, String materia,
    String id) async{
  await db.collection("Asignacion").doc(id).set({"salon": salon,
    "edificio": edificio,
    "horario": horario,
    "docente": docente,
    "materia": materia});
}

//Borrar en la base de datos Asignacion
Future <void> borrarAsignacion(String id) async{
  await db.collection("Asignacion").doc(id).delete();
}

//--------------------------------Asistencia--------------------------------------
//Obtener registros de la base de datos Asistencia
Future <List> obtenerAsistencia()async{
  List asistencia = [];
  QuerySnapshot consulta = await db.collection('Asistencia').get();
  for(var doc in consulta.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asistencias ={
      "docente":data['docente'],
      "fecha":data['fecha'],
      "revisor":data['revisor'],
      "id": doc.id,
    };
    asistencia.add(asistencias);
  }
  return asistencia;
}

//Guardar en la base de datos Asistencia
Future<void> agregarAsistencia(String docente, String fecha, String revisor) async{
  await db.collection("Asistencia").add({"docente":docente, "fecha":fecha, "revisor":revisor});
}

//---------------------------------Consultas------------------------------------
Future<List<Map<String, dynamic>>> obtenerDocentes() async {
  List<Map<String, dynamic>> docentes = [];
  QuerySnapshot querySnapshot = await db.collection("Asignacion").get();
  for (var docSnapshot in querySnapshot.docs) {

    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    docentes.add(
        {
          'docente': data['docente']
        });
  }
  return docentes;
}

Future<List<Map<String, dynamic>>> obtenerRevisores() async {
  List<Map<String, dynamic>> revisores = [];
  QuerySnapshot querySnapshot = await db.collection("Asistencia").get();
  for (var docSnapshot in querySnapshot.docs) {

    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    revisores.add(
        {
          'revisor': data['revisor']
        });
  }
  return revisores;
}

Future<List<Map<String, dynamic>>> obtenerAsistenciaDocente(String d) async {
  List<Map<String, dynamic>> asistencia = [];
  QuerySnapshot querySnapshot = await db.collection("Asistencia").where("docente", isEqualTo: d).get();
  for (var docSnapshot in querySnapshot.docs) {

    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    asistencia.add(
        {
          "revisor":data['revisor'],
          "fecha":data['fecha'],
        });
  }
  return asistencia;
}

Future<List<Map<String, dynamic>>> obtenerAsistenciaRevisor(String d) async {
  List<Map<String, dynamic>> asistencia = [];
  QuerySnapshot querySnapshot = await db.collection("Asistencia").where("revisor", isEqualTo: d).get();
  for (var docSnapshot in querySnapshot.docs) {

    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    asistencia.add(
        {
          "docente":data['docente'],
          "fecha":data['fecha'],
        });
  }
  return asistencia;
}