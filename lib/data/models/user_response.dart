import 'package:getx_clean_arch/domain/entities/models/user_model.dart';

class UserResponse {
  UserResponse({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.user,
  });

  UserResponse.fromJson(dynamic json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  String? accessToken;
  String? tokenType;
  int? expiresIn;
  UserModel? user;
}
