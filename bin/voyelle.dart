import 'dart:io';

void main() {
  String value;
  print("Veuillez entrez une phrase");
  value = stdin.readLineSync().toString();
  print(countVoyelle(value));
}

countVoyelle(String string) {
  int count = 0;
  for (int index = 0; index < string.length; index++) {
    if ("aeiuyoAEIUYO".contains(string[index])) {
      count++;
    }
  }
  return count;
}
