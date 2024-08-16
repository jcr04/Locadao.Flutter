class Veiculo {
  final String marca;
  final String modelo;
  final String placa;

  Veiculo({
    required this.marca,
    required this.modelo,
    required this.placa,
  });

  factory Veiculo.fromJson(Map<String, dynamic> json) {
    return Veiculo(
      marca: json['marca'],
      modelo: json['modelo'],
      placa: json['placa'],
    );
  }
}
