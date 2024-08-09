# Analisador Sintático LL(1)

Este projeto é uma implementação de um analisador sintático LL(1) em Dart. O analisador utiliza uma tabela de análise LL(1) definida em um arquivo CSV para analisar uma entrada e determinar se a entrada está de acordo com a gramática especificada.

# Estrutura do Projeto

1. **lexer.dart**: Define a classe Token e a função tokenize para dividir a entrada em tokens.
2. **parser.dart**: Define as classes LL1Entry, LL1Table e as funções loadTable e parseInput para carregar a tabela de análise e realizar a análise sintática.
3. **interpreter.dart**: Define a classe LL1Interpreter que orquestra a execução do analisador sintático.
4. **main.dart**: Ponto de entrada do programa, responsável por receber os arquivos de entrada e tabela de análise, e executar o interpretador.

# Uso

**Pré-requisitos**

Dart SDK instalado.

**Execução**

dart run bin/main.dart assets/tabela.csv assets/entrada.txt
