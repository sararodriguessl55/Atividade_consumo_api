import 'dart:io';

import 'package:atividade_consumo_api/services/viacep_service.dart';

Future<void> main() async {
  final service = ViaCepService();
  final List<String> historico = [];
  bool executando = true;

  print('========================================');
  print('       CONSULTA DE ENDEREÇO (ViaCEP)    ');
  print('========================================');

  while (executando) {
    print('\n--- MENU ---');
    print('1 - Consultar CEP');
    print('2 - Exibir histórico de consultas');
    print('3 - Limpar histórico');
    print('0 - Sair');
    stdout.write('Escolha uma opção: ');

    final opcao = stdin.readLineSync()?.trim();

    switch (opcao) {
      case '1':
        stdout.write('\nDigite o CEP (somente números ou com hífen): ');
        final entrada = stdin.readLineSync();

        if (entrada == null || entrada.trim().isEmpty) {
          print('\nErro: Entrada vazia! Digite um CEP válido.');
          break;
        }

        try {
          print('Buscando informações...');
          final endereco = await service.buscarCep(entrada);

          print('\n--- RESULTADO DA CONSULTA ---');
          print('CEP: ${endereco.cep}');
          print('Logradouro: ${endereco.logradouro}');
          print('Bairro: ${endereco.bairro}');
          print('Cidade: ${endereco.localidade} - ${endereco.uf}');
          print('DDD: ${endereco.ddd}');

          historico.add(
            '${endereco.cep} - ${endereco.logradouro}, ${endereco.localidade}/${endereco.uf}',
          );

          stdout.write(
            '\nDeseja salvar esse resultado num arquivo .txt? (s/n): ',
          );
          final salvar = stdin.readLineSync()?.trim().toLowerCase();
          if (salvar == 's') {
            await service.salvarEmArquivo(endereco);
          }
        } catch (e) {
          print('\nNão foi possível realizar a consulta:');
          print(e.toString().replaceAll('Exception: ', ''));
        }
        break;

      case '2':
        print('\n--- HISTÓRICO DE CONSULTAS ---');
        if (historico.isEmpty) {
          print('Nenhuma consulta realizada ainda.');
        } else {
          for (var i = 0; i < historico.length; i++) {
            print('${i + 1}. ${historico[i]}');
          }
        }
        break;

      case '3':
        historico.clear();
        print('\nHistórico limpado com sucesso!');
        break;

      case '0':
        executando = false;
        print('\nPrograma encerrado. Até mais!');
        break;

      default:
        print('\nOpção inválida! Escolha um número do menu.');
        break;
    }
  }
}
