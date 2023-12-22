
import 'package:iot_agriculture/core/constants/app_string.dart';

class UserModel {
  UserModel({
    this.id,
    this.deviceId,
    this.name,
    this.email,
    this.age,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json[AppString.id].toString(),
        deviceId: json[AppString.deviceId].toString(),
        name: json[AppString.name].toString(),
        email: json[AppString.email].toString(),
        age: int.parse(json[AppString.age].toString()),
      );
  late String? id;
  late String? deviceId;
  final String? name;
  final String? email;
  final int? age;
  final String? password;

  Map<String, dynamic> toMap() {
    return {
      AppString.id: id,
      AppString.deviceId: deviceId,
      AppString.name: name,
      AppString.email: email,
      AppString.age: age,
      AppString.deviceId: deviceId,
    };
  }
}
