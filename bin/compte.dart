import 'type_compte.dart';

class Compte {
  String numCpt;
  double solde;
  DateTime dateCreation;
  AccountType accountType;

  Compte(this.numCpt, this.solde, this.dateCreation, this.accountType);

  @override
  String toString() {
    return 'Compte{numCpt: $numCpt, solde: $solde, dateCreation: $dateCreation, accountType: $accountType}';
  }

  Map<String, dynamic> toJson() => {
        'numCpt': numCpt,
        'solde': solde,
        'dateCreation': dateCreation.toString(),
        'accountType': accountType.toString()
      };

  static Compte fromJson(Map<String, dynamic> json) => Compte(
        json['numCpt'],
        json['solde'],
        DateTime.parse(json['dateCreation']),
        json['accountType'] == 'AccountType.epargne'
            ? AccountType.epargne
            : AccountType.courant,
      );

  makeDeposit(double montant) {
    solde += montant;
  }

  withdraw(double montant) {
    if (solde < montant) {
      return false;
    } else {
      solde -= montant;
      return true;
    }
  }

  makeTransfer(Compte compteDestinataire, double montant) {
    if (withdraw(montant)) {
      compteDestinataire.makeDeposit(montant);
      return true;
    } else {
      return false;
    }
  }
}
