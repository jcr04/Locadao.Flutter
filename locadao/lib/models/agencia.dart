class Agencia {
  final String id;
  final String nome;
  final String endereco;
  final String telefone;

  Agencia({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.telefone,
  });

  factory Agencia.fromJson(Map<String, dynamic> json) {
    return Agencia(
      id: json['id'],
      nome: json['nome'],
      endereco: json['endereco'],
      telefone: json['telefone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'telefone': telefone,
    };
  }
}
