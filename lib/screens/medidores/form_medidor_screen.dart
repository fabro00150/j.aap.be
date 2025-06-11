import 'package:flutter/material.dart';
import 'package:jappbe/models/medidor_model.dart';
import 'package:jappbe/repositories/medidor_repository.dart';

class FormMedidorScreen extends StatefulWidget {
  const FormMedidorScreen({Key? key});

  @override
  _FormMedidorScreenState createState() => _FormMedidorScreenState();
}

class _FormMedidorScreenState extends State<FormMedidorScreen> {
  // CONTROLLERS
  // para el formulario
  final formKey = GlobalKey<FormState>();
  // para los campos
  final TextEditingController usuarioIdController = TextEditingController();
  final TextEditingController numeroSerieController = TextEditingController();
  final TextEditingController coordenadasController = TextEditingController();
  final TextEditingController fecha_instalacionController =
      TextEditingController();

  // declaración _medidor
  Medidor? m;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Medidor) {
      // si el argumento es un medidor, asignar a m
      m = args;
      // si el medidor no es nulo, asignar los valores a los campos
      if (m != null) {
        usuarioIdController.text = m!.usuarioId.toString();
        numeroSerieController.text = m!.numeroSerie;
        coordenadasController.text = m!.coordenadas!;
        fecha_instalacionController.text =
            m!.fechaInstalacion.toIso8601String();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(m == null ? "Nuevo Medidor" : "Editar Medidor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: usuarioIdController,
                decoration: InputDecoration(labelText: "Usuario ID"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el usuario ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: numeroSerieController,
                decoration: InputDecoration(labelText: "Número de Serie"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el número de serie';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: coordenadasController,
                decoration: InputDecoration(labelText: "Coordenadas"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa las coordenadas';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: fecha_instalacionController,
                decoration: InputDecoration(labelText: "Fecha de Instalación"),
                readOnly: true,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: fecha_instalacionController.text.isNotEmpty
                        ? DateTime.parse(fecha_instalacionController.text)
                        : DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    fecha_instalacionController.text = pickedDate.toIso8601String();
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la fecha de instalación';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              // Botón para guardar o actualizar el medidor
              ElevatedButton(
                onPressed: saveMedidor,
                child: Text(m == null ? "Guardar" : "Actualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveMedidor() async {
    if (formKey.currentState!.validate()) {
      final medidor = Medidor(
        id: m?.id,
        usuarioId: int.parse(usuarioIdController.text),
        numeroSerie: numeroSerieController.text,
        coordenadas: coordenadasController.text,
        fechaInstalacion: DateTime.parse(fecha_instalacionController.text),
      );      
      Navigator.pop(context);
    }
  }
}
