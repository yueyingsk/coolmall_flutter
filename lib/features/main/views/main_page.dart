import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  // 从 NavigationShell 获取当前选中的索引
  int get _selectedIndex => widget.navigationShell.currentIndex;

  // 记录每个导航项的动画控制器，用于控制动画播放
  final List<AnimationController?> _animationControllers = [
    null,
    null,
    null,
    null,
  ];

  // 记录正在播放动画的导航项索引
  int? _playingIndex;

  // 导航项配置
  final List<String> _navLabels = ['主页', '分类', '购物车', '我的'];
  final List<String> _navAnimations = [
    'assets/lottie/home.json',
    'assets/lottie/category.json',
    'assets/lottie/cart.json',
    'assets/lottie/me.json',
  ];

  void _onItemTapped(int index) {
    setState(() {
      // 停止之前播放的动画
      if (_playingIndex != null) {
        _animationControllers[_playingIndex!]?.stop();
        _animationControllers[_playingIndex!]?.reset();
      }

      // 设置当前播放动画的索引
      _playingIndex = index;

      // 重置并播放当前选中项的动画
      _animationControllers[index]?.reset();
      _animationControllers[index]?.forward();
    });

    // 使用 NavigationShell 切换页面
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 构建导航项
    List<BottomNavigationBarItem> _navItems = List.generate(_navLabels.length, (
      index,
    ) {
      return BottomNavigationBarItem(
        icon: SizedBox(
          width: 32, // 调整合适的宽度
          height: 32, // 调整合适的高度
          child: Lottie.asset(
            _navAnimations[index],
            repeat: false, // 不重复播放
            animate: false, // 默认不自动播放
            fit: BoxFit.contain,
            onLoaded: (composition) {
              // 创建动画控制器
              final controller = AnimationController(
                vsync: this,
                duration: composition.duration,
              );

              setState(() {
                _animationControllers[index] = controller;
              });
            },
            controller: _animationControllers[index],
          ),
        ),
        label: _navLabels[index],
      );
    });

    return Scaffold(
      body: widget.navigationShell, // 使用 NavigationShell 作为主内容区域
      bottomNavigationBar: BottomNavigationBar(
        items: _navItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  void dispose() {
    // 释放所有动画控制器
    for (var controller in _animationControllers) {
      controller?.dispose();
    }
    super.dispose();
  }
}
