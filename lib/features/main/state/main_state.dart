import 'package:coolmall_flutter/features/main/state/home_state.dart';
import 'package:coolmall_flutter/features/main/view/cart_page.dart';
import 'package:coolmall_flutter/features/main/view/category_page.dart';
import 'package:coolmall_flutter/features/main/view/home_page.dart';
import 'package:coolmall_flutter/features/main/view/mine_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/nav_item.dart';

// 主页状态管理类，使用Provider进行状态管理
class MainState extends ChangeNotifier {
  int _selectedIndex = 0;
  int _playingIndex = 0;
  final Map<NavItem, AnimationController?> _animationControllers = {
    for (var item in NavItem.values) item: null,
  };
  late final PageController _pageController;
  late final List<Widget> _pages;

  MainState() {
    _pageController = PageController(initialPage: _selectedIndex);
    _pages = _initPages();
  }

  // 初始化页面列表
  List<Widget> _initPages() {
    return [
      _keepAlive(
        ChangeNotifierProvider(
          create: (_) => HomeState(),
          child: const HomePage(),
        ),
      ),
      _keepAlive(const CategoryPage()),
      _keepAlive(const CartPage()),
      _keepAlive(const MinePage()),
    ];
  }

  // 包装Widget为KeepAlive，防止页面重建
  Widget _keepAlive(Widget child) {
    return KeepAliveWrapper(child: child);
  }

  // 获取当前选中的索引
  int get selectedIndex => _selectedIndex;

  // 获取当前播放动画的索引
  int get playingIndex => _playingIndex;

  // 获取动画控制器映射
  Map<NavItem, AnimationController?> get animationControllers =>
      _animationControllers;

  // 获取PageController
  PageController get pageController => _pageController;

  // 获取页面列表
  List<Widget> get pages => _pages;

  // 设置选中的索引
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // 切换页面
  void switchPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    // 这里不调用setSelectedIndex和playAnimation，由PageView的onPageChanged处理
  }

  // 设置播放动画的索引
  void setPlayingIndex(int index) {
    _playingIndex = index;
    notifyListeners();
  }

  // 设置导航项的动画控制器
  void setAnimationController(NavItem item, AnimationController controller) {
    _animationControllers[item] = controller;
    notifyListeners();
  }

  // 播放指定索引的导航项动画
  void playAnimation(int index) {
    // 停止之前播放的动画
    _animationControllers[NavItem.values[_playingIndex]]?.stop();
    _animationControllers[NavItem.values[_playingIndex]]?.reset();

    // 设置当前播放动画的索引
    _playingIndex = index;

    // 重置并播放当前选中项的动画
    _animationControllers[NavItem.values[index]]?.reset();
    _animationControllers[NavItem.values[index]]?.forward();

    notifyListeners();
  }

  // 释放所有资源
  @override
  void dispose() {
    _pageController.dispose();
    disposeAllControllers();
    super.dispose();
  }

  // 释放所有动画控制器资源
  void disposeAllControllers() {
    for (var controller in _animationControllers.values) {
      controller?.dispose();
    }
    _animationControllers.clear();
  }
}

// KeepAlive包装组件，防止页面重建
class KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  const KeepAliveWrapper({super.key, required this.child});

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
