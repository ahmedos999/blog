class Comment {
  Comment({
    required this.op,
    required this.text,
  });

  String op;
  String text;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        op: json["OP"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "OP": op,
        "text": text,
      };
}
