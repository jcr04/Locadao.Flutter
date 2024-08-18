import 'package:locadao/models/Aluguel.dart';

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
    return Agencia(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      endereco: json['endereco'] ?? '',
      telefone: json['telefone'] ?? '',
      numeroVeiculos: json['numeroVeiculos'] ?? 0,
      alugueis: (json['alugueis'] as List)
          .map((aluguel) => Aluguel.fromJson(aluguel))
          .toList(),
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
