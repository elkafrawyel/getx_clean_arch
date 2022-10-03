class CompoundModel {
  CompoundModel({
    this.id,
    this.name,
    this.nameAr,
    this.nameEn,
    this.image,
    this.districtId,
    this.district,
    this.governmentId,
    this.government,
    this.countryId,
    this.country,
  });

  CompoundModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    image = json['image'];
    districtId = json['district_id'];
    district = json['district'] != null ? District.fromJson(json['district']) : null;
    governmentId = json['government_id'];
    government = json['government'] != null ? Government.fromJson(json['government']) : null;
    countryId = json['country_id'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }

  num? id;
  String? name;
  String? nameAr;
  String? nameEn;
  String? image;
  num? districtId;
  District? district;
  num? governmentId;
  Government? government;
  num? countryId;
  Country? country;
}

class Country {
  Country({
    this.id,
    this.code,
    this.pref,
    this.flag,
    this.status,
    this.adderId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.nameAr,
    this.nameEn,
    this.name,
  });

  Country.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    pref = json['pref'];
    flag = json['flag'];
    status = json['status'];
    adderId = json['adder_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    name = json['name'];
  }

  num? id;
  String? code;
  String? pref;
  String? flag;
  num? status;
  num? adderId;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? nameAr;
  String? nameEn;
  String? name;
}

class Government {
  Government({
    this.id,
    this.countryId,
    this.adderId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.nameAr,
    this.nameEn,
    this.name,
  });

  Government.fromJson(dynamic json) {
    id = json['id'];
    countryId = json['country_id'];
    adderId = json['adder_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    name = json['name'];
  }

  num? id;
  num? countryId;
  num? adderId;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? nameAr;
  String? nameEn;
  String? name;
}

class District {
  District({
    this.id,
    this.image,
    this.attractive,
    this.governmentId,
    this.adderId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.nameAr,
    this.nameEn,
    this.name,
  });

  District.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    attractive = json['attractive'];
    governmentId = json['government_id'];
    adderId = json['adder_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    name = json['name'];
  }

  num? id;
  dynamic image;
  num? attractive;
  num? governmentId;
  num? adderId;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? nameAr;
  String? nameEn;
  String? name;
}
