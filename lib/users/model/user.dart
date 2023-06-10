import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_placeholder_sample/users/model/address.dart';
import 'package:json_placeholder_sample/users/model/company.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required Address address,
    required String phone,
    required String website,
    required Company company,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
