import 'package:flutter/material.dart';
import 'package:jappbe/models/sector_model.dart';
import 'package:jappbe/repositories/sector_repository.dart';

class FormSectorScreen extends StatefulWidget {
  const FormSectorScreen({Key? key});

  @override
  _FormSectorScreenState createState() => _FormSectorScreenState();
}

class _FormSectorScreenState extends State<FormSectorScreen> {
  // CONTROLLERS
  // para el formulario
  final formKey = GlobalKey<FormState>();
  // para los campos
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  // para el sector

  Sector? s;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Sector) {
      // si el argumento es un sector, asignar a s
      s = args;
      // si el sector no es nulo, asignar los valores a los campos
      if (s != null) {
        nombreController.text = s!.nombre;
        descripcionController.text = s!.descripcion;
        estadoController.text = s!.estado;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(s != null ? 'Editar Sector ${s!.nombre}' : 'Nuevo Sector'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: estadoController,
                decoration: InputDecoration(
                  labelText: 'Estado',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un estado';
                  }
                  return null;
                },
              ),

              SizedBox(height: 25),
              ElevatedButton(
                onPressed: saveSector,
                child: Text(s != null ? 'Actualizar' : 'Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveSector() async {
    // validar las cajas de texto del formulario
    if (formKey.currentState!.validate()) {
      // si no hay problema, crear el sector
      final sector = Sector(
        id: s?.id,  // si s es nulo, se crea un nuevo sector
        nombre: nombreController.text,
        descripcion: descripcionController.text,
        estado: estadoController.text,
      );
      if (sector.id != null) {
        // si s no es nulo, actualizar el sector
        await SectorRepository.update(sector);
      } else {
        // si s es nulo, insertar el sector
        await SectorRepository.insert(sector);
      }
      Navigator.pop(context);
    }
  }
}
