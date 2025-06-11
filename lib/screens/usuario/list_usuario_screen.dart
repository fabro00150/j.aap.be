import 'package:flutter/material.dart';
import 'package:jappbe/models/usuario_model.dart';
import 'package:jappbe/services/api_service.dart';

class ListUsuarioScreen extends StatefulWidget {
  // ListUsuarioScreen
  const ListUsuarioScreen({Key? key}); // constructor ListUsuarioScreen

  @override
  _ListUsuarioScreenState createState() => _ListUsuarioScreenState(); // createState ListUsuarioScreen
} // fin ListUsuarioScreen

class _ListUsuarioScreenState extends State<ListUsuarioScreen> {
  // _ListUsuarioScreenState
  late Future<List<Usuario>> _listUsuarios; // declaración _listUsuarios

  @override
  void initState() {
    // initState
    super.initState(); // super initState
    _loadUsuarios(); // cargar usuarios
  } // fin initState

  void _loadUsuarios() {
    setState(() {
      _listUsuarios = ApiService.getUsuarios().then(
        // obtener usuarios
        (usuarios) {
          // si hay usuarios
          if (usuarios.isEmpty) {
            return List.empty(); // retornar lista vacía
          } else {
            return usuarios.map((json) => Usuario.fromJson(json)).toList(); // retornar lista de usuarios
          } // fin si hay usuarios
        }, // fin then
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // build
    return Scaffold(
      // Scaffold
      appBar: AppBar(title: Text("Lista de Usuarios")), // AppBar
      body: FutureBuilder<List<Usuario>>(
        // FutureBuilder
        future: _listUsuarios, // future
        builder: (context, snapshot) {
          // builder
          if (snapshot.connectionState == ConnectionState.waiting) {
            // esperando datos
            return Center(
              child: CircularProgressIndicator(),
            ); // indicador de carga
          } // fin esperando datos
          if (snapshot.hasError) {
            // error
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            ); // mostrar error
          } // fin error
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            // sin datos
            return Center(child: Text("No hay datos")); // mostrar sin datos
          } // fin sin datos
          else {
            // mostrar datos
            final usuarios = snapshot.data!; // obtener usuarios
            return ListView.builder(
              // ListView.builder
              itemCount: usuarios.length, // cantidad de usuarios
              itemBuilder: (context, index) {
                // itemBuilder
                final usuario = usuarios[index]; // usuario actual
                return ListTile(
                  // ListTile
                  title: Text(
                    "${usuario.nombres} ${usuario.apellidoPaterno}|${usuario.apellidoMaterno}",
                  ), // nombre usuario
                  subtitle: Text(
                    "DNI: ${usuario.dniCedula}| Sector: ${usuario.sectorId}",
                  ), // info usuario
                  trailing: Row(
                    // acciones
                    mainAxisSize: MainAxisSize.min, // tamaño mínimo
                    children: [
                      // botones
                      IconButton(
                        // botón editar
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ), // icono editar
                        onPressed: () {
                          // onPressed editar
                          Navigator.pushNamed(
                            // navegar a formulario
                            context,
                            '/usuario/form',
                            arguments: usuario,
                          ).then(
                            (_) => setState(() {
                              _loadUsuarios();
                            }),
                          );
                        }, // fin onPressed editar
                      ), // fin botón editar
                      IconButton(
                        // botón eliminar
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ), // icono eliminar
                        onPressed: () => eliminar(usuario), // eliminar usuario
                      ), // fin botón eliminar
                    ], // fin botones
                  ), // fin acciones
                ); // fin ListTile
              }, // fin itemBuilder
            ); // fin ListView.builder
          } // fin mostrar datos
        }, // fin builder
      ), // fin FutureBuilder
      floatingActionButton: FloatingActionButton(
        // FloatingActionButton
        backgroundColor: Colors.blue, // color
        onPressed: () {
          // onPressed FAB
          Navigator.pushNamed(context, '/usuario/form').then(
            (_) => setState(() {
              _loadUsuarios();
            }),
          );
        }, // fin onPressed FAB
        shape: const CircleBorder(), // forma
        child: const Icon(Icons.add, color: Colors.white), // icono
      ), // fin FloatingActionButton
    ); // fin Scaffold
  } // fin build

  Future<void> eliminar(Usuario usuario) async {
    // eliminar
    final respuesta = await showDialog<bool>(
      // showDialog
      context: context, // contexto
      builder: (context) {
        // builder dialog
        return AlertDialog(
          // AlertDialog
          title: Text("Eliminar Usuario"), // título
          content: Text("¿Estás seguro de eliminar este usuario?"), // contenido
          actions: [
            // acciones
            TextButton(
              // botón cancelar
              onPressed: () => Navigator.pop(context, false), // cancelar
              child: Text("Cancelar"), // texto
            ), // fin botón cancelar
            TextButton(
              // botón eliminar
              onPressed: () => Navigator.pop(context, true), // eliminar
              child: Text("Eliminar"), // texto
            ), // fin botón eliminar
          ], // fin acciones
        ); // fin AlertDialog
      }, // fin builder dialog
    ); // fin showDialog
    if (respuesta == true) {
      // si confirma eliminar
      await ApiService.deleteUsuario(usuario.id!); // eliminar usuario
      setState(() {
        _loadUsuarios();
      });
    } // fin si confirma eliminar
  } // fin eliminar
} // fin _ListUsuarioScreenState
