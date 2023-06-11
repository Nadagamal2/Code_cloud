class SliderModel {
  List<Records>? records;
  Null? record;
  String? code;
  String? status;
  String? message;

  SliderModel(
      {this.records, this.record, this.code, this.status, this.message});

  SliderModel.fromJson(Map<String, dynamic> json) {
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
  String? sliderImgUrl;
  String? title;
  String? subTitle;

  Records({this.photo, this.id, this.sliderImgUrl, this.title, this.subTitle});

  Records.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    id = json['id'];
    sliderImgUrl = json['slider_ImgUrl'];
    title = json['title'];
    subTitle = json['sub_Title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.photo;
    data['id'] = this.id;
    data['slider_ImgUrl'] = this.sliderImgUrl;
    data['title'] = this.title;
    data['sub_Title'] = this.subTitle;
    return data;
  }
}