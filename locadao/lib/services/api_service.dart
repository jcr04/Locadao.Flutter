import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locadao/models/AgenciaDetalhes.dart';
import 'package:locadao/models/Veiculo.dart';
import 'package:locadao/models/VeiculoDetalhes.dart';
import '../models/agencia.dart';

class ApiService {
  final String baseUrl = 'https://localhost:7276/api';

  Future<List<Agencia>> getAgencias() async {
    final response = await http.get(Uri.parse('$baseUrl/Agencia'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Agencia.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar agências');
    }
  }

  Future<Agencia> getAgenciaById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/Agencia/$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return Agencia.fromJson(body);
    } else {
      throw Exception('Falha ao carregar agência');
    }
  }

  Future<List<AgenciaDetalhes>> getAgenciasDetalhes() async {
    // Passo 1: Obtenha os IDs de todas as agências
    final guidsResponse = await http.get(Uri.parse('$baseUrl/Agencia'));

    if (guidsResponse.statusCode != 200) {
      throw Exception('Falha ao carregar os GUIDs das agências');
    }

    List<dynamic> guids = jsonDecode(guidsResponse.body);

    // Passo 2: Para cada GUID, buscar os detalhes da agência
    List<AgenciaDetalhes> agenciasDetalhes = [];
    for (var id in guids) {
      final detalhesResponse =
          await http.get(Uri.parse('$baseUrl/Agencia/${id.toString()}'));

      if (detalhesResponse.statusCode == 200) {
        var body = jsonDecode(detalhesResponse.body);
        AgenciaDetalhes detalhes = AgenciaDetalhes.fromJson(body);
        agenciasDetalhes.add(detalhes);
      } else {
        throw Exception('Falha ao carregar detalhes da agência com ID: $id');
      }
    }

    return agenciasDetalhes;
  }

  Future<String> createAgencia(Agencia agencia) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Agencia'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nome': agencia.nome,
        'endereco': agencia.endereco,
        'telefone': agencia.telefone,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['id'];
    } else {
      throw Exception('Falha ao criar agência');
    }
  }

  Future<void> updateAgencia(String id, Agencia agencia) async {
    final response = await http.put(
      Uri.parse('$baseUrl/Agencia/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nome': agencia.nome,
        'endereco': agencia.endereco,
        'telefone': agencia.telefone,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar agência');
    }
  }

  Future<void> deleteAgencia(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/Agencia/$id'));

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar agência');
    }
  }

  //----------------------------------Veiculo-----------------------------------

  Future<List<Veiculo>> getVeiculosDisponiveis() async {
    final response = await http.get(Uri.parse('$baseUrl/Veiculos'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Veiculo.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar veículos');
    }
  }

  Future<VeiculoDetalhes> getVeiculoById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/Veiculos/$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return VeiculoDetalhes.fromJson(body);
    } else {
      throw Exception('Falha ao carregar veículo');
    }
  }

  Future<String> createVeiculo(VeiculoDetalhes veiculo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Veiculos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(veiculo.toJson()),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['id'];
    } else {
      throw Exception('Falha ao criar veículo');
    }
  }

  Future<void> updateVeiculo(String id, VeiculoDetalhes veiculo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/Veiculos/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(veiculo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar veículo');
    }
  }

  Future<void> deleteVeiculo(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/Veiculos/$id'));

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar veículo');
    }
  }
}
