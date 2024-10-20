// ignore_for_file: file_names

import 'package:locadao/models/aluguel.dart';
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
      agencia: Agencia.fromJson(json['agencia'] ?? {}),
      numeroVeiculos: json['numeroVeiculos'] ?? 0,
      alugueis: (json['alugueis'] as List)
          .map((aluguel) => Aluguel.fromJson(aluguel))
          .toList(),
    );
  }
}
