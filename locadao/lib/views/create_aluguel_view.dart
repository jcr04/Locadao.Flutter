// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:locadao/controllers/aluguel_controller.dart';
import 'package:locadao/controllers/cliente_controller.dart';
import 'package:locadao/controllers/agencia_controller.dart';
import 'package:locadao/controllers/veiculo_controller.dart';
import 'package:locadao/models/aluguel.dart';
import 'package:locadao/models/cliente.dart';
import 'package:locadao/models/agencia.dart';
import 'package:locadao/models/veiculo.dart';
import 'package:locadao/widgets/logo_header.dart';
import 'package:intl/intl.dart';

class CreateAluguelView extends StatefulWidget {
  const CreateAluguelView({super.key});

  @override
  _CreateAluguelViewState createState() => _CreateAluguelViewState();
}

class _CreateAluguelViewState extends State<CreateAluguelView> {
  final _formKey = GlobalKey<FormState>();
  final AluguelController _aluguelController = AluguelController();
  final ClienteController _clienteController = ClienteController();
  final AgenciaController _agenciaController = AgenciaController();
  final VeiculoController _veiculoController = VeiculoController();

  // Controladores de formulário
  DateTime _dataInicio = DateTime.now();
  DateTime _dataFim = DateTime.now().add(const Duration(days: 1));
  double? _valor;
  final String _status = 'Ativo';

  // Dropdowns
  String? _clienteSelecionado;
  String? _agenciaSelecionada;
  String? _veiculoSelecionado;

  List<Cliente> _clientesDisponiveis = [];
  List<Agencia> _agenciasDisponiveis = [];
  List<Veiculo> _veiculosDisponiveis = [];

  bool _isLoading = true;
  bool _isLoadingVeiculos = false;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      List<Cliente> clientes =
          await _clienteController.getClientesDisponiveis();
      List<Agencia> agencias = await _agenciaController.getAgencias();
      setState(() {
        _clientesDisponiveis = clientes;
        _agenciasDisponiveis = agencias;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar dados iniciais: $e')),
      );
    }
  }

  Future<void> _fetchVeiculosDisponiveis() async {
    setState(() {
      _isLoadingVeiculos = true;
    });
    try {
      List<Veiculo> veiculos =
          await _veiculoController.getVeiculosDisponiveis();
      setState(() {
        _veiculosDisponiveis = veiculos;
        _isLoadingVeiculos = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingVeiculos = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar veículos: $e')),
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Aluguel novoAluguel = Aluguel(
        id: '',
        clienteId: _clienteSelecionado!,
        agenciaId: _agenciaSelecionada!,
        dataInicio: _dataInicio,
        dataFim: _dataFim,
        valor: _valor!,
        status: _status,
        veiculoId: _veiculoSelecionado!,
      );

      try {
        Aluguel aluguelCriado =
            await _aluguelController.createAluguel(novoAluguel);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Aluguel criado com sucesso! ID: ${aluguelCriado.id}')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao criar o aluguel: $e')),
        );
      }
    }
  }

  // Funções para selecionar datas
  Future<void> _selectDataInicio(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataInicio,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dataInicio) {
      setState(() {
        _dataInicio = picked;
        if (_dataFim.isBefore(_dataInicio)) {
          _dataFim = _dataInicio.add(const Duration(days: 1));
        }
      });
    }
  }

  Future<void> _selectDataFim(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataFim,
      firstDate: _dataInicio.add(const Duration(days: 1)),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dataFim) {
      setState(() {
        _dataFim = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Aluguel'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  ImageHeaderWidget(
                    imagePath: 'lib/assets/locadao.png',
                    height:
                        isPortrait ? screenHeight * 0.15 : screenHeight * 0.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Dropdown Cliente
                          DropdownButtonFormField<String>(
                            decoration:
                                const InputDecoration(labelText: 'Cliente'),
                            value: _clienteSelecionado,
                            items: _clientesDisponiveis.map((Cliente cliente) {
                              return DropdownMenuItem<String>(
                                value: cliente.id,
                                child: Text(cliente.nome),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _clienteSelecionado = newValue;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Por favor, selecione um cliente'
                                : null,
                          ),
                          // Dropdown Agência
                          DropdownButtonFormField<String>(
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
                                _veiculoSelecionado = null;
                                _veiculosDisponiveis.clear();
                                _fetchVeiculosDisponiveis();
                              });
                            },
                            validator: (value) => value == null
                                ? 'Por favor, selecione uma agência'
                                : null,
                          ),
                          // Dropdown Veículo
                          _isLoadingVeiculos
                              ? const CircularProgressIndicator()
                              : DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                      labelText: 'Veículo'),
                                  value: _veiculoSelecionado,
                                  items: _veiculosDisponiveis
                                      .map((Veiculo veiculo) {
                                    return DropdownMenuItem<String>(
                                      value: veiculo.id,
                                      child: Text(
                                          '${veiculo.marca} ${veiculo.modelo}'),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _veiculoSelecionado = newValue;
                                    });
                                  },
                                  validator: (value) => value == null
                                      ? 'Por favor, selecione um veículo'
                                      : null,
                                ),
                          // Campo Data Início
                          ListTile(
                            title: Text(
                                'Data de Início: ${DateFormat('dd/MM/yyyy').format(_dataInicio)}'),
                            trailing: const Icon(Icons.calendar_today),
                            onTap: () => _selectDataInicio(context),
                          ),
                          // Campo Data Fim
                          ListTile(
                            title: Text(
                                'Data de Fim: ${DateFormat('dd/MM/yyyy').format(_dataFim)}'),
                            trailing: const Icon(Icons.calendar_today),
                            onTap: () => _selectDataFim(context),
                          ),
                          // Campo Valor
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Valor'),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) == null) {
                                return 'Por favor, insira um valor válido';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _valor = double.tryParse(value);
                            },
                          ),
                          // Campo Status
                          TextFormField(
                            initialValue: _status,
                            decoration:
                                const InputDecoration(labelText: 'Status'),
                            readOnly: true,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                            ),
                            child: const Text('Criar Aluguel'),
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
