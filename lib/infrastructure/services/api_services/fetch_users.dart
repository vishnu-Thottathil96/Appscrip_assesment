import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_template/core/config/api_config/api_config.dart';
import 'package:flutter_template/core/config/api_config/api_endpoints.dart';
import 'package:flutter_template/domain/failures/api_failures.dart';
import 'package:flutter_template/domain/models/user_model.dart';
import 'package:flutter_template/infrastructure/services/api_services/api_response_handler.dart';
import 'package:http/http.dart' as http;

class UserService {
  static String usersUrl = '${ApiConfig.baseUrl}${ApiEndpoints.fetchUsers}';

  Future<Either<ApiFailures, List<UserModel>>> fetchUsers() async {
    try {
      final url = Uri.parse(usersUrl);
      log("Fetching users from: $url");

      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      log("Response Status: ${response.statusCode}");
      log("Response Body: ${response.body}");

      return await apiResponseHandler<List<UserModel>>(response, (json) {
        final users =
            (json as List)
                .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
                .toList();
        log("Total users fetched: ${users.length}");
        return users;
      });
    } on http.ClientException catch (e) {
      return left(ApiFailures.clientFailure(errorMessage: 'Client error: $e'));
    } on TimeoutException catch (e) {
      return left(
        ApiFailures.clientFailure(errorMessage: 'Request timeout: $e'),
      );
    } catch (e) {
      return left(
        ApiFailures.clientFailure(errorMessage: 'Unexpected error: $e'),
      );
    }
  }
}
