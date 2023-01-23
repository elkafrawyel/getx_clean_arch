class UserModel {
  UserModel({
    this.id,
    this.uuid,
    this.firstName,
    this.lastName,
    this.email,
    this.swiftCode,
    this.iban,
    this.bankName,
    this.bankAccount,
    this.type,
    this.providerId,
    this.provider,
    this.fcmToken,
    this.status,
    this.isVerified,
    this.otp,
    this.birthDate,
    this.gender,
    this.image,
    this.mobile,
    this.countryId,
    this.adderId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.tokens,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    uuid = json['uuid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    swiftCode = json['swift_code'];
    iban = json['iban'];
    bankName = json['bank_name'];
    bankAccount = json['bank_account'];
    type = json['type'];
    providerId = json['provider_id'];
    provider = json['provider'];
    fcmToken = json['fcm_token'];
    status = json['status'];
    isVerified = json['isVerified'];
    otp = json['otp'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    image = json['image'];
    mobile = json['mobile'];
    countryId = json['country_id'];
    adderId = json['adder_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['tokens'] != null) {
      tokens = [];
      json['tokens'].forEach((v) {
        tokens?.add(Tokens.fromJson(v));
      });
    }
  }

  num? id;
  String? uuid;
  String? firstName;
  String? lastName;
  dynamic email;
  dynamic swiftCode;
  dynamic iban;
  dynamic bankName;
  dynamic bankAccount;
  String? type;
  dynamic providerId;
  dynamic provider;
  String? fcmToken;
  num? status;
  num? isVerified;
  dynamic otp;
  dynamic birthDate;
  dynamic gender;
  dynamic image;
  String? mobile;
  num? countryId;
  num? adderId;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Tokens>? tokens;

  UserModel copyWith({
    num? id,
    String? uuid,
    String? firstName,
    String? lastName,
    dynamic email,
    dynamic swiftCode,
    dynamic iban,
    dynamic bankName,
    dynamic bankAccount,
    String? type,
    dynamic providerId,
    dynamic provider,
    String? fcmToken,
    num? status,
    num? isVerified,
    dynamic otp,
    dynamic birthDate,
    dynamic gender,
    dynamic image,
    String? mobile,
    num? countryId,
    num? adderId,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
    List<Tokens>? tokens,
  }) =>
      UserModel(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        swiftCode: swiftCode ?? this.swiftCode,
        iban: iban ?? this.iban,
        bankName: bankName ?? this.bankName,
        bankAccount: bankAccount ?? this.bankAccount,
        type: type ?? this.type,
        providerId: providerId ?? this.providerId,
        provider: provider ?? this.provider,
        fcmToken: fcmToken ?? this.fcmToken,
        status: status ?? this.status,
        isVerified: isVerified ?? this.isVerified,
        otp: otp ?? this.otp,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        image: image ?? this.image,
        mobile: mobile ?? this.mobile,
        countryId: countryId ?? this.countryId,
        adderId: adderId ?? this.adderId,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        tokens: tokens ?? this.tokens,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['uuid'] = uuid;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['swift_code'] = swiftCode;
    map['iban'] = iban;
    map['bank_name'] = bankName;
    map['bank_account'] = bankAccount;
    map['type'] = type;
    map['provider_id'] = providerId;
    map['provider'] = provider;
    map['fcm_token'] = fcmToken;
    map['status'] = status;
    map['isVerified'] = isVerified;
    map['otp'] = otp;
    map['birth_date'] = birthDate;
    map['gender'] = gender;
    map['image'] = image;
    map['mobile'] = mobile;
    map['country_id'] = countryId;
    map['adder_id'] = adderId;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (tokens != null) {
      map['tokens'] = tokens?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Tokens {
  Tokens({
    this.id,
    this.token,
    this.userId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  Tokens.fromJson(dynamic json) {
    id = json['id'];
    token = json['token'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? token;
  num? userId;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  Tokens copyWith({
    num? id,
    String? token,
    num? userId,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
  }) =>
      Tokens(
        id: id ?? this.id,
        token: token ?? this.token,
        userId: userId ?? this.userId,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['token'] = token;
    map['user_id'] = userId;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
