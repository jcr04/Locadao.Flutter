import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:locadao/models/AgenciaDetalhes.dart';
import '../models/agencia.dart';

class ApiServicesAgencias {
  final String baseUrl = 'https://localhost:7276/api';

  Future<List<Agencia>> getAgencias() async {
    if (kDebugMode) {
      print('Iniciando requisição para obter agências');
    }
    final response = await http.get(Uri.parse('$baseUrl/Agencia'));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Requisição bem-sucedida: ${response.body}');
      }
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Agencia.fromJson(item)).toList();
    } else {
      if (kDebugMode) {
        print('Falha ao carregar agências: ${response.statusCode}');
      }
      throw Exception('Falha ao carregar agências');
    }
  }

  Future<Agencia> getAgenciaById(String id) async {
    if (kDebugMode) {
      print('Iniciando requisição para obter agência com ID $id');
    }
    final response = await http.get(Uri.parse('$baseUrl/Agencia/$id'));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Requisição bem-sucedida: ${response.body}');
      }
      Map<String, dynamic> body = jsonDecode(response.body);
      return Agencia.fromJson(body);
    } else {
      print('Falha ao carregar agência: ${response.statusCode}');
      throw Exception('Falha ao carregar agência');
    }
  }

  Future<List<AgenciaDetalhes>> getAgenciasDetalhes() async {
    if (kDebugMode) {
      print('Iniciando requisição para obter GUIDs das agências');
    }
    final guidsResponse = await http.get(Uri.parse('$baseUrl/Agencia'));

    if (guidsResponse.statusCode != 200) {
      if (kDebugMode) {
        print('Falha ao carregar GUIDs: ${guidsResponse.statusCode}');
      }
      throw Exception('Falha ao carregar os GUIDs das agências');
    }

    List<dynamic> guids = jsonDecode(guidsResponse.body);
    if (kDebugMode) {
      print('GUIDs recebidos: $guids');
    }

    List<AgenciaDetalhes> agenciasDetalhes = [];
    for (var id in guids) {
      if (kDebugMode) {
        print('Iniciando requisição para obter detalhes da agência com ID $id');
      }
      final detalhesResponse =
          await http.get(Uri.parse('$baseUrl/Agencia/${id.toString()}'));

      if (detalhesResponse.statusCode == 200) {
        if (kDebugMode) {
          print('Detalhes da agência recebidos: ${detalhesResponse.body}');
        }
        var body = jsonDecode(detalhesResponse.body);
        AgenciaDetalhes detalhes = AgenciaDetalhes.fromJson(body);
        agenciasDetalhes.add(detalhes);
      } else {
        if (kDebugMode) {
          print(
              'Falha ao carregar detalhes da agência: ${detalhesResponse.statusCode}');
        }
        throw Exception('Falha ao carregar detalhes da agência com ID: $id');
      }
    }

    return agenciasDetalhes;
  }

  Future<String> createAgencia(Agencia agencia) async {
    if (kDebugMode) {
      print('Iniciando criação de agência com os dados: ${agencia.toJson()}');
    }
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
      if (kDebugMode) {
        print('Agência criada com sucesso: ${response.body}');
      }
      return jsonDecode(response.body)['id'];
    } else {
      if (kDebugMode) {
        print('Falha ao criar agência: ${response.statusCode}');
      }
      throw Exception('Falha ao criar agência');
    }
  }

  Future<void> updateAgencia(String id, Agencia agencia) async {
    if (kDebugMode) {
      print(
          'Iniciando atualização de agência com ID $id e dados: ${agencia.toJson()}');
    }
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

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Agência atualizada com sucesso');
      }
    } else {
      if (kDebugMode) {
        print('Falha ao atualizar agência: ${response.statusCode}');
      }
      throw Exception('Falha ao atualizar agência');
    }
  }

  Future<void> deleteAgencia(String id) async {
    if (kDebugMode) {
      print('Iniciando exclusão de agência com ID $id');
    }
    final response = await http.delete(Uri.parse('$baseUrl/Agencia/$id'));

    if (response.statusCode == 204) {
      if (kDebugMode) {
        print('Agência deletada com sucesso');
      }
    } else {
      if (kDebugMode) {
        print('Falha ao deletar agência: ${response.statusCode}');
      }
      throw Exception('Falha ao deletar agência');
    }
  }
}
