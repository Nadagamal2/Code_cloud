class creatStore {
  Null? records;
  Record? record;
  String? code;
  String? status;
  String? message;

  creatStore({this.records, this.record, this.code, this.status, this.message});

  creatStore.fromJson(Map<String, dynamic> json) {
    records = json['records'];
    record =
    json['record'] != null ? new Record.fromJson(json['record']) : null;
    code = json['code'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['records'] = this.records;
    if (this.record != null) {
      data['record'] = this.record!.toJson();
    }
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Record {
  int? id;
  String? storTitle;
  String? storImgUrl;
  String? storLink;
  String? storDeteils;
  String? storOffer;
  String? storSaleCode;
  String? storAddress;
  String? storPhoneNumber;
  int? catgId;
  Null? categories;
  int? countId;
  Null? countries;

  Record(
      {this.id,
        this.storTitle,
        this.storImgUrl,
        this.storLink,
        this.storDeteils,
        this.storOffer,
        this.storSaleCode,
        this.storAddress,
        this.storPhoneNumber,
        this.catgId,
        this.categories,
        this.countId,
        this.countries});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storTitle = json['stor_Title'];
    storImgUrl = json['stor_ImgUrl'];
    storLink = json['stor_Link'];
    storDeteils = json['stor_Deteils'];
    storOffer = json['stor_Offer'];
    storSaleCode = json['stor_SaleCode'];
    storAddress = json['stor_Address'];
    storPhoneNumber = json['stor_PhoneNumber'];
    catgId = json['catgId'];
    categories = json['categories'];
    countId = json['countId'];
    countries = json['countries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stor_Title'] = this.storTitle;
    data['stor_ImgUrl'] = this.storImgUrl;
    data['stor_Link'] = this.storLink;
    data['stor_Deteils'] = this.storDeteils;
    data['stor_Offer'] = this.storOffer;
    data['stor_SaleCode'] = this.storSaleCode;
    data['stor_Address'] = this.storAddress;
    data['stor_PhoneNumber'] = this.storPhoneNumber;
    data['catgId'] = this.catgId;
    data['categories'] = this.categories;
    data['countId'] = this.countId;
    data['countries'] = this.countries;
    return data;
  }
}