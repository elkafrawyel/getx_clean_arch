class UserModel {
  UserModel({
    this.id,
    this.providerId,
    this.uuid,
    this.firstName,
    this.lastName,
    this.email,
    this.swiftCode,
    this.iban,
    this.type,
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
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    providerId = json['provider_id'];
    uuid = json['uuid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    swiftCode = json['swift_code'];
    iban = json['iban'];
    type = json['type'];
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
  }

  dynamic id;
  dynamic providerId;
  dynamic uuid;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic swiftCode;
  dynamic iban;
  dynamic type;
  dynamic fcmToken;
  dynamic status;
  dynamic isVerified;
  dynamic otp;
  dynamic birthDate;
  dynamic gender;
  dynamic image;
  dynamic mobile;
  dynamic countryId;
  dynamic adderId;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

}
