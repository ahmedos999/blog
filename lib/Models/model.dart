import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.name,
  });

  String name;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
