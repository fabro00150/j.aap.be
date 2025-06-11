class Sector {
  final int? id;
  final String nombre;
  final String descripcion;
  final String estado;

  Sector({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
  });

  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado:
          json['estado'].toString(), // Convertir bool a String si es necesario
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'estado': estado,
    };
  }
}
