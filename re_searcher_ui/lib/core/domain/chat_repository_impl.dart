import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:re_searcher_ui/core/domain/chat_repository.dart';
import 'package:re_searcher_ui/core/extensions/dio_extensions.dart';
import 'package:re_searcher_ui/core/model/ai_response.dart';
import 'package:re_searcher_ui/core/model/user_message_body.dart';

class ChatRepositoryImpl implements ChatRepository {
  Dio dio;

  final String baseUrl = 'http://localhost:5000/api';
  // final String baseUrl =
  //     'https://researcher-api.jollymoss-e2c94ce0.westeurope.azurecontainerapps.io/api';

  ChatRepositoryImpl({
    required this.dio,
  });

  @override
  Future<AiResponse> getAiResponse(UserMessageBody userMessageBody) async {
    try {
      var data = userMessageBody.toJson();

      var response = await dio.request(
        "$baseUrl/chat",
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      return (AiResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw e.processDioException();
    }
  }

  @override
  void pingServer() {
    try {
      dio.request(
        "$baseUrl/chat",
        options: Options(
          method: 'GET',
        ),
      );
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
