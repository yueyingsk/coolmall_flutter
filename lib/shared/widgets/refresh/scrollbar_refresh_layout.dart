import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:coolmall_flutter/shared/widgets/loading/loading.dart';
import 'package:coolmall_flutter/shared/widgets/loading/load_more.dart';

/// 带有可滚动的自定义头部的refreshlayout，以实现更多的刷新效果
class ScrollbarRefreshLayout extends StatelessWidget {
  final RefreshController controller;
  final Widget child;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final Widget? header;
  final Widget? footer;
  final List<Widget> sliverAppBars;

  const ScrollbarRefreshLayout({
    super.key,
    required this.controller,
    required this.child,
    this.onRefresh,
    this.onLoading,
    this.header,
    this.footer,
    required this.sliverAppBars,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      // 设置滚动控制器以协调嵌套滚动
      controller: ScrollController(),
      //让 SliverAppBar 跟随手指平滑滚动
      floatHeaderSlivers: true,
      // 外部滚动视图只包含SliverAppBar
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return sliverAppBars;
      },
      // 内部滚动视图包含刷新功能和内容
      body: SmartRefresher(
        controller: controller,
        onRefresh: onRefresh,
        onLoading: onLoading,
        header: header ?? _buildCustomRefreshHeader(),
        footer: footer ?? _buildCustomLoadMoreFooter(),
        enablePullDown: true,
        enablePullUp: true,
        child: child,
      ),
    );
  }

  /// 构建自定义刷新头部
  Widget _buildCustomRefreshHeader() {
    return CustomHeader(
      builder: (BuildContext context, RefreshStatus? mode) {
        String text = '';
        bool isAnimating = false;

        switch (mode) {
          case RefreshStatus.idle:
            text = '下拉刷新';
            break;
          case RefreshStatus.refreshing:
            text = '刷新中...';
            isAnimating = true;
            break;
          case RefreshStatus.canRefresh:
            text = '松开刷新';
            break;
          case RefreshStatus.completed:
            text = '刷新完成';
            break;
          case RefreshStatus.failed:
            text = '刷新失败';
            break;
          default:
            text = '';
        }

        return Container(
          height: 52.0,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24.0,
                height: 24.0,
                child: MiLoadingMobile(
                  size: 24.0,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  isAnimating: isAnimating,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 构建自定义加载更多尾部
  Widget _buildCustomLoadMoreFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        final status = mode ?? LoadStatus.idle;

        return LoadMore(
          status: status,
          onRetry: () {
            // 重试加载
            controller.requestLoading();
          },
        );
      },
    );
  }
}