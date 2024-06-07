class ActiveDocument {
  String? filename;
  String? description;
  String? name;

  ActiveDocument({this.filename, this.description, this.name});

  ActiveDocument.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    description = json['description'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['description'] = description;
    data['name'] = name;
    return data;
  }
}
