import 'dart:io';

void main() {
  int n = 0;
  String value;
  do {
    print("Veuillez entrez une nombre entier n");
    value = stdin.readLineSync().toString();
  } while (!valueIsValidNumber(value));
  n = int.parse(value);
  print(fibonacci(n));
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

List<int> fibonacci(int n) {
  List<int> listOfFibNumbers = [];
  if (n == 0) {
    return listOfFibNumbers;
  }
  listOfFibNumbers.add(0);
  if (n == 1) {
    return listOfFibNumbers;
  }
  listOfFibNumbers.add(1);
  if (n == 2) {
    return listOfFibNumbers;
  }
  for (int i = 2; i < n; i++) {
    int next = listOfFibNumbers[i - 1] + listOfFibNumbers[i - 2];
    listOfFibNumbers.add(next);
  }
  return listOfFibNumbers;
}
