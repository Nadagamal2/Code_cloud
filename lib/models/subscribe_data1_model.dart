class subscribeTextModel {
  List<Records>? records;
  Null? record;
  String? code;
  String? status;
  String? message;

  subscribeTextModel(
      {this.records, this.record, this.code, this.status, this.message});

  subscribeTextModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? email;
  String? message;

  Records({this.id, this.email, this.message});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['message'] = this.message;
    return data;
  }
}