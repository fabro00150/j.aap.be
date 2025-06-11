import 'package:flutter/material.dart';
import 'package:jappbe/repositories/evento_repository.dart';
import 'package:jappbe/models/evento_model.dart';
import 'package:intl/intl.dart';

class ListEventoScreen extends StatefulWidget {
  const ListEventoScreen({Key? key});

  @override
  _ListEventoScreenState createState() => _ListEventoScreenState();
}

class _ListEventoScreenState extends State<ListEventoScreen> {
  late Future<List<Evento>> _listEventos;

  @override
  void initState() {
    super.initState();
    _loadEventos();
  }

  void _loadEventos() async {
    _listEventos = EventoRepository.select();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Eventos')),
      body: FutureBuilder<List<Evento>>(
        future: _listEventos,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error.toString()}"));
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("No hay eventos"));
          } else {
            final eventos = snapshot.data!;
            return ListView.builder(
              itemCount: eventos.length,
              itemBuilder: (context, index) {
                final evento = eventos[index];
                return ListTile(
                  title: Text(
                    '${DateFormat('MMM dd, HH:mm').format(evento.fecha)} | ${evento.nombre}',
                  ),
                  subtitle: Text(evento.descripcion),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // botón editar
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/evento/form',
                            arguments: evento,
                          ).then(
                            (_) => setState(() {
                              _loadEventos();
                            }),
                          );
                        },
                      ),
                      SizedBox(height: 25),
                      // botón eliminar
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => eliminar(evento),
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
        // FloatingActionButton
        backgroundColor: Colors.blue, // color
        onPressed: () {
          // onPressed FAB
          Navigator.pushNamed(context, '/evento/form').then(
            (_) => setState(() {
              _loadEventos();
            }),
          );
        }, // fin onPressed FAB
        shape: const CircleBorder(), // forma
        child: const Icon(Icons.add, color: Colors.white), // icono
      ), // fin FloatingActionButton
    );
  }

  Future<void> eliminar(Evento evento) async {
    final respuesta = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Evento'),
          content: const Text('¿Estás seguro de eliminar este evento?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
    if (respuesta == true) {
      await EventoRepository.delete(evento);
    }
    setState(() {
      _loadEventos();
    });
  }
}
