import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:re_searcher_ui/core/domain/chat_repository.dart';
import 'package:re_searcher_ui/core/model/ai_response.dart';
import 'package:re_searcher_ui/core/model/user_message_body.dart';

class ChatRepositoryImpl implements ChatRepository {
  Dio dio;

  final String baseUrl = 'http://localhost:5000/api';

  ChatRepositoryImpl({
    required this.dio,
  });

  @override
  Future<AiResponse> getAiResponse(UserMessageBody userMessageBody) async {
    var data = userMessageBody.toJson();
    var response = await dio.request(
      "$baseUrl/chat",
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 201) {
      return (AiResponse.fromJson(response.data));
    } else {
      if (kDebugMode) {
        print(response.statusMessage);
      }
      throw (Exception("Error: ${response.statusMessage}"));
    }
  }
}
