class StickyNote {
  String? title;
  String? description;
  String? timestamp;

  StickyNote({this.title, this.description, this.timestamp});

  StickyNote.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['timestamp'] = timestamp;
    return data;
  }
}
