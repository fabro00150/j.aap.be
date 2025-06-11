import 'package:flutter/material.dart';
import 'package:jappbe/models/pagos_model.dart';
import 'package:jappbe/repositories/pagos_respository.dart';


class ListPagosScreen extends StatefulWidget {
  @override
  _ListPagosScreenState createState() => _ListPagosScreenState();
}

class _ListPagosScreenState extends State<ListPagosScreen> {
  late Future<List<Pagos>> _listPagos;

  @override
  void initState() {
    super.initState();
    // Replace '1' with the appropriate lecturaId or obtain it dynamically
    _loadPagos(1);
  }

  void _loadPagos(int lecturaId) {
    _listPagos = PagosRepository.select(lecturaId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Pagos')),
      body: FutureBuilder<List<Pagos>>(
        future: _listPagos,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error.toString()}"));
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("No hay pagos"));
          } else {
            final pagos = snapshot.data!;
            return ListView.builder(
              itemCount: pagos.length,
              itemBuilder: (context, index) {
                final pago = pagos[index];
                return ListTile(
                  title: Text('${pago.descripcion} - Usuario: ${pago.usuarioId}'),
                  subtitle: Text('Monto: ${pago.monto}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // botón editar
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/edit_pago',
                            arguments: pago,
                          ).then((_) => _loadPagos(1));
                        },
                      ),
                      // botón eliminar
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await PagosRepository.delete(pago);
                          _loadPagos(1);
                        },
                      ),
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