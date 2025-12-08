import 'package:coolmall_flutter/app/router/app_routes.dart';
import 'package:coolmall_flutter/features/launch/models/guide_page_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GuideViewModel extends ChangeNotifier {
  int _currentPage = 0;
  bool _isLastPage = false;
  final PageController _pageController = PageController(initialPage: 0);

  int get currentPage => _currentPage;
  bool get isLastPage => _isLastPage;
  PageController get pageController => _pageController;

  void onPageChanged(int index) {
    _currentPage = index;
    _isLastPage = index == guidePageDataList.length - 1;
    notifyListeners();
  }

  void skipGuide(BuildContext context) {
    completeGuide(context);
  }

  void nextPage(BuildContext context) {
    if (_isLastPage) {
      completeGuide(context);
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void completeGuide(BuildContext context) {
    // 导航到主页
    context.go(AppRoutes.home);
  }
}
