import 'dart:io';
import 'lexer.dart';

class LL1Entry {
  final String nonTerminal;
  final String terminal;
  final String production;

  LL1Entry(this.nonTerminal, this.terminal, this.production);
}

class LL1Table {
  final List<LL1Entry> entries = [];

  void addEntry(String nonTerminal, String terminal, String production) {
    entries.add(LL1Entry(nonTerminal, terminal, production));
  }
}

LL1Table? loadTable(String csvFile) {
  LL1Table table = LL1Table();

  try {
    List<String> lines = File(csvFile).readAsLinesSync();
    for (String line in lines) {
      List<String> parts = line.split(',');
      if (parts.length == 3) {
        table.addEntry(parts[0].trim(), parts[1].trim(), parts[2].trim());
      }
    }
  } catch (e) {
    print('\n');
    print('---------------------------------------------------------------');
    print("Erro: Não foi possível abrir o arquivo CSV '$csvFile'.");
    print('---------------------------------------------------------------');
    return null;
  }

  return table;
}

bool parseInput(String input, LL1Table table) {
  List<Token> tokens = tokenize(input);
  tokens.add(Token('\$')); 

  List<String> stack = ['\$'];
  stack.add(table.entries[0].nonTerminal); 

  int inputIndex = 0;

  while (stack.isNotEmpty) {
    String stackTopSymbol = stack.removeLast();

    if (stackTopSymbol == '\$') {
      if (inputIndex == tokens.length - 1) {
        return true;
      } else {
        print('\n');
        print('---------------------------------------------------------------');
        print('Erro: Entrada não consumida completamente.');
        while (inputIndex < tokens.length - 1) {
          print('Símbolos restantes: ${tokens[inputIndex++].value} ');
        }
        print('---------------------------------------------------------------');
        return false;
      }
    }

    if (inputIndex < tokens.length && stackTopSymbol == tokens[inputIndex].value) {
      inputIndex++;
    } else {
      LL1Entry? productionEntry;
      for (LL1Entry entry in table.entries) {
        if (entry.nonTerminal == stackTopSymbol &&
            entry.terminal == tokens[inputIndex].value) {
          productionEntry = entry;
          break;
        }
      }

      if (productionEntry == null) {
        print('\n');
        print('---------------------------------------------------------------');
        print("Erro: Produção não encontrada para '$stackTopSymbol' com '${tokens[inputIndex].value}'");
        if (inputIndex > 0) {
          print("O símbolo '${tokens[inputIndex].value}' é usado como marcador para indicar o final da entrada");
          print("Esperava mais símbolos após o '${tokens[inputIndex - 1].value}'");
        }
        print('---------------------------------------------------------------');
        return false;
      }

      List<String> symbols = productionEntry.production.split(' ');
      for (int i = symbols.length - 1; i >= 0; i--) {
        if (symbols[i] != 'ε') {
          stack.add(symbols[i]);
        }
      }
    }
  }

  print('Erro: A entrada foi rejeitada.');
  print('---------------------------------------------------------------');
  return false;
}
