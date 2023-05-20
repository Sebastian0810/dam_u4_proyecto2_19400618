import 'package:dam_u4_proyecto2_19400618/paginas/actualizarAsignacion.dart';
import 'package:dam_u4_proyecto2_19400618/paginas/agregarAsignacion.dart';
import 'package:dam_u4_proyecto2_19400618/paginas/agregarAsistencia.dart';
import 'package:dam_u4_proyecto2_19400618/paginas/asignacion.dart';
import 'package:dam_u4_proyecto2_19400618/paginas/asistencia.dart';
import 'package:dam_u4_proyecto2_19400618/paginas/navegacion.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Proyecto 2 - DAM',
        theme: ThemeData(brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Navegacion(),
          '/Asignacion': (context) => const Asignacion(),
          '/agregarAsignacion':(context) => const AgregarAsignacion(),
          '/actualizarAsignacion':(context) => const ActualizarAsignacion(),
          '/Asistencia': (context) => const Asistencia(),
          '/agregarAsistencia':(context) => const AgregarAsistencia(),
        }
    );
  }
}