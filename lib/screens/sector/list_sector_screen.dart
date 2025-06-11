import 'package:flutter/material.dart';
import 'package:jappbe/models/sector_model.dart';
import 'package:jappbe/repositories/sector_repository.dart';

class ListSectorScreen extends StatefulWidget {
  const ListSectorScreen({Key? key}) : super(key: key);

  @override
  State<ListSectorScreen> createState() => _ListSectorScreenState();
}

class _ListSectorScreenState extends State<ListSectorScreen> {
  late Future<List<Sector>> _sectoresFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSectores();
  }

  void _loadSectores() {
    setState(() {
      _sectoresFuture = SectorRepository.getSectores();
    });
  }

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    await SectorRepository.getSectores();
    setState(() => _isLoading = false);
    _loadSectores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Sectores'),
        actions: [
          IconButton(
            icon: Icon(_isLoading ? Icons.refresh : Icons.sync),
            onPressed: _isLoading ? null : _refreshData,
          ),
        ],
      ),
      body: FutureBuilder<List<Sector>>(
        future: _sectoresFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay sectores disponibles'));
          }

          final sectores = snapshot.data!;
          return ListView.builder(
            itemCount: sectores.length,
            itemBuilder: (context, index) {
              final sector = sectores[index];
              return ListTile(
                title: Text(sector.nombre),
                subtitle: Text(sector.descripcion),
                trailing: Icon(
                  sector.estado == 'true' ? Icons.check_circle : Icons.cancel,
                  color: sector.estado == 'true' ? Colors.green : Colors.red,
                ),
                onTap: () => _navigateToForm(),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add),
      ),
    );
  }

  /*
  void _navigateToDetail(Sector sector) {
    Navigator.pushNamed(context, '/sector/detail', arguments: sector);
  }
*/
  void _navigateToForm() {
    Navigator.pushNamed(context, '/sector/form').then((_) => _loadSectores());
  }
}
