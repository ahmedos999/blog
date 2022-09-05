// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:blog/Models/comment_model.dart';

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.id,
    required this.firstLetter,
    required this.username,
    required this.text,
    required this.date,
    required this.comments,
  });

  String id;
  String firstLetter;
  String username;
  String text;
  String date;
  List<Comment> comments;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        firstLetter: json["firstLetter"],
        username: json["username"],
        text: json["text"],
        date: json["date"],
        comments: List<Comment>.from(
            json["Comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstLetter": firstLetter,
        "username": username,
        "text": text,
        "date": date,
        "Comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}


// {
//   "id":1,
//   "firstLetter":"A",
//   "username":"ahmed osman",
//   "text":"blah blah blah blah blah",
//   "date":"2/2/2022",
//   "Comments":[
//       {
//           "OP":"sara saeed",
//           "text":"really adele please listen to new music"
//       }
//       ]
// }