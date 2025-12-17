import 'package:flutter/material.dart';
import '../models/nav_item.dart';

// 导航栏状态管理类，使用Provider进行状态管理
class NavBarState extends ChangeNotifier {
  int _selectedIndex = 0;
  int _playingIndex = 0;
  final Map<NavItem, AnimationController?> _animationControllers = {
    for (var item in NavItem.values) item: null,
  };

  // 获取当前选中的索引
  int get selectedIndex => _selectedIndex;

  // 获取当前播放动画的索引
  int get playingIndex => _playingIndex;

  // 获取动画控制器映射
  Map<NavItem, AnimationController?> get animationControllers =>
      _animationControllers;

  // 设置选中的索引
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
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

  // 释放所有动画控制器资源
  void disposeAllControllers() {
    for (var controller in _animationControllers.values) {
      controller?.dispose();
    }
    _animationControllers.clear();
  }
}
