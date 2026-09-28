class Endereco {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ddd;

  Endereco({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ddd,
  });

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      cep: json['cep'] ?? '',
      logradouro: json['logradouro'] ?? 'Não informado',
      complemento: json['complemento'] ?? '',
      bairro: json['bairro'] ?? 'Não informado',
      localidade: json['localidade'] ?? 'Não informado',
      uf: json['uf'] ?? '',
      ddd: json['ddd'] ?? '',
    );
  }
}
