import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:coolmall_flutter/features/main/state/main_state.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/nav_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    // 获取导航栏状态管理
    final navBarViewModel = context.read<MainState>();

    // 使用addPostFrameCallback将动画播放延迟到当前帧绘制完成后
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // 播放首页动画
    //   navBarViewModel.playAnimation(navBarViewModel.selectedIndex);
    // });
    Future.delayed(const Duration(milliseconds: 500), () {
      // 播放首页动画
      navBarViewModel.playAnimation(navBarViewModel.selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainState>(
      builder: (context, state, child) {
        return Scaffold(
          body: PageView(
            controller: state.pageController,
            onPageChanged: (index) {
              // 页面滑动时更新状态（仅用于用户手动滑动的情况）
              if (index != state.selectedIndex) {
                state.setSelectedIndex(index);
                state.playAnimation(index);
              }
            },
            physics: const BouncingScrollPhysics(), // 添加滑动效果
            children: state.pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _getNavItems(context, state),
            currentIndex: state.selectedIndex,
            onTap: (index) {
              if (index != state.selectedIndex) {
                state.switchPage(index);
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedLabelStyle: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: primaryDefault),
            unselectedLabelStyle: Theme.of(context).textTheme.bodySmall
                ?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
            elevation: 0,
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _getNavItems(
    BuildContext context,
    MainState state,
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
              state.setAnimationController(navItem, controller);
            },
            controller: state.animationControllers[navItem],
          ),
        ),
        label: navItem.label,
      );
    });
  }
}
