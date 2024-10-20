import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:locadao/models/aluguel.dart';

class ApiServicesAluguel {
  final String baseUrl = 'https://locadaov3.onrender.com/api';

  Future<List<Aluguel>> getAlugueisDisponiveis() async {
    final response = await http.get(Uri.parse('$baseUrl/Alugueis'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Aluguel> alugueis =
          body.map((dynamic item) => Aluguel.fromJson(item)).toList();
      if (kDebugMode) {
        print('Aluguéis carregados: $alugueis');
      }
      return alugueis;
    } else {
      if (kDebugMode) {
        print('Erro ao carregar aluguéis: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Corpo da resposta: ${response.body}');
      }
      throw Exception('Falha ao carregar os aluguéis');
    }
  }

  Future<Aluguel> fetchAluguelById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/Alugueis/$id'));

    if (response.statusCode == 200) {
      return Aluguel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Aluguel não encontrado');
    }
  }

  Future<Aluguel> createAluguel(Aluguel aluguel) async {
    String requestBody = jsonEncode(aluguel.toJson());

    if (kDebugMode) {
      print('Enviando dados do aluguel: $requestBody');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/Alugueis'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBody,
    );

    if (response.statusCode == 201) {
      return Aluguel.fromJson(jsonDecode(response.body));
    } else {
      if (kDebugMode) {
        print('Erro ao criar o aluguel: ${response.statusCode}');
        print('Resposta do servidor: ${response.body}');
      }
      throw Exception('Falha ao criar o aluguel');
    }
  }

  Future<void> deleteAluguel(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/Alugueis/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao deletar o aluguel');
    }
  }
}
