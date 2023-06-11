class CategoryIdModel {
  List<Records>? records;
  Null? record;
  String? code;
  String? status;
  String? message;

  CategoryIdModel(
      {this.records, this.record, this.code, this.status, this.message});

  CategoryIdModel.fromJson(Map<String, dynamic> json) {
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
  Null? userFaviouriteId;
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
  bool? isFaviourite;
  int? catgId;
  Categories? categories;
  int? countId;
  Countries? countries;
  List<UserFaviourites>? userFaviourites;

  Records(
      {this.userFaviouriteId,
        this.photo,
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
        this.isFaviourite,
        this.catgId,
        this.categories,
        this.countId,
        this.countries,
        this.userFaviourites});

  Records.fromJson(Map<String, dynamic> json) {
    userFaviouriteId = json['user_Faviourite_Id'];
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
    isFaviourite = json['isFaviourite'];
    catgId = json['catgId'];
    categories = json['categories'] != null
        ? new Categories.fromJson(json['categories'])
        : null;
    countId = json['countId'];
    countries = json['countries'] != null
        ? new Countries.fromJson(json['countries'])
        : null;
    if (json['user_Faviourites'] != null) {
      userFaviourites = <UserFaviourites>[];
      json['user_Faviourites'].forEach((v) {
        userFaviourites!.add(new UserFaviourites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_Faviourite_Id'] = this.userFaviouriteId;
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
    data['isFaviourite'] = this.isFaviourite;
    data['catgId'] = this.catgId;
    if (this.categories != null) {
      data['categories'] = this.categories!.toJson();
    }
    data['countId'] = this.countId;
    if (this.countries != null) {
      data['countries'] = this.countries!.toJson();
    }
    if (this.userFaviourites != null) {
      data['user_Faviourites'] =
          this.userFaviourites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? categName;
  String? catedIconUrl;
  Null? stores;

  Categories({this.id, this.categName, this.catedIconUrl, this.stores});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categName = json['categ_Name'];
    catedIconUrl = json['cated_IconUrl'];
    stores = json['stores'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categ_Name'] = this.categName;
    data['cated_IconUrl'] = this.catedIconUrl;
    data['stores'] = this.stores;
    return data;
  }
}

class Countries {
  int? id;
  String? contName;
  String? contFlagUrl;
  Null? stores;

  Countries({this.id, this.contName, this.contFlagUrl, this.stores});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contName = json['cont_Name'];
    contFlagUrl = json['cont_FlagUrl'];
    stores = json['stores'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cont_Name'] = this.contName;
    data['cont_FlagUrl'] = this.contFlagUrl;
    data['stores'] = this.stores;
    return data;
  }
}

class UserFaviourites {
  int? id;
  String? userId;
  int? storeId;
  Null? stores;

  UserFaviourites({this.id, this.userId, this.storeId, this.stores});

  UserFaviourites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    storeId = json['storeId'];
    stores = json['stores'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['storeId'] = this.storeId;
    data['stores'] = this.stores;
    return data;
  }
}