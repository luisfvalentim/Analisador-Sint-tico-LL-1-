class Token {
  final String value;
  Token(this.value);
}

List<Token> tokenize(String input) {
  List<String> tokenStrings = input.trim().split(' ');
  return tokenStrings.map((token) => Token(token)).toList();
}
