import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_placeholder_sample/shared/api_client.dart';
import 'package:json_placeholder_sample/users/model/user.dart';

final usersApiProvider = Provider<UsersApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return UsersApi(client: client);
});

class UsersApi {
  const UsersApi({required this.client});

  final ApiClient client;

  static const path = '/users';

  Future<List<User>> get() async {
    final response = await client.$get(path: path);
    final body = response.body;
    return (jsonDecode(body) as List).map((e) => User.fromJson(e)).toList();
  }
}
