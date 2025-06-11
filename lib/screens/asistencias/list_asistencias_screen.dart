import 'package:flutter/material.dart';
import 'package:jappbe/repositories/evento_repository.dart';
import 'package:jappbe/models/evento_model.dart';
import 'package:intl/intl.dart';


class ListAsistenciaScreen extends StatefulWidget {
  const ListAsistenciaScreen({Key? key});

  @override
  _ListEventoScreenState createState() => _ListEventoScreenState();
}

class _ListEventoScreenState extends State<ListAsistenciaScreen> {
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
                      IconButton(
                        icon: const Icon(Icons.list, color: Colors.blue),
                        onPressed: () {
                          if (evento.id == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error: No se recibió el ID del evento')),
                            );
                            Navigator.pop(context);
                            return;
                          }else{
                          Navigator.pushNamed(
                            context,
                            '/asistencia/form',
                            arguments: evento.id,
                          );
                          }
                        },
                      ),

                      SizedBox(height: 25),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
