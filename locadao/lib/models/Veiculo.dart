class Veiculo {
  final String id;
  final String marca;
  final String modelo;
  final String placa;

  Veiculo({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.placa,
  });

  factory Veiculo.fromJson(Map<String, dynamic> json) {
    return Veiculo(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      placa: json['placa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'marca': marca,
      'modelo': modelo,
      'placa': placa,
    };
  }
}
