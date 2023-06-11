class subscribeText2Model {
  List<Records>? records;
  Null? record;
  String? code;
  String? status;
  String? message;

  subscribeText2Model(
      {this.records, this.record, this.code, this.status, this.message});

  subscribeText2Model.fromJson(Map<String, dynamic> json) {
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
  String? message;

  Records({this.id, this.message});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    return data;
  }
}