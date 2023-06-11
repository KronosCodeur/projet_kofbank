import 'dart:io';

void main() {
  print("entrez une phrase:");
  String phrase = stdin.readLineSync().toString();
  print("Voici votre phrase :${convertMaj(phrase)}");
  print("Voici votre phrase :${showLong(phrase)}");
  print("Voici votre phrase :${convertVoyelle(phrase)}");
}

convertMaj(String string) {
  if (string.endsWith(" ")) {
    string = string.substring(0, string.length - 1);
  }
  List<String> list = string.split(" ");
  String majString = "";
  for (var element in list) {
    majString += " " +
        element.substring(0, 1).toUpperCase() +
        element.substring(1, element.length);
  }
  return majString.substring(1, majString.length);
}

showLong(String string) {
  List list = string.split(" ");
  String longString = " ";
  for (String word in list) {
    if (word.length > longString.length) {
      longString = word;
    }
  }
  return longString;
}

String convertVoyelle(String word) {
  String resultat = '';
  for (int i = 0; i < word.length; i++) {
    if ('aeiouy'.contains(word[i])) {
      resultat += word[i].toUpperCase();
    } else {
      resultat += word[i];
    }
  }
  return resultat;
}
