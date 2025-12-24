// /**
//      * 页码
//      */
//     @EncodeDefault
//     val page: Int = 1,

//     /**
//      * 每页大小
//      */
//     @EncodeDefault
//     val size: Int = 20,

//     /**
//      * 商品分类ID列表
//      */
//     val typeId: List<Long>? = null,

//     /**
//      * 最低价格
//      */
//     val minPrice: String? = null,

//     /**
//      * 最高价格
//      */
//     val maxPrice: String? = null,

//     /**
//      * 搜索关键词
//      */
//     val keyWord: String? = null,

//     /**
//      * 排序字段（如：sold、price等）
//      */
//     val order: String? = null,

//     /**
//      * 排序方式："asc"升序，"desc"降序
//      */
//     val sort: String? = null,

//     /**
//      * 推荐
//      */
//     val recommend: Boolean = false,

//     /**
//      * 精选
//      */
//     val featured: Boolean = false,
//根据属性生成request类，以及tomap方法
class GoodsSearchRequest {
  int page = 1;
  int size = 10;
  List<int>? typeId;
  String? minPrice;
  String? maxPrice;
  String? keyWord;
  String? order;
  String? sort;
  bool recommend = false;
  bool featured = false;
  GoodsSearchRequest({
    this.page = 1,
    this.size = 10,
    this.typeId,
    this.minPrice,
    this.maxPrice,
    this.keyWord,
    this.order,
    this.sort,
    this.recommend = false,
    this.featured = false,
  });
  Map<String, dynamic> toMap() {
    return {
      "page": page,
      "size": size,
      if (typeId != null && typeId!.isNotEmpty) "typeId": typeId,
      if (minPrice != null && minPrice!.isNotEmpty) "minPrice": minPrice,
      if (maxPrice != null && maxPrice!.isNotEmpty) "maxPrice": maxPrice,
      if (keyWord != null && keyWord!.isNotEmpty) "keyWord": keyWord,
      if (order != null) "order": order,
      if (sort != null) "sort": sort,
      if (recommend) "recommend": recommend,
      if (featured) "featured": featured,
    };
  }

  //复制方法
  GoodsSearchRequest copyWith({
    int? page,
    int? size,
    List<int>? typeId,
    String? minPrice,
    String? maxPrice,
    String? keyWord,
    String? order,
    String? sort,
    bool? recommend,
    bool? featured,
  }) {
    return GoodsSearchRequest(
      page: page ?? this.page,
      size: size ?? this.size,
      typeId: typeId ?? this.typeId,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      keyWord: keyWord ?? this.keyWord,
      order: order ?? this.order,
      sort: sort ?? this.sort,
      recommend: recommend ?? this.recommend,
      featured: featured ?? this.featured,
    );
  }
}
