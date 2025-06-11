import 'package:flutter/material.dart';
import 'package:jappbe/models/evento_model.dart';
import 'package:jappbe/repositories/evento_repository.dart';

class FormEventoScreen extends StatefulWidget {
  const FormEventoScreen({Key? key});

  @override
  _FormEventoScreenState createState() => _FormEventoScreenState();
}

class _FormEventoScreenState extends State<FormEventoScreen> {
  // CONTROLLERS
  // para el formulario
  final formKey = GlobalKey<FormState>();
  // para los campos
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController lugarController = TextEditingController();

  Evento? e;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Evento) {
      // si el argumento es un sector, asignar a s
      e = args;
      if (e != null) {
        nombreController.text = e!.nombre;
        descripcionController.text = e!.descripcion;
        fechaController.text = e!.fecha.toIso8601String();
        lugarController.text = e!.lugar;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(e != null ? 'Editar Evento ${e!.nombre}' : 'Nuevo Evento'),
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
                  labelText: 'Nombre Evento',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre';
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
                    return 'Por favor, ingresa la descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: fechaController,
                decoration: InputDecoration(
                  labelText: 'Fecha y Hora',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final DateTime initialDate = e == null
                          ? DateTime.now()
                          : e!.fecha;
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: initialDate,
                        firstDate: DateTime(2025),
                        lastDate: DateTime(2050),
                      );
                      if (picked != null) {
                        TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: e == null
                              ? TimeOfDay.now()
                              : TimeOfDay(
                                  hour: e!.fecha.hour,
                                  minute: e!.fecha.minute,
                                ),
                        );
                        if (time != null) {
                          final pickedDateTime = DateTime(
                            picked.year,
                            picked.month,
                            picked.day,
                            time.hour,
                            time.minute,
                          );
                          fechaController.text =
                              pickedDateTime.toIso8601String();
                        }
                      }
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la fecha y hora';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: lugarController,
                decoration: InputDecoration(
                  labelText: 'Lugar',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el lugar';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: saveEvento,
                child: Text(e != null ? 'Actualizar' : 'Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveEvento() async {
    // validar las cajas de texto del formulario
    if (formKey.currentState!.validate()) {
      // si no hay problema, crear el evento
      final evento = Evento(
        id: e?.id, // si e es nulo, se crea un nuevo evento
        nombre: nombreController.text,
        descripcion: descripcionController.text,
        fecha: DateTime.parse(fechaController.text),
        lugar: lugarController.text,
      );
      if (evento.id != null) {
        // si e no es nulo, actualizar el evento
        await EventoRepository.update(evento);
      } else {
        // si e es nulo, insertar el evento
        await EventoRepository.insert(evento);
      }
      Navigator.pop(context);
    }
  }
}
