class TodoEntry {
  int id;
  String title;
  String description;
  int done;

  TodoEntry({
    int id,
    String title,
    String description,
    int done,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'done': done,
    };
  }

  TodoEntry.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.done = map['done'];
  }
}
