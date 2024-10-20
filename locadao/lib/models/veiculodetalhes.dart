// ignore_for_file: file_names

class VeiculoDetalhes {
  final String id;
  final String marca;
  final String modelo;
  final int anoFabricacao;
  final String placa;
  final String cor;
  final double quilometragem;
  final bool automatico;
  final bool disponivelParaAluguel;
  final bool adaptadoParaPCD;
  final String agenciaId;

  VeiculoDetalhes({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.anoFabricacao,
    required this.placa,
    required this.cor,
    required this.quilometragem,
    required this.automatico,
    required this.disponivelParaAluguel,
    required this.adaptadoParaPCD,
    required this.agenciaId,
  });

  factory VeiculoDetalhes.fromJson(Map<String, dynamic> json) {
    return VeiculoDetalhes(
      id: json['id'] ?? '',
      marca: json['marca'] ?? '',
      modelo: json['modelo'] ?? '',
      anoFabricacao: json['anoFabricacao'] ?? 0,
      placa: json['placa'] ?? '',
      cor: json['cor'] ?? '',
      quilometragem: (json['quilometragem'] != null)
          ? json['quilometragem'].toDouble()
          : 0.0,
      automatico: json['automatico'] ?? false,
      disponivelParaAluguel: json['disponivelParaAluguel'] ?? false,
      adaptadoParaPCD: json['adaptadoParaPCD'] ?? false,
      agenciaId: json['agenciaId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'anoFabricacao': anoFabricacao,
      'placa': placa,
      'cor': cor,
      'quilometragem': quilometragem,
      'automatico': automatico,
      'disponivelParaAluguel': disponivelParaAluguel,
      'adaptadoParaPCD': adaptadoParaPCD,
      'agenciaId': agenciaId,
    };
  }
}
