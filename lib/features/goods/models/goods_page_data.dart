// To parse this JSON data, do
//
//     final goodsPageData = goodsPageDataFromJson(jsonString);


import 'package:coolmall_flutter/features/main/models/home_data.dart';


class GoodsPageData {
  final List<Goods> list;
  final Pagination pagination;

  GoodsPageData({required this.list, required this.pagination});

  factory GoodsPageData.fromJson(Map<String, dynamic> json) => GoodsPageData(
    list: List<Goods>.from(json["list"].map((x) => Goods.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  final int total;
  final int size;
  final int page;

  Pagination({required this.total, required this.size, required this.page});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      Pagination(total: json["total"], size: json["size"], page: json["page"]);

  Map<String, dynamic> toJson() => {"total": total, "size": size, "page": page};
}
