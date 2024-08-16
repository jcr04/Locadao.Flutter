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
      id: json['id'],
      dataInicio: DateTime.parse(json['dataInicio']),
      dataFim: DateTime.parse(json['dataFim']),
      valor: json['valor'].toDouble(),
      status: json['status'],
      veiculo: Veiculo.fromJson(json['veiculo']),
    );
  }
}
