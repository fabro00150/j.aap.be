import 'package:flutter/material.dart';
import 'package:jappbe/repositories/usuario_repository.dart';
import 'package:jappbe/models/usuario_model.dart';

class ListLecturaScreen extends StatefulWidget {
  const ListLecturaScreen({Key? key}) : super(key: key);

  @override
  _ListLecturaScreenState createState() => _ListLecturaScreenState();
}

class _ListLecturaScreenState extends State<ListLecturaScreen> {
  late Future<List<Usuario>> _usuarios;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }

  void _loadUsuarios() {
    _usuarios = UsuarioRepository.select();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Usuarios")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar por DNI o Apellidos y Nombres',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _search = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Usuario>>(
              future: _usuarios,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final usuarios = snapshot.data ?? [];
                if (usuarios.isEmpty) {
                  return const Center(child: Text('No hay usuarios'));
                }

                final usuariosFiltrados = usuarios.where((usuario) {
                  return usuario.nombres.toLowerCase().contains(_search) ||
                      usuario.apellidoPaterno.toLowerCase().contains(_search) ||
                      usuario.apellidoMaterno.toLowerCase().contains(_search) ||
                      usuario.dniCedula.toLowerCase().contains(_search);
                }).toList();

                if (usuariosFiltrados.isEmpty) {
                  return const Center(child: Text('No hay usuarios'));
                }

                return ListView.builder(
                  itemCount: usuariosFiltrados.length,
                  itemBuilder: (context, index) {
                    final usuario = usuariosFiltrados[index];
                    return ListTile(
                      title: Text(
                        '${usuario.nombres} ${usuario.apellidoPaterno} ${usuario.apellidoMaterno}',
                      ),
                      subtitle: Text(
                        'Sector: ${usuario.sectorId ?? "-"}  |  Consumo anterior: "-"',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          // Sin funcionalidad por ahora
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
