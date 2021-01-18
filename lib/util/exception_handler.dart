import 'dart:io';

import 'package:dio/dio.dart';

class ExceptionHandler {
  static String handelException(error) {
    String errorMessage =  "Unexpected error occurred";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorMessage = "Request Cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorMessage = "Send timeout in connection with API server";
          break;
        case DioErrorType.DEFAULT:
          errorMessage = "No internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorMessage = "Connection request timeout";
          break;
        case DioErrorType.RESPONSE:
          handleResponse(error.response.statusCode);
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorMessage = "Connection request timeout";
          break;
      }
    } else if (error is SocketException) {
      errorMessage = "No internet connection";
    }

    if (error is Exception) {
        errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }

    }
      return errorMessage;

  }

  static String handleResponse(int statusCode) {
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return "Unauthorized request";
        break;
      case 404:
        return "Not found";
        break;
      case 409:
        return "Error due to a conflict";
        break;
      case 408:
        return "Connection request timeout";
        break;
      case 500:
        return "Internal Server Error";
        break;
      case 503:
        return "Service unavailable";
        break;
      default:
        var responseCode = statusCode;
        return "Received invalid status code: $responseCode";
    }
  }

}
