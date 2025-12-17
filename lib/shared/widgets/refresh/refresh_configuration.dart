import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 刷新配置组件
/// 
/// 用于统一配置应用的下拉刷新和上拉加载更多的全局配置
class AppRefreshConfiguration extends StatelessWidget {
  final Widget child;

  const AppRefreshConfiguration({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      // headerBuilder: () => WaterDropHeader(), // 配置默认头部指示器
      // footerBuilder: () => ClassicFooter(), // 配置默认底部指示器
      headerTriggerDistance: 52.0, // 头部触发刷新的越界距离
      springDescription: SpringDescription(
        //刚度 - 值越大，弹簧越硬，回弹力越强
        stiffness: 150,
        //值越大，运动越快停止，减少振荡
        damping: 25,
        // 质量越大，惯性越大，运动越慢
        mass: 1.0,
      ), // 自定义回弹动画,三个属性值意义请查询flutter api
      maxOverScrollExtent: 100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
      maxUnderScrollExtent: 0, // 底部最大可以拖动的范围
      enableScrollWhenRefreshCompleted:
          true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
      enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
      hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
      enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
      child: child,
    );
  }
}