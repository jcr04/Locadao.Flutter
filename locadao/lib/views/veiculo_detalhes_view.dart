import 'package:flutter/material.dart';
import 'package:locadao/models/veiculodetalhes.dart';
import 'package:locadao/services/api_services_veiculos.dart';
import 'package:locadao/widgets/Vehicle_feature_card_widget.dart';

class VeiculoDetalhesView extends StatelessWidget {
  final String veiculoId;

  VeiculoDetalhesView({required this.veiculoId});

  @override
  Widget build(BuildContext context) {
    final ApiServicesVeiculos _apiService = ApiServicesVeiculos();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Veículo'),
      ),
      body: FutureBuilder<VeiculoDetalhes>(
        future: _apiService.getVeiculoById(veiculoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Nenhum detalhe encontrado'));
          } else {
            var veiculo = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: ListView(
                children: [
                  VehicleFeatureCardWidget(
                    icon: Icons.speed,
                    title: '${veiculo.quilometragem} km',
                    subtitle: 'Quilometragem',
                    onTap: () {},
                  ),
                  VehicleFeatureCardWidget(
                    icon: Icons.settings,
                    title: veiculo.automatico ? "Automático" : "Manual",
                    subtitle: 'Tipo de Transmissão',
                    onTap: () {},
                  ),
                  VehicleFeatureCardWidget(
                    icon: Icons.accessible,
                    title: veiculo.adaptadoParaPCD
                        ? "Adaptado para PCD"
                        : "Não Adaptado",
                    subtitle: 'Acessibilidade',
                    onTap: () {},
                  ),
                  VehicleFeatureCardWidget(
                    icon: Icons.directions_car,
                    title: veiculo.marca,
                    subtitle: 'Marca',
                    onTap: () {},
                  ),
                  VehicleFeatureCardWidget(
                    icon: Icons.model_training,
                    title: veiculo.modelo,
                    subtitle: 'Modelo',
                    onTap: () {},
                  ),
                  VehicleFeatureCardWidget(
                    icon: Icons.calendar_today,
                    title: veiculo.anoFabricacao.toString(),
                    subtitle: 'Ano de Fabricação',
                    onTap: () {},
                  ),
                  VehicleFeatureCardWidget(
                    icon: Icons.confirmation_number,
                    title: veiculo.placa,
                    subtitle: 'Placa',
                    onTap: () {},
                  ),
                  VehicleFeatureCardWidget(
                    icon: Icons.color_lens,
                    title: veiculo.cor,
                    subtitle: 'Cor',
                    onTap: () {},
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
