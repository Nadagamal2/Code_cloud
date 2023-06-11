class speacialStore {
  List<Records>? records;
  Null? record;
  String? code;
  String? status;
  String? message;

  speacialStore(
      {this.records, this.record, this.code, this.status, this.message});

  speacialStore.fromJson(Map<String, dynamic> json) {
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
  String? storTitle;
  String? storImgUrl;
  String? storLink;
  String? storDeteils;
  String? storOffer;
  String? storSaleCode;
  String? storAddress;
  String? storPhoneNumber;
  bool? isSpecial;
  int? catgId;
  Null? categories;
  int? countId;
  Null? countries;

  Records(
      {this.photo,
        this.id,
        this.storTitle,
        this.storImgUrl,
        this.storLink,
        this.storDeteils,
        this.storOffer,
        this.storSaleCode,
        this.storAddress,
        this.storPhoneNumber,
        this.isSpecial,
        this.catgId,
        this.categories,
        this.countId,
        this.countries});

  Records.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    id = json['id'];
    storTitle = json['stor_Title'];
    storImgUrl = json['stor_ImgUrl'];
    storLink = json['stor_Link'];
    storDeteils = json['stor_Deteils'];
    storOffer = json['stor_Offer'];
    storSaleCode = json['stor_SaleCode'];
    storAddress = json['stor_Address'];
    storPhoneNumber = json['stor_PhoneNumber'];
    isSpecial = json['isSpecial'];
    catgId = json['catgId'];
    categories = json['categories'];
    countId = json['countId'];
    countries = json['countries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.photo;
    data['id'] = this.id;
    data['stor_Title'] = this.storTitle;
    data['stor_ImgUrl'] = this.storImgUrl;
    data['stor_Link'] = this.storLink;
    data['stor_Deteils'] = this.storDeteils;
    data['stor_Offer'] = this.storOffer;
    data['stor_SaleCode'] = this.storSaleCode;
    data['stor_Address'] = this.storAddress;
    data['stor_PhoneNumber'] = this.storPhoneNumber;
    data['isSpecial'] = this.isSpecial;
    data['catgId'] = this.catgId;
    data['categories'] = this.categories;
    data['countId'] = this.countId;
    data['countries'] = this.countries;
    return data;
  }
}