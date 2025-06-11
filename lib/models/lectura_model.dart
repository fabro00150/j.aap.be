class Lectura {
  final int? id;
  final int usuarioId;
  final int consumo;
  final int mes;
  final DateTime fecha;

  Lectura({
    this.id,
    required this.usuarioId,
    required this.consumo,
    required this.mes,
    required this.fecha,
  });

  

  factory Lectura.fromJson(Map<String, dynamic> json) {
    return Lectura(
      id: json["id"],
      usuarioId: json["usuario_id"],
      consumo: json["consumo"],
      mes: json["mes"],
      fecha: DateTime.parse(json["fecha"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "usuario_id": usuarioId,
      "consumo": consumo,
      "mes": mes,
      "fecha": fecha.toIso8601String(),
    };
  }
}
