import 'package:coolmall_flutter/features/common/model/web_view_data.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// WebView页面状态管理类
class WebViewState extends ChangeNotifier {
  // WebView数据
  WebViewData _webViewData = const WebViewData();
  WebViewData get webViewData => _webViewData;

  // 页面标题
  String _pageTitle = '';
  String get pageTitle => _pageTitle;

  // 加载进度 (0-100)
  int _currentProgress = 0;
  int get currentProgress => _currentProgress;

  // 是否应该刷新页面
  bool _shouldRefresh = false;
  bool get shouldRefresh => _shouldRefresh;

  // 下拉菜单显示状态
  bool _showDropdownMenu = false;
  bool get isDropdownMenuVisible => _showDropdownMenu;

  // 当前URL
  String get currentUrl => _webViewData.url;

  /// 初始化WebView数据
  ///
  /// @param url 网页URL
  /// @param title 页面标题
  void initParams(WebViewData webViewData) {
    if (webViewData.url.isNotEmpty) {
      _webViewData = webViewData;
      _pageTitle = webViewData.title ?? '网页';
      _currentProgress = 0;
      _shouldRefresh = false;
      notifyListeners();
    }
  }

  /// 更新页面标题
  ///
  /// @param title 新的页面标题
  void updatePageTitle(String title) {
    if (title.isNotEmpty) {
      _pageTitle = title;
      _webViewData = _webViewData.copyWith(title: title);
      notifyListeners();
    }
  }

  /// 更新加载进度
  ///
  /// @param progress 加载进度(0-100)
  void updateProgress(int progress) {
    _currentProgress = progress.clamp(0, 100);
    notifyListeners();
  }

  /// 刷新页面
  void refreshPage() {
    _shouldRefresh = true;
    dismissDropdownMenu();
    notifyListeners();
  }

  /// 重置刷新状态
  void resetRefreshState() {
    _shouldRefresh = false;
    notifyListeners();
  }

  /// 用浏览器打开当前页面
  ///
  /// 注意：需要在Widget树中有BuildContext才能调用
  void openInBrowser() async {
    final currentUrl = _webViewData.url;
    if (currentUrl.isNotEmpty) {
      try {
        final uri = Uri.parse(currentUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      } catch (e) {
        // 静默处理错误，避免生产环境print
      }
    }
    dismissDropdownMenu();
  }

  /// 显示下拉菜单
  void showDropdownMenu() {
    _showDropdownMenu = true;
    notifyListeners();
  }

  /// 隐藏下拉菜单
  void dismissDropdownMenu() {
    _showDropdownMenu = false;
    notifyListeners();
  }

  /// 返回上一页
  ///
  /// 注意：需要在Widget树中有BuildContext才能调用
  void navigateBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      // 如果没有上一页可以返回，可以导航到首页
      // Navigator.of(context).pushReplacementNamed('/');
    }
  }

  /// 重置所有状态
  void reset() {
    _webViewData = const WebViewData();
    _pageTitle = '';
    _currentProgress = 0;
    _shouldRefresh = false;
    _showDropdownMenu = false;
    notifyListeners();
  }
}
