import 'package:analisador_sintatico_ll_1/interpreter.dart';

void main(List<String> args) {
  if (args.length != 2) {
    print('Uso: dart main.dart <arquivo_tabela_csv> <arquivo_entrada>');
    return;
  }

  String tableCsv = args[0];
  String inputFile = args[1];

  bool success = runLL1Interpreter(tableCsv, inputFile);
  if (success) {
    print('\n');
    print('---------------------------------------------------------------');
    print('Entrada aceita com sucesso.');
    print('---------------------------------------------------------------');
    print('\n');
  } else {
    print('Entrada não aceita, ocorreu um erro.');
    print('---------------------------------------------------------------');
    print('\n');
  }
}
