import 'package:getx_clean_arch/domain/entities/models/compound_model.dart';


class CompoundsResponse {
  CompoundsResponse({
    this.data,
    this.links,
    this.meta,
  });



  CompoundsResponse.fromJson(Map<String,dynamic> json){
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CompoundModel.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<CompoundModel>? data;
  Links? links;
  Meta? meta;
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  Meta.fromJson(dynamic json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  num? currentPage;
  num? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;
}

class Links {
  Links({
    this.url,
    this.label,
    this.active,
  });

  Links.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  dynamic url;
  String? label;
  bool? active;
}

