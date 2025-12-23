import 'dart:async';

import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:flutter/material.dart';

/// 简单的横向切换轮播组件
///
/// @param items 轮播项数据列表
/// @param content 轮播项内容构建函数
/// @param autoplay 是否自动播放，默认为true
/// @param interval 自动播放间隔时间，默认为3000ms
/// @param onTap 点击轮播项回调
/// @param indicatorType 指示器类型，可选'none'、'dot'、'bar'，默认为'bar'
/// @param cornerRadius 轮播项的圆角半径，默认为null（无圆角）
class SimpleSwiper<T> extends StatefulWidget {
  final List items;
  final Widget Function(BuildContext context, int index) content;
  final bool autoplay;
  final Duration interval;
  final void Function(int index)? onTap;
  final String indicatorType;
  final BorderRadius? cornerRadius;

  const SimpleSwiper({
    super.key,
    required this.items,
    required this.content,
    this.autoplay = true,
    this.interval = const Duration(milliseconds: 3000),
    this.onTap,
    this.indicatorType = 'bar',
    this.cornerRadius,
  });

  @override
  State<SimpleSwiper> createState() => _SimpleSwiperState();
}

class _SimpleSwiperState extends State<SimpleSwiper> {
  late PageController _controller;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);

    if (widget.autoplay) {
      _startAutoPlay();
    }
  }

  @override
  void didUpdateWidget(covariant SimpleSwiper oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.autoplay != widget.autoplay) {
      if (widget.autoplay) {
        _startAutoPlay();
      } else {
        _stopAutoPlay();
      }
    }

    if (oldWidget.interval != widget.interval && widget.autoplay) {
      _stopAutoPlay();
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _stopAutoPlay();
    _timer = Timer.periodic(widget.interval, (timer) {
      _goToNextPage();
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }

  void _goToNextPage() {
    final int nextPage = (_currentPage + 1) % widget.items.length;
    _controller.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Widget _buildIndicator() {
    if (widget.indicatorType == 'none' || widget.items.length <= 1) {
      return const SizedBox();
    }

    if (widget.indicatorType == 'dot') {
      return Positioned(
        bottom: 10.0,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.items.length, (index) {
            return Container(
              width: index == _currentPage ? 16.0 : 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: index == _currentPage
                    ? primaryDefault.withValues(alpha: 0.6)
                    : primaryDefault.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4.0),
              ),
            );
          }),
        ),
      );
    }

    // 默认使用bar类型（与Compose版本一致）
    return Positioned(
      bottom: 10.0,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: widget.items.length * 16.0,
          height: 3.0,
          decoration: BoxDecoration(
            color: primaryDefault.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                left: _currentPage * 16.0,
                top: 0,
                bottom: 0,
                width: 16.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryDefault.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.cornerRadius ?? BorderRadius.zero,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            scrollDirection: Axis.horizontal,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => widget.onTap?.call(index),
                child: widget.content(context, index),
              );
            },
          ),
          _buildIndicator(),
        ],
      ),
    );
  }
}
