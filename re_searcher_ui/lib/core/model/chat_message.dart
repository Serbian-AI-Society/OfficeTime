class ChatMessage {
  String? role;
  String? content;
  List<String>? citations;

  ChatMessage({
    this.role,
    this.content,
    this.citations,
  });

  ChatMessage.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['content'] = content;
    return data;
  }
}
