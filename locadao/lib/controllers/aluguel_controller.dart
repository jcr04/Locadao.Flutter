import 'package:locadao/services/api_services_aluguel.dart';
import 'package:locadao/models/aluguel.dart';

class AluguelController {
  final ApiServicesAluguel _apiService = ApiServicesAluguel();

  Future<List<Aluguel>> getAlugueisDisponiveis() async {
    return await _apiService.getAlugueisDisponiveis();
  }

  Future<Aluguel> fetchAluguelById(String id) async {
    return await _apiService.fetchAluguelById(id);
  }

  Future<Aluguel> createAluguel(Aluguel aluguel) async {
    return await _apiService.createAluguel(aluguel);
  }

  Future<void> deleteAluguel(String id) async {
    await _apiService.deleteAluguel(id);
  }
}
