import 'package:flutter/material.dart';
import 'package:locadao/models/AgenciaDetalhes.dart';
import 'package:locadao/models/Aluguel.dart';
import 'package:locadao/widgets/logo_header.dart';
import '../controllers/agencia_controller.dart';

class AgenciaListView extends StatefulWidget {
  @override
  _AgenciaListViewState createState() => _AgenciaListViewState();
}

class _AgenciaListViewState extends State<AgenciaListView> {
  final AgenciaController _controller = AgenciaController();
  late Future<List<AgenciaDetalhes>> _agenciasDetalhes;

  @override
  void initState() {
    super.initState();
    _agenciasDetalhes = _controller.getAgenciasDetalhes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes das Agências')),
      body: Column(
        children: [
          // Adicionando o widget modularizado de header com a logo
          const ImageHeaderWidget(
            imagePath: 'lib/assets/locadao.png',
            height: 100.0,
          ),
          Expanded(
            child: FutureBuilder<List<AgenciaDetalhes>>(
              future: _agenciasDetalhes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Nenhuma agência encontrada'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var agenciaDetalhes = snapshot.data![index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(agenciaDetalhes.agencia.nome,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              Text('ID: ${agenciaDetalhes.agencia.id}'),
                              Text(
                                  'Endereço: ${agenciaDetalhes.agencia.endereco}'),
                              Text(
                                  'Telefone: ${agenciaDetalhes.agencia.telefone}'),
                              Text(
                                  'Número de Veículos: ${agenciaDetalhes.numeroVeiculos}'),
                              const SizedBox(height: 16),
                              Text('Aluguéis',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              ...agenciaDetalhes.alugueis
                                  .map((aluguel) => _buildAluguelItem(aluguel)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAluguelItem(Aluguel aluguel) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID do Aluguel: ${aluguel.id}'),
            Text('Data de Início: ${_formatDate(aluguel.dataInicio)}'),
            Text('Data de Fim: ${_formatDate(aluguel.dataFim)}'),
            Text('Valor: ${aluguel.valor}'),
            Text('Status: ${aluguel.status}'),
            Text(
                'Veículo: ${aluguel.veiculo.marca} ${aluguel.veiculo.modelo} (Placa: ${aluguel.veiculo.placa})'),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}
