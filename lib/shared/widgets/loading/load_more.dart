import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:coolmall_flutter/shared/widgets/loading/loading.dart';

/// 加载更多组件
///
/// 用于显示列表底部的加载状态，支持以下几种状态：
/// 1. 可上拉加载：显示上拉加载更多提示，两侧有分割线
/// 2. 加载中：显示加载动画和提示文本
/// 3. 加载成功：显示成功提示，两侧有分割线
/// 4. 加载失败：显示错误提示，支持点击重试，两侧有分割线
/// 5. 没有更多数据：显示分割线和圆点
class LoadMore extends StatelessWidget {
  final LoadStatus status;
  final VoidCallback? onRetry;
  final EdgeInsetsGeometry padding;

  const LoadMore({
    super.key,
    this.status = LoadStatus.idle,
    this.onRetry,
    this.padding = const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case LoadStatus.idle:
        return _buildIdleState(context);
      case LoadStatus.canLoading:
        return _buildIdleState(context);
      case LoadStatus.loading:
        return _buildLoadingState(context);
      case LoadStatus.failed:
        return _buildFailedState(context);
      case LoadStatus.noMore:
        return _buildNoMoreState(context);
    }
  }

  /// 空闲状态（可上拉加载更多）
  Widget _buildIdleState(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              height: 0.5,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            '上拉加载更多',
            style: TextStyle(
              fontSize: 14.0,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Divider(
              height: 0.5,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  /// 加载中状态
  Widget _buildLoadingState(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WeLoading(
            size: 16.0,
          ),
          const SizedBox(width: 8.0),
          Text(
            '正在加载...',
            style: TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }

  /// 加载失败状态
  Widget _buildFailedState(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              height: 0.5,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(width: 8.0),
          GestureDetector(
            onTap: onRetry,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                onRetry != null ? '加载失败，点击重试' : '加载失败',
                style: TextStyle(fontSize: 14.0, color: colorDanger),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Divider(
              height: 0.5,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  /// 没有更多数据状态
  Widget _buildNoMoreState(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              height: 0.5,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            width: 4.0,
            height: 4.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Divider(
              height: 0.5,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
