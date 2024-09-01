import 'package:flutter/material.dart';
import 'package:locadao/models/Veiculo.dart';
import 'package:locadao/services/api_services_veiculos.dart';
import 'package:locadao/views/veiculo_detalhes_view.dart';
import 'package:locadao/widgets/Vehicle_feature_card_widget.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Veículos Disponíveis'),
      ),
      body: Column(
        children: [
          ImageHeaderWidget(
            imagePath: 'lib/assets/locadao.png',
            height: isPortrait ? screenHeight * 0.15 : screenHeight * 0.2,
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
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: screenWidth * 0.04,
                        ),
                        child: InkWell(
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
                          child: VehicleFeatureCardWidget(
                            icon: Icons.directions_car,
                            title: '${veiculo.marca} ${veiculo.modelo}',
                            subtitle: 'Placa: ${veiculo.placa}',
                            gradientStartColor: Colors.deepPurple,
                            gradientEndColor: Colors.purple,
                            onTap: () {},
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
}
