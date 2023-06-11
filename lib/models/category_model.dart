class CategoryModel {
  int? id;
  String? categName;
  String? catedIconUrl;


  CategoryModel({
    this.id,
    this.categName,
    this.catedIconUrl,

  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categName: json['categ_Name'],
      catedIconUrl: json['cated_IconUrl'],

    );
  }
}