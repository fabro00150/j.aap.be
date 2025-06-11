class Asistencia {
  final int? id;
  final int eventoId;
  final int usuarioId;
  final DateTime fechaHora;
  final String asistio;

  Asistencia({
    this.id,
    required this.eventoId,
    required this.usuarioId,  
    required this.fechaHora,
    required this.asistio,
  });
  
  factory Asistencia.fromJson(Map<String, dynamic> json) {
    return Asistencia(
      id: json["id"],
      eventoId: json["evento_id"],
      usuarioId: json["usuario_id"],      
      fechaHora: DateTime.parse(json["fecha_hora"]),
      asistio: json["asistio"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "evento_id": eventoId,
      "usuario_id": usuarioId,      
      "fecha_hora": fechaHora.toIso8601String(),
      "asistio": asistio,
    };
  }
}

