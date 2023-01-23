import '../../domain/entities/models/user_model.dart';

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
  num? expiresIn;
  UserModel? user;

  UserResponse copyWith({
    String? accessToken,
    String? tokenType,
    num? expiresIn,
    UserModel? user,
  }) =>
      UserResponse(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
        user: user ?? this.user,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['token_type'] = tokenType;
    map['expires_in'] = expiresIn;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

