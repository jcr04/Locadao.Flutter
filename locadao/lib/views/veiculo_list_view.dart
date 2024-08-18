import 'package:flutter/material.dart';
import 'package:locadao/models/Veiculo.dart';
import 'package:locadao/services/api_services_veiculos.dart';
import 'package:locadao/views/veiculo_detalhes_view.dart';
import 'package:locadao/widgets/logo_header.dart';

class VeiculoListView extends StatefulWidget {
  @override
  _VeiculoListViewState createState() => _VeiculoListViewState();
}

class _VeiculoListViewState extends State<VeiculoListView> {
  final ApiServicesVeiculos _apiService = ApiServicesVeiculos();
  late Future<List<Veiculo>> _veiculos;

  @override
  void initState() {
    super.initState();
    _veiculos = _apiService.getVeiculosDisponiveis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veículos Disponíveis'),
      ),
      body: Column(
        children: [
          const ImageHeaderWidget(
            imagePath: 'lib/assets/locadao.png',
            height: 100.0,
          ),
          Expanded(
            child: FutureBuilder<List<Veiculo>>(
              future: _veiculos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum veículo encontrado'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var veiculo = snapshot.data![index];
                      return ListTile(
                        title: Text('${veiculo.marca} ${veiculo.modelo}'),
                        subtitle: Text('Placa: ${veiculo.placa}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VeiculoDetalhesView(
                                veiculoId: veiculo.id,
                              ),
                            ),
                          );
                        },
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
}
