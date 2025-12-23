// To parse this JSON data, do
//
//     final pageHomeData = pageHomeDataFromJson(jsonString);

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

class Category {
  final int id;
  final DateTime createTime;
  final DateTime updateTime;
  final dynamic description;
  final dynamic path;
  final String pic;
  final int sortNum;
  final int status;
  final String? name;
  final int? parentId;

  Category({
    required this.id,
    required this.createTime,
    required this.updateTime,
    this.description,
    this.path,
    required this.pic,
    required this.sortNum,
    required this.status,
    this.name,
    this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    createTime: DateTime.parse(json["createTime"]),
    updateTime: DateTime.parse(json["updateTime"]),
    description: json["description"],
    path: json["path"],
    pic: json["pic"],
    sortNum: json["sortNum"],
    status: json["status"],
    name: json["name"],
    parentId: json["parentId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createTime": createTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
    "description": description,
    "path": path,
    "pic": pic,
    "sortNum": sortNum,
    "status": status,
    "name": name,
    "parentId": parentId,
  };
}

class Coupon {
  final int id;
  final DateTime createTime;
  final DateTime updateTime;
  final String title;
  final String description;
  final int type;
  final int amount;
  final int num;
  final int receivedNum;
  final DateTime startTime;
  final DateTime endTime;
  final int status;
  final Condition condition;

  Coupon({
    required this.id,
    required this.createTime,
    required this.updateTime,
    required this.title,
    required this.description,
    required this.type,
    required this.amount,
    required this.num,
    required this.receivedNum,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.condition,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["id"],
    createTime: DateTime.parse(json["createTime"]),
    updateTime: DateTime.parse(json["updateTime"]),
    title: json["title"],
    description: json["description"],
    type: json["type"],
    amount: json["amount"],
    num: json["num"],
    receivedNum: json["receivedNum"],
    startTime: DateTime.parse(json["startTime"]),
    endTime: DateTime.parse(json["endTime"]),
    status: json["status"],
    condition: Condition.fromJson(json["condition"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createTime": createTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
    "title": title,
    "description": description,
    "type": type,
    "amount": amount,
    "num": num,
    "receivedNum": receivedNum,
    "startTime": startTime.toIso8601String(),
    "endTime": endTime.toIso8601String(),
    "status": status,
    "condition": condition.toJson(),
  };
}

class Condition {
  final int fullAmount;

  Condition({required this.fullAmount});

  factory Condition.fromJson(Map<String, dynamic> json) =>
      Condition(fullAmount: json["fullAmount"]);

  Map<String, dynamic> toJson() => {"fullAmount": fullAmount};
}

class Goods {
  final int id;
  final DateTime createTime;
  final DateTime updateTime;
  final int typeId;
  final String title;
  final String subTitle;
  final String mainPic;
  final List<String> pics;
  final int price;
  final int sold;
  final String? content;
  final List<String> contentPics;
  final bool recommend;
  final bool featured;
  final int status;
  final int sortNum;
  final dynamic specs;

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
    createTime: DateTime.parse(json["createTime"]),
    updateTime: DateTime.parse(json["updateTime"]),
    typeId: json["typeId"],
    title: json["title"],
    subTitle: json["subTitle"],
    mainPic: json["mainPic"],
    pics: List<String>.from(json["pics"].map((x) => x)),
    price: json["price"],
    sold: json["sold"],
    content: json["content"],
    contentPics: List<String>.from(json["contentPics"].map((x) => x)),
    recommend: json["recommend"],
    featured: json["featured"],
    status: json["status"],
    sortNum: json["sortNum"],
    specs: json["specs"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createTime": createTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
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
    "specs": specs,
  };
}
