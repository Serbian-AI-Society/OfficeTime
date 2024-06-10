import 'package:re_searcher_ui/core/model/ai_response.dart';
import 'package:re_searcher_ui/core/model/user_message_body.dart';

abstract class ChatRepository {
  Future<AiResponse> getAiResponse(UserMessageBody userMessageBody);

  void pingServer();
}
