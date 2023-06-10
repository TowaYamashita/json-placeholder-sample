import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address{
  const factory Address({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
  }) = _Address;

  factory Address.fromJson(Map<String, Object?> json) => _$AddressFromJson(json);
}
