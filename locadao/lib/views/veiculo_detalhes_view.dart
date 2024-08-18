import 'package:flutter/material.dart';
import 'package:locadao/models/VeiculoDetalhes.dart';
import 'package:locadao/services/api_services_veiculos.dart';

class VeiculoDetalhesView extends StatelessWidget {
  final String veiculoId;

  VeiculoDetalhesView({required this.veiculoId});

  @override
  Widget build(BuildContext context) {
    final ApiServicesVeiculos _apiService = ApiServicesVeiculos();

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
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text('Marca: ${veiculo.marca}',
                      style: const TextStyle(fontSize: 18)),
                  Text('Modelo: ${veiculo.modelo}',
                      style: const TextStyle(fontSize: 18)),
                  Text('Ano de Fabricação: ${veiculo.anoFabricacao}',
                      style: const TextStyle(fontSize: 18)),
                  Text('Placa: ${veiculo.placa}',
                      style: const TextStyle(fontSize: 18)),
                  Text('Cor: ${veiculo.cor}',
                      style: const TextStyle(fontSize: 18)),
                  Text('Quilometragem: ${veiculo.quilometragem}',
                      style: const TextStyle(fontSize: 18)),
                  Text('Automático: ${veiculo.automatico ? "Sim" : "Não"}',
                      style: const TextStyle(fontSize: 18)),
                  Text(
                      'Disponível para Aluguel: ${veiculo.disponivelParaAluguel ? "Sim" : "Não"}',
                      style: const TextStyle(fontSize: 18)),
                  Text(
                      'Adaptado para PCD: ${veiculo.adaptadoParaPCD ? "Sim" : "Não"}',
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
