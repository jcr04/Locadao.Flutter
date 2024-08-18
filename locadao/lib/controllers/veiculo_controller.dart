import 'package:locadao/services/api_services_veiculos.dart';
import 'package:locadao/models/Veiculo.dart';
import 'package:locadao/models/VeiculoDetalhes.dart';

class VeiculoController {
  final ApiServicesVeiculos _apiService = ApiServicesVeiculos();

  Future<List<Veiculo>> getVeiculosDisponiveis() async {
    return await _apiService.getVeiculosDisponiveis();
  }

  Future<VeiculoDetalhes> getVeiculoById(String id) async {
    return await _apiService.getVeiculoById(id);
  }

  Future<String> createVeiculo(VeiculoDetalhes veiculo) async {
    return await _apiService.createVeiculo(veiculo);
  }

  Future<void> updateVeiculo(String id, VeiculoDetalhes veiculo) async {
    await _apiService.updateVeiculo(id, veiculo);
  }

  Future<void> deleteVeiculo(String id) async {
    await _apiService.deleteVeiculo(id);
  }
}
