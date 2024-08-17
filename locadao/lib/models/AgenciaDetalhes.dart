import 'package:locadao/models/Aluguel.dart';
import 'package:locadao/models/agencia.dart';

class AgenciaDetalhes {
  final Agencia agencia;
  final int numeroVeiculos;
  final List<Aluguel> alugueis;

  AgenciaDetalhes({
    required this.agencia,
    required this.numeroVeiculos,
    required this.alugueis,
  });

  factory AgenciaDetalhes.fromJson(Map<String, dynamic> json) {
    return AgenciaDetalhes(
      agencia: Agencia.fromJson(json['agencia']),
      numeroVeiculos: json['numeroVeiculos'],
      alugueis:
          (json['alugueis'] as List).map((a) => Aluguel.fromJson(a)).toList(),
    );
  }
}