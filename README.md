# Consulta de Endereço via CEP (ViaCEP)

**Integrantes:** Sara Souza Rodrigues
**Disciplina:** Programação para Dispositivos Móveis
**API Escolhida:** ViaCEP (`https://viacep.com.br/ws/`)

---

## Descrição da Aplicação
Aplicação em linha de comando desenvolvida em Dart puro para consultar endereços das Cidades do Brasil através do CEP informado pelo usuário.

---

## Endpoints Utilizados
* `GET https://viacep.com.br/ws/{cep}/json/` — Retorna as informações do endereço formatadas em JSON.

---

## Instruções de Instalação e Execução

1. Baixe ou clone o repositório.
2. No terminal, instale as dependências:
   ```bash
   dart pub get