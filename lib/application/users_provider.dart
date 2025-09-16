import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/domain/models/user_model.dart';
import 'package:flutter_template/infrastructure/services/api_services/fetch_users.dart';

// Users FutureProvider
final usersProvider = FutureProvider<List<UserModel>>((ref) async {
  final result = await UserService().fetchUsers();
  return result.fold((failure) {
    return [];
  }, (users) => users);
});
