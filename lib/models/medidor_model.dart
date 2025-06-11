class Medidor {
  final int? id;
  final int usuarioId;
  final String numeroSerie;
  final String? coordenadas;
  final DateTime fechaInstalacion;

  Medidor({
    this.id,
    required this.usuarioId,
    required this.numeroSerie,
    this.coordenadas,
    required this.fechaInstalacion,
  });

  

  factory Medidor.fromJson(Map<String, dynamic> json) {
    return Medidor(
      id: json["id"],
      usuarioId: json["usuario_id"],
      numeroSerie: json["numero_serie"],
      coordenadas: json["coordenadas"],
      fechaInstalacion: DateTime.parse(json["fecha_instalacion"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "usuario_id": usuarioId,
      "numero_serie": numeroSerie,
      "coordenadas": coordenadas,
      "fecha_instalacion": fechaInstalacion.toIso8601String(),
    };
  }
}
