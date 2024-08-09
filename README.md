# Analisador LL(1) em Dart

Este projeto é um analisador LL(1) implementado em Dart. O analisador verifica se uma entrada é aceita ou rejeitada com base em uma tabela de análise LL(1) definida em um arquivo CSV.

## Estrutura do Projeto

- **`parser.dart`**: Implementa a lógica do analisador LL(1) e o carregamento da tabela de análise.
- **`lexer.dart`**: Contém a função de tokenização da entrada.
- **`interpreter.dart`**: Executa o analisador LL(1) usando a tabela e o arquivo de entrada.
- **`main.dart`**: Ponto de entrada para a execução do analisador.
- **`entrada.txt`**: Arquivo de texto que contém a expressão a ser analisada pelo analisador LL(1). Este arquivo deve ser fornecido ao executar o programa para verificar se a entrada é aceita ou rejeitada.
- **`tabela.csv`**: Arquivo CSV que define a tabela de análise LL(1). Contém as produções da gramática e é usado pelo analisador para determinar a aceitação ou rejeição da entrada.

## Gramática

A gramática usada no analisador LL(1) é:

```
E  -> T E'
E' -> + T E' | - T E' | ε
T  -> F T'
T' -> * F T' | ε
F  -> ( E ) | id
```

## Tabela de Análise LL(1)

A tabela LL(1) para a gramática é a seguinte:

| Não Terminal | Terminal | Produção   |
|--------------|----------|------------|
| E            | (        | T E'       |
| E            | id       | T E'       |
| E'           | +        | + T E'     |
| E'           | -        | - T E'     |
| E'           | $        | ε          |
| T            | (        | F T'       |
| T            | id       | F T'       |
| T'           | +        | ε          |
| T'           | -        | ε          |
| T'           | *        | * F T'     |
| T'           | $        | ε          |
| F            | (        | ( E )      |
| F            | id       | id         |

## Conjunto FIRST e FOLLOW

| Produção       | FIRST                | FOLLOW               |
|----------------|----------------------|----------------------|
| E -> T E'      | { (, id }            | { $, ) }             |
| E' -> + T E'   | { +, -, ε }          | { $, ), +, - }       |
| E' -> - T E'   |                      |                      |
| E' -> ε        |                      |                      |
| T -> F T'      | { (, id }            | { +, -, $, ) }       |
| T' -> * F T'   | { *, ε }             | { +, -, $, ) }       |
| T' -> ε        |                      |                      |
| F -> ( E )     | { (, id }            | { *, +, -, $, ) }    |
| F -> id        |                      |                      |

## Execução

Para executar o analisador LL(1), utilize o seguinte comando:

```
dart run bin/main.dart assets/tabela.csv assets/entrada.txt
```

# Exemplos

## Exemplo Aceito

#### Arquivo de Entrada: `entrada.txt`


```
id + id * id
```

#### Saída 

```
Entrada aceita com sucesso.
```

## Exemplo Rejeitado

#### Arquivo de Entrada: entrada.txt

```
id + id * 
```

#### Saída

```
Erro: Produção não encontrada para 'F' com '$'
O símbolo '$' é usado como marcador para indicar o final da entrada
Esperava mais símbolos após o '*'

Entrada não aceita, ocorreu um erro.
```
