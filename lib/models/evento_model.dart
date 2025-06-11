class Evento {
  final int? id;
  final String nombre;
  final String descripcion;
  final DateTime fecha;
  final String lugar;

  Evento({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.fecha,
    required this.lugar,
  });

  

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      id: json["id"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      fecha: DateTime.parse(json["fecha"]),
      lugar: json["lugar"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "descripcion": descripcion,
      "fecha": fecha.toIso8601String(),
      "lugar": lugar,
    };
  }
}
