import 'compte.dart';

class Client {
  String nom;
  String prenom;
  DateTime dateNaiss;
  String telephone;
  String mail;
  Compte compte;

  Client(this.nom, this.prenom, this.dateNaiss, this.telephone, this.mail,
      this.compte);

  @override
  String toString() {
    return 'Client{nom: $nom, prenom: $prenom, dateNaiss: ${dateNaiss.toString().substring(0, 10)}, telephone: $telephone, mail: $mail, compte: $compte}';
  }

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'prenom': prenom,
        'dateNaiss': dateNaiss.toString(),
        'telephone': telephone,
        'mail': mail,
        'compte': compte.toJson()
      };

  static Client fromJson(Map<String, dynamic> json) => Client(
        json['nom'],
        json['prenom'],
        DateTime.parse(json['dateNaiss']),
        json['telephone'],
        json['mail'],
        Compte.fromJson(json['compte']),
      );
}
