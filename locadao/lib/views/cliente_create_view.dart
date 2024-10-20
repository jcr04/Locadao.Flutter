import 'package:flutter/material.dart';
import 'package:locadao/controllers/cliente_controller.dart';
import 'package:locadao/models/cliente.dart';
import 'package:locadao/widgets/logo_header.dart';

class ClienteCreateView extends StatefulWidget {
  const ClienteCreateView({super.key});

  @override
  _ClienteCreateViewState createState() => _ClienteCreateViewState();
}

class _ClienteCreateViewState extends State<ClienteCreateView> {
  final _formKey = GlobalKey<FormState>();
  final ClienteController _controller = ClienteController();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  bool _temCNH = false;
  bool _isPCD = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Cliente novoCliente = Cliente(
        id: '',
        nome: _nomeController.text,
        idade: int.parse(_idadeController.text),
        email: _emailController.text,
        telefone: _telefoneController.text,
        cpf: _cpfController.text,
        temCNH: _temCNH,
        isPCD: _isPCD,
      );

      try {
        Cliente clienteCriado = await _controller.createCliente(novoCliente);
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
                    // Campo Idade
                    TextFormField(
                      controller: _idadeController,
                      decoration: const InputDecoration(labelText: 'Idade'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null) {
                          return 'Por favor, insira uma idade válida';
                        }
                        return null;
                      },
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
                      child: const Text('Criar Cliente'),
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
