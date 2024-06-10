import 'package:flutter/foundation.dart';
import 'package:re_searcher_ui/core/model/chat_message.dart';
import 'package:re_searcher_ui/core/model/sticky_note.dart';

class AiResponse {
  List<ChatMessage>? conversation;
  String? assistantResponse;
  StickyNote? newStickyNote;
  List<String>? documentKeywords;
  List<String>? citations;
  List<String>? continuationQuestions;

  AiResponse({
    this.conversation = const [],
    this.assistantResponse = "",
    this.newStickyNote,
    this.documentKeywords,
    this.citations,
    this.continuationQuestions,
  });

  AiResponse.fromJson(Map<String, dynamic> json) {
    if (json['conversation'] != null) {
      conversation = <ChatMessage>[];
      json['conversation'].forEach((v) {
        conversation!.add(ChatMessage.fromJson(v));
      });
    } else {
      conversation = [];
    }
    assistantResponse = json['assistant_response'] ?? "ERROR";
    newStickyNote = json['new_sticky_note'] != null
        ? StickyNote.fromJson(json['new_sticky_note'])
        : null;
    documentKeywords = json['document_keywords'] != null
        ? List<String>.from(json['document_keywords'])
        : null;
    citations =
        json['citations'] != null ? List<String>.from(json['citations']) : null;
    try {
      continuationQuestions = json['continuation_questions'] != null
          ? List<String>.from(json['continuation_questions'])
          : null;
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error);
      }
      continuationQuestions = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (conversation != null) {
      data['conversation'] = conversation!.map((v) => v.toJson()).toList();
    }
    data['assistant_response'] = assistantResponse;
    if (newStickyNote != null) {
      data['new_sticky_note'] = newStickyNote!.toJson();
    }
    data['document_keywords'] = documentKeywords;
    data['citations'] = citations;
    data['continuation_questions'] = continuationQuestions;
    return data;
  }
}
