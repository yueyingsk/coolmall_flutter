/// WebView数据模型
class WebViewData {
  final String url;
  final String? title;

  const WebViewData({this.url = '', this.title});

  /// 创建副本
  WebViewData copyWith({String? url, String? title}) {
    return WebViewData(url: url ?? this.url, title: title ?? this.title);
  }

  /// 从JSON创建
  factory WebViewData.fromJson(Map<String, dynamic> json) {
    return WebViewData(url: json['url'] ?? '', title: json['title']);
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {'url': url, 'title': title};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WebViewData && other.url == url && other.title == title;
  }

  @override
  int get hashCode {
    return url.hashCode ^ title.hashCode;
  }

  @override
  String toString() {
    return 'WebViewData(url: $url, title: $title)';
  }
}
