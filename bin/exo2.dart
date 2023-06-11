import 'dart:io';
import 'dart:math';

void main() {
  int n = 0;
  int min = 1;
  int max = 1;
  String value;
  do {
    print("Veuillez entrez une nombre entier n");
    value = stdin.readLineSync().toString();
  } while (!valueIsValidNumber(value));
  n = int.parse(value);
  do {
    print("Veuillez entrez une nombre entier min");
    value = stdin.readLineSync().toString();
  } while (!valueIsValidNumber(value));
  min = int.parse(value);
  do {
    print("Veuillez entrez une nombre entier max");
    value = stdin.readLineSync().toString();
  } while (!valueIsValidNumber(value) || int.parse(value) < min);
  max = int.parse(value);
  print(buildRandomList(n, min, max));
}
valueIsValidNumber(String value) {
  try {
    int number = int.parse(value);
    if (number >= 0) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
intConverter(String value) {
  return int.parse(value);
}
List<int> buildRandomList(int n, int min, int max) {
  Random random = new Random();
  List<int> listOfRandomNumber = [];
  while (listOfRandomNumber.length < n) {
    listOfRandomNumber.add(random.nextInt(max - min + 1) + min);
  }
  return listOfRandomNumber;
}
