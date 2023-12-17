class Note {
  String title = "undefined";
  String description = "undefined";
  DateTime createdDate = DateTime.now();
  late bool showSetDate;

  DateTime? setDate;

  Note({required this.title, required this.description, required this.createdDate, DateTime? setDate}) {
    if (setDate != null) {
      this.setDate = setDate;
    }
    showSetDate = false;
  }

  Note.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    createdDate = DateTime.parse(json['createdDate']);
    setDate = json['setDate'] != null ? DateTime.parse(json['setDate']) : null;
  }

  toJson() {
    return {
      'title': title,
      'description': description,
      'createdDate' : createdDate.toIso8601String(),
      'setDate' : setDate?.toIso8601String(),
    };
  }
}
