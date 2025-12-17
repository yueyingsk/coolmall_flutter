class PageInfo {
  int page;
  int size;

  PageInfo({required this.page, required this.size});

  Map<String, dynamic> toMap() {
    return {'page': page, 'size': size};
  }
}
