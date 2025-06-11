import 'package:flutter/material.dart';
import 'package:jappbe/models/usuario_model.dart';
import 'package:jappbe/repositories/usuario_repository.dart';
import 'package:jappbe/repositories/asistencia_repository.dart';
import 'package:jappbe/models/asistencia_model.dart';

class AddAsistenciaScreen extends StatefulWidget {
  @override
  _AddAsistenciaScreenState createState() => _AddAsistenciaScreenState();
}

class _AddAsistenciaScreenState extends State<AddAsistenciaScreen> {
  late Future<List<Usuario>> _usuariosFuture;
  final Set<int> _asistentes = {};
  late int eventoId;

  @override
  void initState() {
    super.initState();
    _usuariosFuture = Future.value([]); // Inicialización temporal
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is int) {
      setState(() {
        eventoId = args;
        _loadUsuariosParaEvento(eventoId);
      });
    }
  }

  void _loadUsuariosParaEvento(int eventoId) async {
    final usuarios = await UsuarioRepository.selectUsuariosPorEvento(eventoId);
    final asistencias = await AsistenciaRepository.selectByEvento(eventoId);

    setState(() {
      _usuariosFuture = Future.value(usuarios);
      _asistentes.clear();

      // Agregar automáticamente los usuarios que ya tienen asistio = "true"
      for (var asistencia in asistencias) {
        if (asistencia.asistio == "true") {
          _asistentes.add(asistencia.usuarioId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Asistencia')),
      body: FutureBuilder<List<Usuario>>(
        future: _usuariosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar usuarios: ${snapshot.error}'),
            );
          }
          final usuarios = snapshot.data ?? [];
          if (usuarios.isEmpty) {
            return const Center(
              child: Text('No hay usuarios para este evento.'),
            );
          }
          return ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              final usuario = usuarios[index];
              return CheckboxListTile(
                title: Text(usuario.nombres),
                value: _asistentes.contains(
                  usuario.id,
                ), // ✅ Se activará si el usuario ya asistió
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      if (usuario.id != null) {
                        _asistentes.add(usuario.id!);
                      }
                    } else {
                      _asistentes.remove(usuario.id);
                    }
                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          if (_asistentes.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Debe seleccionar al menos un usuario'),
              ),
            );
            return;
          }

          for (var usuarioId in _asistentes) {
            final asistencia = Asistencia(
              fechaHora: DateTime.now(),
              asistio: "true",
              eventoId: eventoId,
              usuarioId: usuarioId,
            );
            await AsistenciaRepository.insert(asistencia);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Asistencia guardada correctamente')),
          );
          Navigator.pop(context);
        },
      ),
    );
  }
}
