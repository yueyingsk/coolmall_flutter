import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/nav_item.dart';
import '../state/nav_bar_state.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    // 获取导航栏状态管理
    final navBarViewModel = context.read<NavBarState>();
    // 初始化导航项动画
    // Future.microtask(() {
    //   // 播放首页动画
    //   navBarViewModel.playAnimation(widget.navigationShell.currentIndex);
    // });
    Future.delayed(Duration(milliseconds: 500), () {
      // 播放首页动画
      navBarViewModel.playAnimation(widget.navigationShell.currentIndex);
      setState(() {});
    });
  }

  // 导航项点击事件处理
  void _onItemTapped(int index, NavBarState navBarViewModel) {
    // 使用状态管理播放动画
    navBarViewModel.playAnimation(index);
    navBarViewModel.setSelectedIndex(index);

    // 使用 NavigationShell 切换页面
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 获取导航栏状态管理
    final navBarViewModel = context.read<NavBarState>();

    return Scaffold(
      body: widget.navigationShell, // 使用 NavigationShell 作为主内容区域
      bottomNavigationBar: BottomNavigationBar(
        items: _getNavItems(context, navBarViewModel),
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) {
          if (index != widget.navigationShell.currentIndex) {
            _onItemTapped(index, navBarViewModel);
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedLabelStyle: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: primaryDefault),
        unselectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        elevation: 0,
      ),
    );
  }

  List<BottomNavigationBarItem> _getNavItems(
    BuildContext context,
    NavBarState navBarViewModel,
  ) {
    return List.generate(NavItem.values.length, (index) {
      final navItem = NavItem.values[index];
      return BottomNavigationBarItem(
        icon: SizedBox(
          width: 32, // 调整合适的宽度
          height: 32, // 调整合适的高度
          child: Lottie.asset(
            navItem.animationPath,
            repeat: false, // 不重复播放
            animate: false, // 默认不自动播放
            fit: BoxFit.contain,
            onLoaded: (composition) {
              // 创建动画控制器
              final controller = AnimationController(
                vsync: Navigator.of(context).overlay as TickerProvider,
                duration: composition.duration,
              );

              // 将动画控制器保存到状态管理中
              navBarViewModel.setAnimationController(navItem, controller);
            },
            controller: navBarViewModel.animationControllers[navItem],
          ),
        ),
        label: navItem.label,
      );
    });
  }
}
