import 'package:flutter/material.dart';
import 'package:locadao/models/agenciadetalhes.dart';
import 'package:locadao/models/aluguel.dart';
import 'package:locadao/widgets/logo_header.dart';
import 'package:locadao/widgets/agencia_card_widget.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes das Agências')),
      body: Column(
        children: [
          ImageHeaderWidget(
            imagePath: 'lib/assets/locadao.png',
            height: isPortrait ? screenHeight * 0.15 : screenHeight * 0.2,
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
                      return AgenciaCardWidget(
                        title: agenciaDetalhes.agencia.nome,
                        id: agenciaDetalhes.agencia.id,
                        endereco: agenciaDetalhes.agencia.endereco,
                        telefone: agenciaDetalhes.agencia.telefone,
                        numeroVeiculos:
                            agenciaDetalhes.numeroVeiculos.toString(),
                        gradientStartColor: Colors.deepPurple,
                        gradientEndColor: Colors.purple,
                        aluguelInfo: agenciaDetalhes.alugueis.isEmpty
                            ? null
                            : agenciaDetalhes.alugueis
                                .map((aluguel) =>
                                    _buildAluguelItemInfo(aluguel as Aluguel))
                                .join("\n\n"),
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

  String _buildAluguelItemInfo(Aluguel aluguel) {
    return 'ID do Aluguel: ${aluguel.id}\n'
        'Início: ${_formatDate(aluguel.dataInicio)}\n'
        'Fim: ${_formatDate(aluguel.dataFim)}\n'
        'Valor: ${aluguel.valor}\n'
        'Status: ${aluguel.status}\n'
        'Veículo: ${aluguel.veiculo != null ? '${aluguel.veiculo!.marca} ${aluguel.veiculo!.modelo} (Placa: ${aluguel.veiculo!.placa})' : 'Informação do veículo não disponível'}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}
