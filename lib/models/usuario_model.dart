class Usuario {
  final int? id;
  final sectorId;
  final dniCedula;
  final apellidoPaterno;
  final apellidoMaterno;
  final nombres;
  final String? telefono;

  Usuario({
    this.id,
    required this.sectorId,
    required this.dniCedula,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.nombres,
    this.telefono,
  });

  

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json["id"],
      sectorId: json["sector_id"],
      dniCedula: json["dni_cedula"],
      apellidoPaterno: json["apellido_paterno"],
      apellidoMaterno: json["apellido_materno"],
      nombres: json["nombres"],
      telefono: json["telefono"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sector_id": sectorId,
      "dni_cedula": dniCedula,
      "apellido_paterno": apellidoPaterno,
      "apellido_materno": apellidoMaterno,
      "nombres": nombres,
      "telefono": telefono,
    };
  }
  
}
