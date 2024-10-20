import 'package:locadao/models/aluguel.dart';

class Agencia {
  final String id;
  final String nome;
  final String endereco;
  final String telefone;
  final int numeroVeiculos;
  final List<Aluguel> alugueis;

  Agencia({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.telefone,
    required this.numeroVeiculos,
    required this.alugueis,
  });

  factory Agencia.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> agenciaData =
        json.containsKey('agencia') ? json['agencia'] : json;

    return Agencia(
      id: agenciaData['id'] ?? '',
      nome: agenciaData['nome'] ?? '',
      endereco: agenciaData['endereco'] ?? '',
      telefone: agenciaData['telefone'] ?? '',
      numeroVeiculos: agenciaData['numeroVeiculos'] ?? 0,
      alugueis: (agenciaData['alugueis'] != null)
          ? (agenciaData['alugueis'] as List)
              .map((aluguel) => Aluguel.fromJson(aluguel))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'telefone': telefone,
      'numeroVeiculos': numeroVeiculos,
      'alugueis': alugueis.map((aluguel) => aluguel.toJson()).toList(),
    };
  }
}
