# language: pt

Funcionalidade: Pesquisar Funcionarios
    Para averiguar informacoes
    O usuario do sistema
    Deseja poder consultar informacoes dos Funcionarios

    Cenario: Buscar informacoes de funcionario
        Dado que o usuario consulte informacoes de funcionario
        Quando ele realizar a pesquisa
        Entao uma lista de funcionarios deve retornar

    @cenario_dois
    Cenario: Cadastrar funcionario
        Dado que o usuario cadastre um novo funcionario
        Quando ele enviar as informacoes do funcionario
        Entao esse funcionario sera cadastrado