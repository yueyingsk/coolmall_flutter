import 'package:coolmall_flutter/features/goods/model/goods_spec.dart';

class Goods {
  final int id;
  final String createTime;
  final String updateTime;
  final int typeId;
  final String title;
  final String subTitle;
  final String mainPic;
  final List<String> pics;
  final int price;
  final int sold;
  final String content;
  final List<String> contentPics;
  final bool recommend;
  final bool featured;
  final int status;
  final int sortNum;
  final List<GoodsSpec> specs;

  Goods({
    required this.id,
    required this.createTime,
    required this.updateTime,
    required this.typeId,
    required this.title,
    required this.subTitle,
    required this.mainPic,
    required this.pics,
    required this.price,
    required this.sold,
    required this.content,
    required this.contentPics,
    required this.recommend,
    required this.featured,
    required this.status,
    required this.sortNum,
    required this.specs,
  });

  factory Goods.fromJson(Map<String, dynamic> json) => Goods(
    id: json["id"],
    createTime: json["createTime"] ?? '',
    updateTime: json["updateTime"] ?? '',
    typeId: json["typeId"],
    title: json["title"],
    subTitle: json["subTitle"] ?? '',
    mainPic: json["mainPic"],
    pics: List<String>.from(json["pics"]?.map((x) => x) ?? []),
    price: json["price"],
    sold: json["sold"],
    content: json["content"] ?? '',
    contentPics: List<String>.from(json["contentPics"]?.map((x) => x) ?? []),
    recommend: json["recommend"],
    featured: json["featured"],
    status: json["status"],
    sortNum: json["sortNum"],
    specs: List<GoodsSpec>.from(
      json["specs"]?.map((x) => GoodsSpec.fromJson(x)) ?? [],
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createTime": createTime,
    "updateTime": updateTime,
    "typeId": typeId,
    "title": title,
    "subTitle": subTitle,
    "mainPic": mainPic,
    "pics": List<dynamic>.from(pics.map((x) => x)),
    "price": price,
    "sold": sold,
    "content": content,
    "contentPics": List<dynamic>.from(contentPics.map((x) => x)),
    "recommend": recommend,
    "featured": featured,
    "status": status,
    "sortNum": sortNum,
    "specs": List<dynamic>.from(specs.map((x) => x.toJson())),
  };
}
