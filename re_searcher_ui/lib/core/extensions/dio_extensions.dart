import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

extension DioExceptions on DioException {
  Exception processDioException() {
    if (kDebugMode) {
      print(this);
    }

    if (response != null) {
      // Error on server-side
      return Exception("API ERROR - ${response!.statusMessage}");
    } else if (type == DioExceptionType.connectionError) {
      return Exception("ERROR - Can't connect to server.");
    } else {
      return Exception("ERROR - ${toString()}");
    }
  }
}
