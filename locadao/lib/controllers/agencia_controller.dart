import 'package:locadao/services/api_services_agencias.dart';
import 'package:locadao/models/agenciadetalhes.dart';
import '../models/agencia.dart';

class AgenciaController {
  final ApiServicesAgencias _apiService = ApiServicesAgencias();

  Future<List<Agencia>> getAgencias() async {
    return await _apiService.getAgencias();
  }

  Future<Agencia> getAgenciaById(String id) async {
    return await _apiService.getAgenciaById(id);
  }

  Future<String> createAgencia(Agencia agencia) async {
    return await _apiService.createAgencia(agencia);
  }

  Future<void> updateAgencia(String id, Agencia agencia) async {
    await _apiService.updateAgencia(id, agencia);
  }

  Future<void> deleteAgencia(String id) async {
    await _apiService.deleteAgencia(id);
  }

  Future<List<AgenciaDetalhes>> getAgenciasDetalhes() async {
    return await _apiService.getAgenciasDetalhes();
  }
}
