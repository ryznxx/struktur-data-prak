import 'dart:io';

// memori safer
Map<String, int> caching = {};

int pascal(int row, int col) {
  if (col == 0 || col == row) return 1;

  String key = '$row,$col';
  if (caching.containsKey(key)) return caching[key]!;

  return caching[key] = pascal(row - 1, col - 1) + pascal(row - 1, col);
}

void printPascal(int numRows) {
  List<List<int>> segitiga =
      List.generate(numRows, (i) => List.filled(i + 1, 1));

  for (int i = 2; i < numRows; i++) {
    for (int j = 1; j < i; j++) {
      segitiga[i][j] = segitiga[i - 1][j - 1] + segitiga[i - 1][j];
    }
  }

  for (var row in segitiga) {
    stdout.write(' ' * (numRows - row.length));
    stdout.writeln(row.join(' '));
  }
}

void main() {
  int numRows = 10;
  printPascal(numRows);
}
