class SubscriptionModel {
  List<Records>? records;
  Null? record;
  String? code;
  String? status;
  String? message;

  SubscriptionModel(
      {this.records, this.record, this.code, this.status, this.message});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
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

 }

class Records {
  Null? photo;
  int? id;
  String? subscriptionTitle;
  String? adsNumber;
  String? subscriptionPeriod;
  String? imgUrl;
  Null? userSubscription;

  Records(
      {this.photo,
        this.id,
        this.subscriptionTitle,
        this.adsNumber,
        this.subscriptionPeriod,
        this.imgUrl,
        this.userSubscription});

  Records.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    id = json['id'];
    subscriptionTitle = json['subscription_Title'];
    adsNumber = json['ads_Number'];
    subscriptionPeriod = json['subscription_Period'];
    imgUrl = json['imgUrl'];
    userSubscription = json['userSubscription'];
  }

 }
