class subscribeModel {
  List<Records>? records;
  Null? record;
  String? code;
  String? status;
  String? message;

  subscribeModel(
      {this.records, this.record, this.code, this.status, this.message});

  subscribeModel.fromJson(Map<String, dynamic> json) {
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
  String? accountNumber;

  Records({this.id, this.accountNumber});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accountNumber'] = this.accountNumber;
    return data;
  }
}