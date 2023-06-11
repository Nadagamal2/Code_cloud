



class CategoryIdallSearchModel {
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

  CategoryIdallSearchModel(
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

  CategoryIdallSearchModel.fromJson(Map<String, dynamic> json) {
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

}