import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:json_placeholder_sample/env/env.dart';
import 'package:json_placeholder_sample/shared/api_response_exception.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return const ApiClient(authority: Env.apiDomain);
});

class ApiClient {
  const ApiClient({required this.authority});

  final String authority;

  /// GETメソッドで指定されたパスのエンドポイントを叩く
  /// 
  /// - エンドポイントを叩けなかった場合は、[SocketException]という例外を吐く
  /// - 成功レスポンス以外が返ってきた場合、[ApiResponseException]という例外を吐く
  /// 
  Future<Response> $get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final response = await get(
      Uri.https(authority, path, queryParameters),
      headers: headers,
    );

    if (response.statusCode.toString().startsWith('2')) {
      return response;
    }

    throw ApiResponseException(
      response.reasonPhrase ?? '',
      statusCode: response.statusCode,
      uri: response.request?.url,
    );
  }
}
