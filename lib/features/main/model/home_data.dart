// To parse this JSON data, do
//
//     final pageHomeData = pageHomeDataFromJson(jsonString);

import 'package:coolmall_flutter/features/goods/model/coupon.dart';
import 'package:coolmall_flutter/features/goods/model/goods.dart';
import 'package:coolmall_flutter/features/goods/model/goods_category.dart';

/// 首页数据模型
class HomeData {
  final List<Coupon> coupon;
  final List<Category> banner;
  final List<Goods> goods;
  final List<Goods> flashSale;
  final List<Goods> recommend;
  final List<Category> categoryAll;
  final List<Category> category;

  HomeData({
    required this.coupon,
    required this.banner,
    required this.goods,
    required this.flashSale,
    required this.recommend,
    required this.categoryAll,
    required this.category,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    coupon: List<Coupon>.from(json["coupon"].map((x) => Coupon.fromJson(x))),
    banner: List<Category>.from(
      json["banner"].map((x) => Category.fromJson(x)),
    ),
    goods: List<Goods>.from(json["goods"].map((x) => Goods.fromJson(x))),
    flashSale: List<Goods>.from(
      json["flashSale"].map((x) => Goods.fromJson(x)),
    ),
    recommend: List<Goods>.from(
      json["recommend"].map((x) => Goods.fromJson(x)),
    ),
    categoryAll: List<Category>.from(
      json["categoryAll"].map((x) => Category.fromJson(x)),
    ),
    category: List<Category>.from(
      json["category"].map((x) => Category.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "coupon": List<dynamic>.from(coupon.map((x) => x.toJson())),
    "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
    "goods": List<dynamic>.from(goods.map((x) => x.toJson())),
    "flashSale": List<dynamic>.from(flashSale.map((x) => x.toJson())),
    "recommend": List<dynamic>.from(recommend.map((x) => x.toJson())),
    "categoryAll": List<dynamic>.from(categoryAll.map((x) => x.toJson())),
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}
