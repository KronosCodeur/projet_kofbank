import 'dart:convert';
import 'dart:io';
import 'dart:math';

import "package:intl/intl.dart" show DateFormat;

import 'client.dart';
import 'compte.dart';
import 'type_compte.dart';

void main(List<String> arguments) async {
  var file = File('clients.json');
  if (!await file.exists()) {
    await file.create();
  }
  var contents = await file.readAsString();
  var jsonList =
      contents.isNotEmpty ? json.decode(contents) as List<dynamic> : [];
  var listOfAllClients =
      jsonList.map((e) => Client.fromJson(e as Map<String, dynamic>)).toList();
  do {
    operation(listOfAllClients);
  } while (wantToContinue());
  var outputJson =
      json.encode(listOfAllClients.map((e) => e.toJson()).toList());
  await file.writeAsString(outputJson);
}

void showMenu() {
  print("---------------KOFBANK---------------");
  print("1-Ajouter un client");
  print("2-Liste des Clients");
  print("3-Faire un dépot");
  print("4-Faire un retrait");
  print("5-Transférer de l'argent\n");
  print(DateTime.now().hour < 12
      ? "Bonjour, " "Quelle opération voulez-vous effectuer?"
      : "Bonsoir, " "Quelle opération voulez-vous effectuer?");
}

showListOfAllClients(List listOfAllClients) {
  if (listOfAllClients.isNotEmpty) {
    print(
        "Vous avez ${listOfAllClients.length} Client(s) Enrégistré à ce jour:");
    for (var client in listOfAllClients) {
      print(client.toString());
    }
  } else {
    print("Vous n'avez aucun Client Enrégistré a ce jour");
  }
}

void update(Client newClient, List listOfAllClients) {
  for (var client in listOfAllClients) {
    if (client.compte.numCpt == newClient.compte.numCpt) {
      client = newClient;
    }
  }
}

void saveClient(List listOfAllClients) {
  print("Veuillez entrez le nom du Client");
  String nom = stdin.readLineSync().toString();
  print("Veuillez entrez le prenom du Client");
  String prenom = stdin.readLineSync().toString();
  print(
      "Veuillez entrez la Date de Naissance du Client sous ce format 'jj/mm/aaaa'");
  DateTime dateNaiss = DateTime.now();
  try {
    DateFormat format = DateFormat("dd/MM/yyyy");
    String date = stdin.readLineSync().toString().replaceAll("-", "/");
    dateNaiss = format.parse(date);
  } catch (e) {
    print(e);
  }
  print("Veuillez entrez le numero de Telephone du Client");
  String telephone = stdin.readLineSync().toString();
  print("Veuillez entrez le mail du Client");
  String mail = stdin.readLineSync().toString();
  String accountNumber = buildAccountNumber(nom, prenom);
  AccountType accountType = chooseAccountType();
  Client client = Client(nom, prenom, dateNaiss, telephone, mail,
      saveAccount(accountNumber, accountType));
  listOfAllClients.add(client);
  print("Voici le numero de compte du Client $nom est: $accountNumber");
}

bool clientExist(String accountNumber, List listOfAllClients) {
  late bool exist;
  for (Client client in listOfAllClients) {
    if (client.compte.numCpt == accountNumber) {
      exist = true;
      break;
    } else {
      exist = false;
      continue;
    }
  }
  return exist;
}

Client searchClient(String accountNumber, List listOfAllClients) {
  late Client currentClient;
  for (var client in listOfAllClients) {
    if (client.compte.numCpt == accountNumber) {
      currentClient = client;
    }
  }
  return currentClient;
}

AccountType chooseAccountType() {
  print("Quel Type de Compte voulez vous creer?");
  print("1-Compte Courant");
  print("2-Compte Epargne");
  int choice = int.parse(stdin.readLineSync().toString());
  List listOfChoice = List.generate(2, (index) => index + 1);
  while (!listOfChoice.contains(choice)) {
    print("Choix incorrect");
    choice = int.parse(stdin.readLineSync().toString());
  }
  if (choice == 1) {
    return AccountType.courant;
  } else {
    return AccountType.epargne;
  }
}

Compte saveAccount(
  String accountNumber,
  AccountType accountType,
) {
  Compte compte = Compte(accountNumber, 0, DateTime.now(), accountType);
  return compte;
}

