class TodoEntry {
  int id;
  String title;
  String description;
  int done;

  TodoEntry({this.id, this.title, this.description, this.done});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'done': done,
    };
  }

  TodoEntry.fromMap(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.description = json['description'];
    this.done = json['done'];
  }
}
