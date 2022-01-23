// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<JakeData> jakeDataFromJson(String str) =>
    List<JakeData>.from(json.decode(str).map((x) => JakeData.fromJson(x)));

String jakeDatalToJson(List<JakeData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JakeData {
  JakeData({
    required this.id,
    required this.name,
    required this.description,
    required this.watchersCount,
    required this.language,
    required this.openIssues,
  });

  int? id;
  String? name;
  String? description;
  int? watchersCount;
  String? language;
  int? openIssues;

  factory JakeData.fromJson(Map<String, dynamic> json) => JakeData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        watchersCount: json["watchers_count"],
        language: json["language"] == null ? null : json["language"],
        openIssues: json["open_issues"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "language": language == null ? null : language,
        "open_issues": openIssues,
        "watchers_count": watchersCount,
      };
}
