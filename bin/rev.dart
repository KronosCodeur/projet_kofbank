void main() {
  Compte c1 = Compte();
  Compte c2 = Compte();
  c1.afficher();
  c2.afficher();

  c1.deposer(500);
  c2.deposer(1000);
  c2.retirer(10);
  c1.virerVers(75, c2);

  c1.afficher();
  c2.afficher();

  List<Compte> listCompte = [];
  for (int index = 0; index < 10; index++) {
    Compte c1 = Compte();
    c1.solde = (300 + index * 100);
    listCompte.add(c1);
  }

  for (Compte account in listCompte) {
    account.afficher();
  }
  for (int index = 0; index < listCompte.length; index++) {
    if (index == 9) {
      break;
    }
    for (int index1 = index + 1; index1 < listCompte.length; index1++) {
      listCompte[index].virerVers(20, listCompte[index1]);
    }
  }
  for (Compte account in listCompte) {
    account.afficher();
  }
}

class Compte {
  int solde = 0;
  void deposer(int montant) {
    solde = solde + montant;
  }

  void retirer(int montant) {
    solde = solde - montant;
  }

  void virerVers(int montant, Compte destination) {
    retirer(montant);
    destination.deposer(montant);
  }

  afficher() {
    print("solde: $solde");
  }
}
