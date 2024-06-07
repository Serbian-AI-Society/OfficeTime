import 'package:re_searcher_ui/core/model/active_document.dart';
import 'package:re_searcher_ui/core/model/conversation.dart';

class UserMessageBody {
  ActiveDocument? activeDocument;
  List<ChatMessage>? conversation;

  UserMessageBody({this.activeDocument, this.conversation});

  UserMessageBody.fromJson(Map<String, dynamic> json) {
    activeDocument = json['active_document'] != null
        ? ActiveDocument.fromJson(json['active_document'])
        : null;
    if (json['conversation'] != null) {
      conversation = <ChatMessage>[];
      json['conversation'].forEach((v) {
        conversation!.add(ChatMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (activeDocument != null) {
      data['active_document'] = activeDocument!.toJson();
    }
    if (conversation != null) {
      data['conversation'] = conversation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
