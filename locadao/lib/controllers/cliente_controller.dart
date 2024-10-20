import 'package:locadao/services/api_services_clientes.dart';
import 'package:locadao/models/cliente.dart';

class ClienteController {
  final ApiServicesClientes _apiService = ApiServicesClientes();

  Future<List<Cliente>> getClientesDisponiveis() async {
    return await _apiService.getClientesDisponiveis();
  }

  Future<Cliente> getClienteById(String id) async {
    return await _apiService.getClienteById(id);
  }

  Future<Cliente> createCliente(Cliente cliente) async {
    return await _apiService.createCliente(cliente);
  }

  Future<void> updateCliente(String id, Cliente cliente) async {
    await _apiService.updateCliente(id, cliente);
  }

  Future<void> deleteCliente(String id) async {
    await _apiService.deleteCliente(id);
  }
}