String buildAccountNumber(String nom, String prenom) {
  String accountNumber =
      "KOFBANK-${nom.substring(0, 1)}${prenom.substring(0, 1)}-";
  var rnd = Random();
  int randomNumber = rnd.nextInt(1000) + 1;
  return (accountNumber + randomNumber.toString()).toUpperCase();
}

int makeChoice() {
  showMenu();
  List listOfChoice = List.generate(5, (index) => index + 1);
  int choice;
  try {
    choice = int.parse(stdin.readLineSync().toString());
    while (!listOfChoice.contains(choice)) {
      print("Choix incorrect veuillez resaisir!!");
      showMenu();
      choice = int.parse(stdin.readLineSync().toString());
    }
    return choice;
  } catch (e) {
    print(e);
    return 0;
  }
}

bool wantToContinue() {
  print("Voulez vous continuer");
  bool wantContinue = true;
  print("1-Oui");
  print("2-Non");
  int choice = int.parse(stdin.readLineSync().toString());
  List listOfChoice = List.generate(2, (index) => index + 1);
  while (!listOfChoice.contains(choice)) {
    print("Choix incorrect");
    choice = int.parse(stdin.readLineSync().toString());
  }
  if (choice == 1) {
    wantContinue = true;
    return wantContinue;
  } else {
    wantContinue = false;
    return wantContinue;
  }
}

void operation(List listOfAllClients) {
  //makeChoice();
  switch (makeChoice()) {
    case 1:
      {
        print("*****Enrégistrement d'un Client*****");
        saveClient(listOfAllClients);
      }
      break;
    case 2:
      {
        print("*****Liste des Clients*****");
        showListOfAllClients(listOfAllClients);
      }
      break;
    case 3:
      {
        print("*****Operation de Retrait*****");
        late Client currentClient;
        print("Veuillez entrez le numéro de Compte");
        String accountNumber = stdin.readLineSync().toString();
        if (clientExist(accountNumber, listOfAllClients)) {
          currentClient = searchClient(accountNumber, listOfAllClients);
          print("Veuillez entrez le montant");
          double montant = double.parse(stdin.readLineSync().toString());
          currentClient.compte.makeDeposit(montant);
          update(currentClient, listOfAllClients);
          print("Depot effectuer avec success");
        } else {
          print("Ce numero de compte n'est pas enrégistrer.");
        }
      }
      break;
    case 4:
      {
        print("*****Operation de Retrait*****");
        late Client currentClient;
        print("Veuillez entrez le numéro de Compte");
        String accountNumber = stdin.readLineSync().toString();
        if (clientExist(accountNumber, listOfAllClients)) {
          currentClient = searchClient(accountNumber, listOfAllClients);
          print("Veuillez entrez le montant");
          double montant = double.parse(stdin.readLineSync().toString());
          if (currentClient.compte.withdraw(montant)) {
            update(currentClient, listOfAllClients);
            print("Retrait effectuer avec success");
          } else {
            print("Solde Insuffissant");
          }
        } else {
          print("Ce numero de compte n'est pas enrégistrer.");
        }
      }
      break;
    case 5:
      {
        print("*****Operation de Transfert*****");
        late Client senderClient;
        late Client receiverClient;
        late double montant;
        print("Veuillez entrez le numéro de Compte Destinataire");
        String accountNumber = stdin.readLineSync().toString();
        if (clientExist(accountNumber, listOfAllClients)) {
          senderClient = searchClient(accountNumber, listOfAllClients);
          print("Veuillez entrez le numéro de Compte Receveur");
          accountNumber = stdin.readLineSync().toString();
          if (clientExist(accountNumber, listOfAllClients)) {
            receiverClient = searchClient(accountNumber, listOfAllClients);
            print("Veuillez entrez le montant");
            montant = double.parse(stdin.readLineSync().toString());
            if (senderClient.compte
                .makeTransfer(receiverClient.compte, montant)) {
              update(senderClient, listOfAllClients);
              update(receiverClient, listOfAllClients);
              print("Transfert effectuer avec success");
            } else {
              print("solde insuffissant");
            }
          } else {
            print("Ce numero de compte n'est pas enrégistrer.");
          }
        } else {
          print("Ce numero de compte n'est pas enrégistrer.");
        }
      }
      break;
  }
}
