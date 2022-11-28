import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

String parseErrorMessageFrom(dynamic exception) {
  if (exception is DioError) {
    if (exception.response != null) {
      if (exception.response!.data.toString().isNotEmpty) {
        return exception.response!.data.toString();
      } else {
        return exception.response!.statusMessage.toString();
      }
    } else {
      return exception.message;
    }
  } else if (exception is PlatformException) {
    return exception.message ?? exception.toString();
  } else {
    // Remove string between [] from error message
    return exception.toString().replaceAll(RegExp(r'\[.*?\] '), '');
  }
}
