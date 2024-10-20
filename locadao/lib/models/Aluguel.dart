import 'package:locadao/models/veiculo.dart';

class Aluguel {
  final String id;
  final String clienteId;
  final String agenciaId;
  final DateTime dataInicio;
  final DateTime dataFim;
  final double valor;
  final String status;
  final Veiculo? veiculo;
  final String veiculoId;

  Aluguel(
      {required this.id,
      required this.clienteId,
      required this.agenciaId,
      required this.dataInicio,
      required this.dataFim,
      required this.valor,
      required this.status,
      this.veiculo,
      required this.veiculoId});

  factory Aluguel.fromJson(Map<String, dynamic> json) {
    return Aluguel(
      id: json['id'] ?? '',
      clienteId: json['clienteId'] ?? '',
      agenciaId: json['agenciaId'] ?? '',
      dataInicio:
          DateTime.parse(json['dataInicio'] ?? DateTime.now().toString()),
      dataFim: DateTime.parse(json['dataFim'] ?? DateTime.now().toString()),
      valor: (json['valor'] ?? 0.0).toDouble(),
      status: json['status'] ?? '',
      veiculo:
          json['veiculo'] != null ? Veiculo.fromJson(json['veiculo']) : null,
      veiculoId: json['veiculoId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clienteId': clienteId,
      'agenciaId': agenciaId,
      'dataInicio': dataInicio.toUtc().toIso8601String(),
      'dataFim': dataFim.toUtc().toIso8601String(),
      'valor': valor,
      'status': status,
      'veiculoId': veiculoId,
    };
  }
}
