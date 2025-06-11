class Pagos {
  final int id;
  final String fecha;
  final double monto;
  final String descripcion;
  final int usuarioId;

  Pagos({
    required this.id,
    required this.fecha,
    required this.monto,
    required this.descripcion,
    required this.usuarioId,
  });

  factory Pagos.fromJson(Map<String, dynamic> json) {
    return Pagos(
      id: json["id"],
      fecha: json["fecha"],
      monto: json["monto"].toDouble(),
      descripcion: json["descripcion"],
      usuarioId: json['usuario_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha,
      'monto': monto,
      'descripcion': descripcion,
      'usuario_id': usuarioId,
    };
  }
}
