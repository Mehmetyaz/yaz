///
class Entry {
  ///
  Entry(
      {required this.entryId,
      required this.comment,
      required this.createDate,
      required this.userId});

  ///
  factory Entry.fromMap(Map<String, dynamic> json) {
    return Entry(
        userId: json["user_id"],
        entryId: json["entry_id"],
        comment: json["comment"],
        createDate: DateTime.fromMillisecondsSinceEpoch(json["create_date"]));
  }

  ///
  Map<String, dynamic> toJson() {
    return {
      "entry_id": entryId,
      "comment": comment,
      "create_date": createDate.millisecondsSinceEpoch,
      "user_id": userId
    };
  }

  ///
  String entryId;

  ///
  String comment;

  ///
  DateTime createDate;

  ///
  String userId;
}
