// To parse this JSON data, do
//
//     final migraeneanfall = migraeneanfallFromJson(jsonString);

import 'dart:convert';

List<Migraeneanfall> migraeneanfallListFromJson(String str) =>
    List<Migraeneanfall>.from(
        json.decode(str).map((x) => Migraeneanfall.fromJson(x)));

String migraeneanfallLIstToJson(List<Migraeneanfall> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Migraeneanfall migraeneanfallFromJson(String str) =>
    Migraeneanfall.fromJson(json.decode(str));

String migraeneanfallToJson(Migraeneanfall data) => json.encode(data.toJson());

class Migraeneanfall {
  Migraeneanfall({
    required this.id,
    required this.datum,
    required this.schmerzen,
    required this.trigger,
    required this.medikamente,
    required this.lokalisation,
    required this.hasSymptome,
  });

  int id;
  DateTime datum;
  String schmerzen;
  String trigger;
  String medikamente;
  String lokalisation;
  List<int> hasSymptome;

  Migraeneanfall.empty({
    this.id = 0,
    DateTime? datum,
    this.schmerzen = "schmerzen",
    this.trigger = "trigger",
    this.medikamente = "medikamente",
    this.lokalisation = "lokalisation",
    this.hasSymptome = const [],
  }) : this.datum = datum ?? DateTime.now();

  factory Migraeneanfall.fromJson(Map<String, dynamic> json) => Migraeneanfall(
        id: json["id"],
        datum: DateTime.parse(json["datum"]),
        schmerzen: json["schmerzen"],
        trigger: json["trigger"],
        medikamente: json["medikamente"],
        lokalisation: json["lokalisation"],
        hasSymptome: List<int>.from(json["hasSymptome"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "datum":
            "${datum.year.toString().padLeft(4, '0')}-${datum.month.toString().padLeft(2, '0')}-${datum.day.toString().padLeft(2, '0')}",
        "schmerzen": schmerzen,
        "trigger": trigger,
        "medikamente": medikamente,
        "lokalisation": lokalisation,
        "hasSymptome": List<dynamic>.from(hasSymptome.map((x) => x)),
      };
}
