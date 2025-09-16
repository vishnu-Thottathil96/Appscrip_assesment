import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';

import 'package:flutter_template/core/config/routes_onfig/app_screens.dart';
import 'package:flutter_template/domain/failures/api_failures.dart';
import 'package:flutter_template/main.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

Future<Either<ApiFailures, T>> apiResponseHandler<T>(
  http.Response response,
  T Function(dynamic)
  fromJson, // Accepts dynamic to handle various JSON structures
) async {
  try {
    switch (response.statusCode) {
      case 200:
        try {
          dynamic jsonMap = jsonDecode(
            response.body,
          ); // Using dynamic to handle list or map
          T result = fromJson(jsonMap);
          return right(result);
        } catch (e) {
          log('JSON Parsing Error: $e');
          return left(
            ApiFailures.serverFailure(
              errorMessage: 'Failed to parse response data.$e',
            ),
          );
        }

      case 401:
        log('Unauthorized');

        final context = navigatorKey.currentContext;
        if (context != null) {
          try {
            GoRouter.of(context).push(AppScreens.error.path);
          } catch (e) {
            log('Error parsing socket data: $e');
          }
        }
        // Optionally, return an error for further handling
        String backendMessage = _extractErrorMessage(response.body);
        return left(
          ApiFailures.serverFailure(
            statusCode: response.statusCode,
            errorMessage: backendMessage,
          ),
        );

      case 400:
      case 403:
      case 404:
      case 409:
      case 422:
      case 500:
        // Extract error message from the backend response (if any)
        String backendMessage = _extractErrorMessage(response.body);
        log('Error Response: $backendMessage');
        log('Error message: ${response.body.toString()}');
        return left(
          ApiFailures.serverFailure(
            statusCode: response.statusCode,
            errorMessage: backendMessage,
          ),
        );

      default:
        log('Unexpected status code: ${response.statusCode}');

        // Attempt to extract an error message from the backend response
        String backendMessage = _extractErrorMessage(response.body);
        log('Unexpected error response: $backendMessage');

        // Return a general error with the status code and backend message
        return left(
          ApiFailures.serverFailure(
            statusCode: response.statusCode,
            errorMessage: backendMessage,
          ),
        );
    }
  } catch (e) {
    log('Error handling response: $e');
    return left(
      const ApiFailures.clientFailure(
        errorMessage: 'An unexpected error occurred.',
      ),
    );
  }
}

// Helper function to extract error message from the response body
String _extractErrorMessage(String responseBody) {
  try {
    final Map<String, dynamic> responseJson = jsonDecode(responseBody);
    if (responseJson.containsKey('message')) {
      return responseJson['message']; // Assuming the backend sends a 'message' field
    }
    return 'Unknown error occurred';
  } catch (e) {
    log('Error parsing error message: $e');
    return 'Error parsing response';
  }
}
