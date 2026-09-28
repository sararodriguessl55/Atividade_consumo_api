import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/endereco.dart';

class ViaCepService {
  static const String _baseUrl = 'https://viacep.com.br/ws';

  Future<Endereco> buscarCep(String cep) async {
    final cepLimpo = cep.replaceAll(RegExp(r'[^0-9]'), '');

    if (cepLimpo.length != 8) {
      throw Exception('O CEP deve conter exatamente 8 dígitos.');
    }

    final url = Uri.parse('$_baseUrl/$cepLimpo/json/');

    try {
      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(resposta.body);

        if (json.containsKey('erro') && json['erro'] == true) {
          throw Exception('CEP não encontrado na base de dados.');
        }

        return Endereco.fromJson(json);
      } else {
        throw Exception(
          'Erro de servidor. Código HTTP: ${resposta.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('Falha de conexão com a internet.');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> salvarEmArquivo(Endereco endereco) async {
    final arquivo = File('ultimo_endereco.txt');
    final conteudo = '''
--- Endereço Consultado ---
CEP: ${endereco.cep}
Logradouro: ${endereco.logradouro}
Bairro: ${endereco.bairro}
Cidade/UF: ${endereco.localidade}/${endereco.uf}
DDD: ${endereco.ddd}
''';

    await arquivo.writeAsString(conteudo);
    print(
      '\n[BÔNUS] Endereço salvo com sucesso no arquivo "ultimo_endereco.txt"!',
    );
  }
}
