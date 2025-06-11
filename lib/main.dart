import 'package:flutter/material.dart';
// importacion de sectores
import 'screens/sector/list_sector_screen.dart';
import 'screens/sector/form_sector_screen.dart';
// importacion de usuarios
import 'screens/usuario/list_usuario_screen.dart';
import 'screens/usuario/form_usuario_screen.dart';
// importacion de medidores
import 'screens/medidores/list_medidor_screen.dart';
import 'screens/medidores/form_medidor_screen.dart';
// importacion de menu
import 'screens/menu_screen.dart';
// importacion de lecturas
import 'screens/lecturas/list_lectura_screen.dart';
// importacion de eventos
import 'screens/evento/list_evento_screen.dart';
import 'screens/evento/form_evento_screen.dart';
// importacion de asistencias
import 'screens/asistencias/list_asistencias_screen.dart';
import 'screens/asistencias/add_asistencia_screen.dart';
// importacion de pagos
import 'screens/pagos/list_pagos_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "J.AAP.B.E",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MenuScreen(),
        // rutas de sectores
        '/sector/list': (context) => ListSectorScreen(),
        '/sector/form': (context) => FormSectorScreen(),
        // rutas de usuarios
        '/usuario/list': (context) => ListUsuarioScreen(),
        '/usuario/form': (context) => FormUsuarioScreen(),
        // rutas de medidores
        '/medidor/list': (context) => ListMedidorScreen(),
        '/medidor/form': (context) => FormMedidorScreen(),
        // rutas de lecturas
        '/lectura/list': (context) => ListLecturaScreen(),
        // rutas de eventos
        '/evento/list': (context) => ListEventoScreen(),
        '/evento/form': (context) => FormEventoScreen(),
        // rutas de asistencias
        '/asistencia/list': (context) => ListAsistenciaScreen(),
        '/asistencia/form': (context) => AddAsistenciaScreen(),
        // rutas de pagos
        '/pago/list': (context) => ListPagosScreen(),
      },
    );
  }
}
