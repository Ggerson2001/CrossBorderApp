class MessageModel {
  final DateTime createdAt;
  final String text;
  final String senderEmail;
  final List<String> companions;

  MessageModel({
    this.createdAt,
    this.text,
    this.senderEmail,
    this.companions,
  });

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "text": text,
        "senderEmail": senderEmail,
        "companions": companions.cast<String>().toList(),
      };

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    String a = json["companions"][0];
    String a1 = json["companions"][1];
    return MessageModel(
      senderEmail: json["senderEmail"],
      companions: [a, a1],
      text: json["text"],
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          json["createdAt"].millisecondsSinceEpoch),
    );
  }
}
