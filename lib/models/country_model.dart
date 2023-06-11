class CountryModel {
  List<Records>? records;
  Null? record;
  String? code;
  String? status;
  String? message;

  CountryModel(
      {this.records, this.record, this.code, this.status, this.message});

  CountryModel.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
    record = json['record'];
    code = json['code'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    data['record'] = this.record;
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Records {
  Null? photo;
  int? id;
  String? contName;
  String? contFlagUrl;
  Null? stores;

  Records({this.photo, this.id, this.contName, this.contFlagUrl, this.stores});

  Records.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    id = json['id'];
    contName = json['cont_Name'];
    contFlagUrl = json['cont_FlagUrl'];
    stores = json['stores'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.photo;
    data['id'] = this.id;
    data['cont_Name'] = this.contName;
    data['cont_FlagUrl'] = this.contFlagUrl;
    data['stores'] = this.stores;
    return data;
  }
}