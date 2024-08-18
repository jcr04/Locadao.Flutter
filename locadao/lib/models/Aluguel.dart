import 'package:locadao/models/Veiculo.dart';

class Aluguel {
  final String id;
  final DateTime dataInicio;
  final DateTime dataFim;
  final double valor;
  final String status;
  final Veiculo veiculo;

  Aluguel({
    required this.id,
    required this.dataInicio,
    required this.dataFim,
    required this.valor,
    required this.status,
    required this.veiculo,
  });

  factory Aluguel.fromJson(Map<String, dynamic> json) {
    return Aluguel(
      id: json['id'] ?? '',
      dataInicio:
          DateTime.parse(json['dataInicio'] ?? DateTime.now().toString()),
      dataFim: DateTime.parse(json['dataFim'] ?? DateTime.now().toString()),
      valor: json['valor']?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      veiculo: Veiculo.fromJson(json['veiculo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dataInicio': dataInicio.toIso8601String(),
      'dataFim': dataFim.toIso8601String(),
      'valor': valor,
      'status': status,
      'veiculo': veiculo.toJson(),
    };
  }
}
