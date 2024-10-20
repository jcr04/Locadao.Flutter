// ignore_for_file: file_names

class Cliente {
  final String id;
  final String nome;
  final int idade;
  final String email;
  final String telefone;
  final String cpf;
  final bool temCNH;
  final bool isPCD;

  Cliente({
    required this.id,
    required this.nome,
    required this.idade,
    required this.email,
    required this.telefone,
    required this.cpf,
    required this.temCNH,
    required this.isPCD,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      idade: json['idade'] ?? 0,
      email: json['email'] ?? '',
      telefone: json['telefone'] ?? '',
      cpf: json['cpf'] ?? '',
      temCNH: json['temCNH'] ?? false,
      isPCD: json['isPCD'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'email': email,
      'telefone': telefone,
      'cpf': cpf,
      'temCNH': temCNH,
      'isPCD': isPCD,
    };
  }
}
