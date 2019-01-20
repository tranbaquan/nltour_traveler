import 'package:json_annotation/json_annotation.dart';

part 'otp.g.dart';

@JsonSerializable()
class OTP {
  String email;
  String otp;
  DateTime expireTime;
  String identifier;


  OTP({this.email, this.otp, this.expireTime, this.identifier});

  factory OTP.fromJson(Map<String, dynamic> json) => _$OTPFromJson(json);

  Map<String, dynamic> toJson() => _$OTPToJson(this);
}