import 'package:flutter/material.dart';
import 'package:jappbe/repositories/medidor_repository.dart';
import 'package:jappbe/models/medidor_model.dart';

class ListMedidorScreen extends StatefulWidget {
  const ListMedidorScreen({Key? key});

  @override
  _ListMedidorScreenState createState() => _ListMedidorScreenState();
}

class _ListMedidorScreenState extends State<ListMedidorScreen> {
  // declaración _listMedidores
  late Future<List<Medidor>> _listMedidores;

  @override
  void initState() {
    super.initState();
    _loadMedidores();
  }

  void _loadMedidores() async {
    _listMedidores = MedidorRepository.select();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Medidores")),
      body: FutureBuilder<List<Medidor>>(
        future: _listMedidores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // validar si hay errores
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // consulta ok pero sin datos
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos'));
          }
          // consulta ok y con datos
          else {
            final medidores = snapshot.data!;
            return ListView.builder(
              itemCount: medidores.length,
              itemBuilder: (context, index) {
                final medidor = medidores[index];
                // obtener el usuario asociado al medidor
                return ListTile(
                  title: Text(
                    "${medidor.usuarioId}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    "${medidor.numeroSerie}${medidor.fechaInstalacion}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        // botón editar
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/medidor/form',
                            arguments: medidor,
                          ).then((value) {
                            _loadMedidores();
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        // botón eliminar
                        onPressed: () => eliminar(medidor),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/medidor/form').then((value) {
            _loadMedidores();
          });
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> eliminar(Medidor medidor) async {
    final respuesta = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Eliminar Medidor"),
          content: Text("¿Estás seguro de eliminar este medidor?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Eliminar"),
            ),
          ],
        );
      },
    );
    if (respuesta == true) {
      setState(() {
        _loadMedidores();
      });
    }
  }
}
