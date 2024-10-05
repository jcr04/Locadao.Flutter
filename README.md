# Locadão

Locadão é uma aplicação desenvolvida em Flutter para gerenciamento de locação de veículos. O projeto tem como objetivo facilitar e otimizar o processo de aluguel, permitindo que agências, clientes, veículos e aluguéis sejam gerenciados de forma integrada e eficiente.

## Índice

- [Funcionalidades](#funcionalidades)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Arquitetura do Projeto](#arquitetura-do-projeto)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Uso](#uso)

## Funcionalidades

- **Gerenciamento de Clientes**: Cadastro, atualização, listagem e exclusão de clientes.
- **Gerenciamento de Veículos**: Cadastro, atualização, listagem e exclusão de veículos disponíveis para locação.
- **Gerenciamento de Agências**: Cadastro, atualização, listagem e exclusão de agências de locação.
- **Gerenciamento de Aluguéis**: Criação, visualização e gerenciamento de aluguéis de veículos.
- **Integração com Backend**: Comunicação com uma API desenvolvida em ASP.NET Core para persistência de dados.
- **Interface Intuitiva**: UI amigável e fácil de navegar, proporcionando uma melhor experiência ao usuário.

## Tecnologias Utilizadas

- **Frontend**: Flutter (Dart)
- **Backend**: ASP.NET Core Web API (C#)
- **Banco de Dados**: PostgreSQL
- **Gerenciamento de Estado**: SetState (padrão do Flutter)
- **Comunicação HTTP**: Biblioteca `http` para requisições RESTful

## Arquitetura do Projeto

- **models/**: Contém as classes de modelo que representam as entidades do sistema (Cliente, Veículo, Agência, Aluguel).
- **controllers/**: Controladores que gerenciam a lógica de negócio e comunicação entre as views e os serviços.
- **services/**: Serviços que realizam as requisições HTTP para a API backend.
- **views/**: Telas da aplicação, incluindo formulários de cadastro, listagens e detalhes.
- **widgets/**: Componentes reutilizáveis da interface do usuário.
- **assets/**: Recursos estáticos como imagens e fontes.
- **main.dart**: Ponto de entrada da aplicação Flutter.

## Pré-requisitos

- **Flutter SDK**: Versão 2.0 ou superior
- **Dart SDK**: Compatível com a versão do Flutter instalado
- **Backend em ASP.NET Core**: Projeto backend configurado e em execução
- **PostgreSQL**: Banco de dados configurado e acessível pelo backend
- **Git**: Para clonar o repositório
- **Editor de Código**: VSCode, Android Studio ou outro de sua preferência

## Instalação

1. **Clone o repositório**

   ``bash
   git clone https://github.com/seu-usuario/locadao-flutter.git
   ``
2. **Navegue até o diretório do projeto**
    ``
    cd locadao-flutter/locadao
    ``
3. **Instale as dependências**

    ``
    flutter pub get
    ``
## Uso

- **Tela Inicial**
- Ao abrir o aplicativo, você será direcionado à tela principal, onde poderá navegar entre as opções de gerenciamento.
- **Gerenciamento de Clientes**
- Acesse a seção de clientes para visualizar.
- **Gerenciamento de Veículos**
- Na seção de veículos, é possível cadastrar novos veículos, bem como adicionar veiculos á uma agência.
- **Gerenciamento de Agências**
- Cadastre novas agências ou gerencie as já existentes.
- **Processo de Aluguel**
- Utilize a opção de criar aluguel para registrar um novo aluguel, selecionando o cliente, veículo e agência, além de informar as datas e o valor.
- **Validações**
- O aplicativo conta com validações nos formulários para garantir a integridade dos dados inseridos.