class Veiculo {
  final String id;
  final String marca;
  final String modelo;
  final String placa;
  final String? agencia;

  Veiculo({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.placa,
    this.agencia,
  });

  factory Veiculo.fromJson(Map<String, dynamic> json) {
    return Veiculo(
      id: json['id'] ?? '',
      marca: json['marca'] ?? '',
      modelo: json['modelo'] ?? '',
      placa: json['placa'] ?? '',
      agencia: json['agencia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'placa': placa,
      'agencia': agencia,
    };
  }
}
