class GoodsSpec {
  final int id;
  final int goodsId;
  final String name;
  final int price;
  final int stock;
  final int sortNum;
  final List<String>? images;
  final String? createTime;
  final String? updateTime;

  const GoodsSpec({
    required this.id,
    required this.goodsId,
    required this.name,
    required this.price,
    required this.stock,
    required this.sortNum,
    this.images,
    this.createTime,
    this.updateTime,
  });

  factory GoodsSpec.fromJson(Map<String, dynamic> json) {
    return GoodsSpec(
      id: json['id'],
      goodsId: json['goodsId'],
      name: json['name'],
      price: json['price'].toDouble(),
      stock: json['stock'],
      sortNum: json['sortNum'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      createTime: json['createTime'],
      updateTime: json['updateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'goodsId': goodsId,
      'name': name,
      'price': price,
      'stock': stock,
      'sortNum': sortNum,
      'images': images,
      'createTime': createTime,
      'updateTime': updateTime,
    };
  }
}
