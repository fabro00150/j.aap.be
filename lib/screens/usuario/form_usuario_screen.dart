import 'package:flutter/material.dart';
import 'package:jappbe/models/sector_model.dart';
import 'package:jappbe/models/usuario_model.dart';
import 'package:jappbe/repositories/sector_repository.dart' show SectorRepository;
import 'package:jappbe/repositories/usuario_repository.dart';

class FormUsuarioScreen extends StatefulWidget {
  const FormUsuarioScreen({Key? key});

  @override
  _FormUsuarioScreenState createState() => _FormUsuarioScreenState();
}

class _FormUsuarioScreenState extends State<FormUsuarioScreen> {
  // CONTROLLERS
  // para el formulario
  final formKey = GlobalKey<FormState>();
  // para los campos
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoPaternoController = TextEditingController();
  final TextEditingController apellidoMaternoController = TextEditingController();
  final TextEditingController nombresController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController dniCedulaController = TextEditingController();
  final TextEditingController sectorIdController = TextEditingController();
  // para el sector

  Usuario? u;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Usuario) {
      // si el argumento es un sector, asignar a s
      u = args;
      // si el sector no es nulo, asignar los valores a los campos
      if (u != null) {
        nombreController.text = u!.nombres;
        apellidoPaternoController.text = u!.apellidoPaterno;
        apellidoMaternoController.text = u!.apellidoMaterno;
        nombresController.text = u!.nombres;
        telefonoController.text = u!.telefono ?? '';
        dniCedulaController.text = u!.dniCedula;
        sectorIdController.text = u!.sectorId.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(u != null ? 'Editar Usuario ${u!.nombres}' : 'Nuevo Usuario'),
      ),
      body:
        Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: dniCedulaController,
                    decoration: InputDecoration(
                      labelText: 'DNI/Cédula',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu DNI/Cédula';
                      }
                      return null;
                    },
                ),
                SizedBox(height: 25),
                TextFormField(
                    controller: nombreController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingres sus nombres';
                      }
                      return null;
                    },
                ),
                SizedBox(height: 25),
                    
                TextFormField(
                    controller: apellidoPaternoController,
                    decoration: InputDecoration(
                      labelText: 'Apellido Paterno',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa su apellido paterno';
                      }
                      return null;
                    },
                ),
                SizedBox(height: 25),
                TextFormField(
                    controller: apellidoMaternoController,
                    decoration: InputDecoration(
                      labelText: 'Apellido Materno',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa su apellido materno';
                      }
                      return null;
                    },
                ),
                SizedBox(height: 25),
                TextFormField(
                    controller: telefonoController,
                    decoration: InputDecoration(
                      labelText: 'Teléfono',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu teléfono';
                      }
                      return null;
                    },
                ),
                SizedBox(height: 25),
                FutureBuilder<List<Sector>>(
                  future: SectorRepository.select(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    final sectores = snapshot.data!;
                    return DropdownButtonFormField<int>(
                      value: sectorIdController.text.isNotEmpty
                          ? int.parse(sectorIdController.text)
                          : null,
                      items: sectores
                          .map((sector) => DropdownMenuItem<int>(
                                value: sector.id,
                                child: Text(sector.nombre),
                              ))
                          .toList(),
                      onChanged: (value) {
                        sectorIdController.text = value.toString();
                      },
                      decoration: InputDecoration(
                        labelText: 'Sector',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Por favor, ingresa el sector';
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: saveUsuario,
                  child: Text(u != null ? 'Actualizar' : 'Guardar'),
                ),
              ],
            ),
          ),
        )
    );
  }

  void saveUsuario() async {
    // validar las cajas de texto del formulario
    if (formKey.currentState!.validate()) {
      // si no hay problema, crear el usuario
      final usuario = Usuario(
        id: u?.id,  // si s es nulo, se crea un nuevo usuario
        nombres: nombreController.text,
        apellidoPaterno: apellidoPaternoController.text,
        apellidoMaterno: apellidoMaternoController.text,        
        telefono: telefonoController.text,
        dniCedula: dniCedulaController.text,
        sectorId: int.parse(sectorIdController.text),
      );
      if (usuario.id != null) {
        // si u no es nulo, actualizar el usuario
        await UsuarioRepository.update(usuario);

      } else {
        // si u es nulo, insertar el usuario
        await UsuarioRepository.insert(usuario);
      }
      Navigator.pop(context);
    }
  }
}