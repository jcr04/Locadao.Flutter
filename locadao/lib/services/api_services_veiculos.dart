import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:locadao/models/Veiculo.dart';
import 'package:locadao/models/VeiculoDetalhes.dart';

class ApiServicesVeiculos {
  final String baseUrl = 'https://localhost:7276/api';

  Future<List<Veiculo>> getVeiculosDisponiveis() async {
    if (kDebugMode) {
      print('Iniciando requisição para obter veículos');
    }
    final response = await http.get(Uri.parse('$baseUrl/Veiculos'));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Requisição bem-sucedida: ${response.body}');
      }
      List<dynamic> ids = jsonDecode(response.body);

      if (ids.isNotEmpty && ids[0] is String) {
        List<Veiculo> veiculos = [];
        for (String id in ids) {
          final detalhesResponse =
              await http.get(Uri.parse('$baseUrl/Veiculos/$id'));

          if (detalhesResponse.statusCode == 200) {
            var body = jsonDecode(detalhesResponse.body);

            var veiculoJson =
                body.containsKey('veiculo') ? body['veiculo'] : body;

            veiculos.add(Veiculo.fromJson(veiculoJson));
          } else {
            throw Exception(
                'Falha ao carregar detalhes do veículo com ID: $id');
          }
        }
        return veiculos;
      } else {
        return ids.map((item) {
          var veiculoJson =
              item.containsKey('veiculo') ? item['veiculo'] : item;
          return Veiculo.fromJson(veiculoJson);
        }).toList();
      }
    } else {
      if (kDebugMode) {
        print('Falha ao carregar veículos: ${response.statusCode}');
      }
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
