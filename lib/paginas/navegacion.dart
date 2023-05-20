import 'package:dam_u4_proyecto2_19400618/paginas/asignacion.dart';
import 'package:dam_u4_proyecto2_19400618/paginas/asistencia.dart';
import 'package:dam_u4_proyecto2_19400618/paginas/consultas.dart';
import 'package:flutter/material.dart';

class Navegacion extends StatefulWidget {
  const Navegacion({Key? key}) : super(key: key);

  @override
  State<Navegacion> createState() => _NavegacionState();
}

class _NavegacionState extends State<Navegacion> {
  int _indice = 0;
  double icono1 = 9;
  double icono2 = 13;
  double icono3 = 13;

  void _cambiarIndice(int indice){
    if(indice == 0){icono1 = 9; icono2 = 13; icono3 = 13;}
    else if(indice == 1){ icono2 = 9; icono1 = 13; icono3 = 13;}
    else if(indice == 2){icono3 = 9; icono2 = 13; icono1 = 13;}

    setState(() {
      _indice = indice;
      icono1;
      icono2;
      icono3;
    });
  }

  final List<Widget> _pagina = [
    Asignacion(),
    Asistencia(),
    Consultas(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagina[_indice],
      bottomNavigationBar: BottomNavigationBar(
        items: [ //scale: 13
          BottomNavigationBarItem(icon: Image.asset("assets/maestro.png", scale: icono1), label: "Asignacion"),
          BottomNavigationBarItem(icon: Image.asset("assets/asistencia.png", scale: icono2), label: "Asistencia"),
          BottomNavigationBarItem(icon: Image.asset("assets/consulta.png", scale: icono3), label: "Consultar")
        ],
        currentIndex: _indice,
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: _cambiarIndice,
      ),
    );
  }

}