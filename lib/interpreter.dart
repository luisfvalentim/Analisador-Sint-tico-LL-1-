import 'dart:io';
import 'parser.dart';

class LL1Interpreter {
  final LL1Table table;

  LL1Interpreter(this.table);

  bool execute(String inputFile) {
    String input;
    try {
      input = File(inputFile).readAsStringSync();
    } catch (e) {
      print("Erro: Não foi possível abrir o arquivo de entrada '$inputFile'.");
      return false;
    }

    return parseInput(input, table);
  }
}

bool runLL1Interpreter(String tableCsv, String inputFile) {
  LL1Table? table = loadTable(tableCsv);
  if (table == null) {
    print('Erro: Não foi possível carregar a tabela de análise.');
    return false;
  }

  LL1Interpreter interpreter = LL1Interpreter(table);
  return interpreter.execute(inputFile);
}
