class GoodsCategoryPageArgs {
  bool isFeatured = false;
  bool isRecommended = false;
  List<int>? selectedCategoryIds;
  String? minPrice;
  String? maxPrice;
  String? searchKey;
  //构造函数
  GoodsCategoryPageArgs({
    this.isFeatured = false,
    this.isRecommended = false,
    this.selectedCategoryIds,
    this.minPrice,
    this.maxPrice,
    this.searchKey,
  });
}
