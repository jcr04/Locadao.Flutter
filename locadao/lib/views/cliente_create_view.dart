import 'package:flutter/material.dart';
import 'package:locadao/controllers/cliente_controller.dart';
import 'package:locadao/models/cliente.dart';
import 'package:locadao/widgets/logo_header.dart';
import 'package:intl/intl.dart';

class ClienteCreateView extends StatefulWidget {
  const ClienteCreateView({super.key});

  @override
  _ClienteCreateViewState createState() => _ClienteCreateViewState();
}

class _ClienteCreateViewState extends State<ClienteCreateView> {
  final _formKey = GlobalKey<FormState>();
  final ClienteController _controller = ClienteController();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  bool _temCNH = false;
  bool _isPCD = false;
  DateTime? _dataNascimento;
  DateTime? _validadeCNH;

  Future<void> _selectDataNascimento(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dataNascimento) {
      setState(() {
        _dataNascimento = picked;
      });
    }
  }

  Future<void> _selectValidadeCNH(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _validadeCNH ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _validadeCNH) {
      setState(() {
        _validadeCNH = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Validação adicional
      final idade = _calcularIdade(_dataNascimento!);
      if (idade < 18) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('O cliente deve ter pelo menos 18 anos.')),
        );
        return;
      }

      if (_temCNH) {
        if (_validadeCNH == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Por favor, insira a validade da CNH.')),
          );
          return;
        } else if (_validadeCNH!.isBefore(DateTime.now())) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('A CNH está vencida.')),
          );
          return;
        }
      } else {
        _validadeCNH = null;
      }

      Cliente novoCliente = Cliente(
        id: '',
        nome: _nomeController.text,
        dataNascimento: _dataNascimento!,
        email: _emailController.text,
        telefone: _telefoneController.text,
        cpf: _cpfController.text,
        temCNH: _temCNH,
        isPCD: _isPCD,
        validadeCNH: _validadeCNH,
      );

      try {
        await _controller.createCliente(novoCliente);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente criado com sucesso!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao criar o cliente: $e')),
        );
      }
    }
  }

  int _calcularIdade(DateTime dataNascimento) {
    final hoje = DateTime.now();
    int idade = hoje.year - dataNascimento.year;
    if (hoje.month < dataNascimento.month ||
        (hoje.month == dataNascimento.month && hoje.day < dataNascimento.day)) {
      idade--;
    }
    return idade;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Cliente'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageHeaderWidget(
              imagePath: 'lib/assets/locadao.png',
              height: isPortrait ? screenHeight * 0.15 : screenHeight * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Campo Nome
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome';
                        }
                        return null;
                      },
                    ),
                    // Campo Data de Nascimento
                    ListTile(
                      title: Text(
                        _dataNascimento == null
                            ? 'Data de Nascimento'
                            : 'Data de Nascimento: ${DateFormat('dd/MM/yyyy').format(_dataNascimento!)}',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _selectDataNascimento(context),
                    ),
                    // Campo Email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Por favor, insira um email válido';
                        }
                        return null;
                      },
                    ),
                    // Campo Telefone
                    TextFormField(
                      controller: _telefoneController,
                      decoration: const InputDecoration(labelText: 'Telefone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o telefone';
                        }
                        return null;
                      },
                    ),
                    // Campo CPF
                    TextFormField(
                      controller: _cpfController,
                      decoration: const InputDecoration(labelText: 'CPF'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o CPF';
                        }
                        if (value.length != 11) {
                          return 'O CPF deve ter 11 dígitos';
                        }
                        return null;
                      },
                    ),
                    // Campo Tem CNH (Checkbox)
                    CheckboxListTile(
                      title: const Text('Possui CNH?'),
                      value: _temCNH,
                      onChanged: (bool? value) {
                        setState(() {
                          _temCNH = value ?? false;
                        });
                      },
                    ),
                    // Campo Validade da CNH
                    if (_temCNH)
                      ListTile(
                        title: Text(
                          _validadeCNH == null
                              ? 'Validade da CNH'
                              : 'Validade da CNH: ${DateFormat('dd/MM/yyyy').format(_validadeCNH!)}',
                        ),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () => _selectValidadeCNH(context),
                      ),
                    // Campo É PCD (Checkbox)
                    CheckboxListTile(
                      title: const Text('É PCD?'),
                      value: _isPCD,
                      onChanged: (bool? value) {
                        setState(() {
                          _isPCD = value ?? false;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 89, 71, 121),
                      ),
                      child: const Text('Criar Cliente',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
