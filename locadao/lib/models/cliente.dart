class Cliente {
  final String id;
  final String nome;
  final DateTime dataNascimento;
  final String email;
  final String telefone;
  final String cpf;
  final bool temCNH;
  final bool isPCD;
  final DateTime? validadeCNH;

  Cliente({
    required this.id,
    required this.nome,
    required this.dataNascimento,
    required this.email,
    required this.telefone,
    required this.cpf,
    required this.temCNH,
    required this.isPCD,
    this.validadeCNH,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      dataNascimento: DateTime.parse(
          json['dataNascimento'] ?? DateTime.now().toIso8601String()),
      email: json['email'] ?? '',
      telefone: json['telefone'] ?? '',
      cpf: json['cpf'] ?? '',
      temCNH: json['temCNH'] ?? false,
      isPCD: json['isPCD'] ?? false,
      validadeCNH: json['validadeCNH'] != null
          ? DateTime.parse(json['validadeCNH'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'dataNascimento': dataNascimento.toIso8601String(),
      'email': email,
      'telefone': telefone,
      'cpf': cpf,
      'temCNH': temCNH,
      'isPCD': isPCD,
      'validadeCNH': validadeCNH?.toIso8601String(),
    };
  }
}
