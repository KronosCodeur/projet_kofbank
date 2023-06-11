void main() {
  print(combinInList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 7));
}

combinInList(List<int> list, int theSum) {
  List newlist = [];
  for (int index = 0; index < list.length - 1; index++) {
    for (int index1 = index + 1; index1 < list.length; index1++) {
      if ((list[index] + list[index1]) == theSum) {
        newlist.add([list[index], list[index1]]);
      }
    }
  }
  return newlist;
}
