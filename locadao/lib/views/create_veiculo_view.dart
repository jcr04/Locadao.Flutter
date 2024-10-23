// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:locadao/controllers/agencia_controller.dart';
import 'package:locadao/controllers/veiculo_controller.dart';
import 'package:locadao/models/veiculodetalhes.dart';
import 'package:locadao/widgets/logo_header.dart';
import 'package:locadao/models/agencia.dart';

class CreateVeiculoView extends StatefulWidget {
  const CreateVeiculoView({super.key});

  @override
  _CreateVeiculoViewState createState() => _CreateVeiculoViewState();
}

class _CreateVeiculoViewState extends State<CreateVeiculoView> {
  final _formKey = GlobalKey<FormState>();
  final VeiculoController _controller = VeiculoController();

  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _anoFabricacaoController =
      TextEditingController();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _corController = TextEditingController();
  final TextEditingController _quilometragemController =
      TextEditingController();

  bool _automatico = false;
  bool _disponivelParaAluguel = true;
  bool _adaptadoParaPCD = false;

  String? _agenciaSelecionada;
  List<Agencia> _agenciasDisponiveis = [];
  bool _isLoadingAgencias = true;

  @override
  void initState() {
    super.initState();
    _fetchAgencias();
  }

  void _fetchAgencias() async {
    try {
      final agenciaController = AgenciaController();
      List<Agencia> agencias = await agenciaController.getAgencias();
      setState(() {
        _agenciasDisponiveis = agencias;
        _isLoadingAgencias = false;

        // Log dos IDs e Nomes das agências
        for (var agencia in _agenciasDisponiveis) {
          if (kDebugMode) {
            print('Agência carregada: ID=${agencia.id}, Nome=${agencia.nome}');
          }
        }
      });
    } catch (e) {
      setState(() {
        _isLoadingAgencias = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar as agências: $e')),
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_agenciaSelecionada == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecione uma agência')),
        );
        return;
      }

      VeiculoDetalhes novoVeiculo = VeiculoDetalhes(
        id: '', // O ID será gerado pelo backend
        marca: _marcaController.text,
        modelo: _modeloController.text,
        anoFabricacao: int.parse(_anoFabricacaoController.text),
        placa: _placaController.text,
        cor: _corController.text,
        quilometragem: double.parse(_quilometragemController.text),
        automatico: _automatico,
        disponivelParaAluguel: _disponivelParaAluguel,
        adaptadoParaPCD: _adaptadoParaPCD,
        agenciaId: _agenciaSelecionada!,
      );

      try {
        String veiculoId = await _controller.createVeiculo(novoVeiculo);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veículo criado com sucesso! ID: $veiculoId')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao criar o veículo: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _anoFabricacaoController.dispose();
    _placaController.dispose();
    _corController.dispose();
    _quilometragemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Veículo'),
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
                    // Campo Marca
                    TextFormField(
                      controller: _marcaController,
                      decoration: const InputDecoration(labelText: 'Marca'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a marca';
                        }
                        return null;
                      },
                    ),
                    // Campo Modelo
                    TextFormField(
                      controller: _modeloController,
                      decoration: const InputDecoration(labelText: 'Modelo'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o modelo';
                        }
                        return null;
                      },
                    ),
                    // Campo Ano de Fabricação
                    TextFormField(
                      controller: _anoFabricacaoController,
                      decoration:
                          const InputDecoration(labelText: 'Ano de Fabricação'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null) {
                          return 'Por favor, insira um ano válido';
                        }
                        return null;
                      },
                    ),
                    // Campo Placa
                    TextFormField(
                      controller: _placaController,
                      decoration: const InputDecoration(labelText: 'Placa'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a placa';
                        }
                        return null;
                      },
                    ),
                    // Campo Cor
                    TextFormField(
                      controller: _corController,
                      decoration: const InputDecoration(labelText: 'Cor'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a cor';
                        }
                        return null;
                      },
                    ),
                    // Campo Quilometragem
                    TextFormField(
                      controller: _quilometragemController,
                      decoration:
                          const InputDecoration(labelText: 'Quilometragem'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null) {
                          return 'Por favor, insira uma quilometragem válida';
                        }
                        return null;
                      },
                    ),
                    // Campo Automático (Checkbox)
                    CheckboxListTile(
                      title: const Text('Automático'),
                      value: _automatico,
                      onChanged: (bool? value) {
                        setState(() {
                          _automatico = value ?? false;
                        });
                      },
                    ),
                    // Campo Disponível para Aluguel (Checkbox)
                    CheckboxListTile(
                      title: const Text('Disponível para Aluguel'),
                      value: _disponivelParaAluguel,
                      onChanged: (bool? value) {
                        setState(() {
                          _disponivelParaAluguel = value ?? true;
                        });
                      },
                    ),
                    // Campo Adaptado para PCD (Checkbox)
                    CheckboxListTile(
                      title: const Text('Adaptado para PCD'),
                      value: _adaptadoParaPCD,
                      onChanged: (bool? value) {
                        setState(() {
                          _adaptadoParaPCD = value ?? false;
                        });
                      },
                    ),
                    // Campo Agência (Dropdown)
                    _isLoadingAgencias
                        ? const CircularProgressIndicator()
                        : DropdownButtonFormField<String>(
                            decoration:
                                const InputDecoration(labelText: 'Agência'),
                            value: _agenciaSelecionada,
                            items: _agenciasDisponiveis.map((Agencia agencia) {
                              return DropdownMenuItem<String>(
                                value: agencia.id,
                                child: Text(agencia.nome),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _agenciaSelecionada = newValue;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Por favor, selecione uma agência'
                                : null,
                          ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text('Criar Veículo',
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
