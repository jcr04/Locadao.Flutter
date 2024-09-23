import 'package:locadao/models/Cliente.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServicesClientes {
  final String baseUrl = 'https://localhost:7276/api';

  Future<List<Cliente>> getClientesDisponiveis() async {
    final response = await http.get(Uri.parse('$baseUrl/Clientes'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Cliente> clientes =
          body.map((dynamic item) => Cliente.fromJson(item)).toList();
      return clientes;
    } else {
      throw Exception('Falha ao carregar os clientes');
    }
  }

  Future<Cliente> getClienteById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/Clientes/$id'));

    if (response.statusCode == 200) {
      return Cliente.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Cliente não encontrado');
    }
  }

  Future<Cliente> createCliente(Cliente cliente) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Clientes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(cliente.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Cliente.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao criar o cliente');
    }
  }

  Future<void> updateCliente(String id, Cliente cliente) async {
    final response = await http.put(
      Uri.parse('$baseUrl/Clientes/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(cliente.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar o cliente');
    }
  }

  Future<void> deleteCliente(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/Clientes/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar o cliente');
    }
  }
}
