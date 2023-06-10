import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_placeholder_sample/shared/api_response_exception.dart';
import 'package:json_placeholder_sample/shared/exception/recoverable_exception.dart';
import 'package:json_placeholder_sample/users/api/users_api.dart';
import 'package:json_placeholder_sample/users/model/user.dart';

final usersProvider = FutureProvider<List<User>>((ref) async {
  try {
    final result = await ref.watch(usersApiProvider).get();
    return result;
  } on SocketException catch (_) {
    throw const RecoverableException(
      '通信状況が不安定なようです。通信環境をお確かめの上再度お試しください。',
    );
  } on ApiResponseException catch (e) {
    final statusCode = e.statusCode;

    if (statusCode == HttpStatus.serviceUnavailable) {
      throw const RecoverableException(
        'ただいまメンテナンス中です。ご不便をおかけして申し訳ありません。時間をしばらくおいて再度お試しください。',
      );
    }

    if(statusCode == HttpStatus.tooManyRequests){
      throw const RecoverableException(
        'ご不便をおかけして申し訳ありません。時間をしばらくおいて再度お試しください。',
      );
    }
    rethrow;
  } catch (e) {
    rethrow;
  }
});
