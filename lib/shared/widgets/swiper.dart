import 'dart:async';

import 'package:flutter/material.dart';

/// 简单的横向切换轮播组件
///
/// @param items 轮播项数据列表
/// @param content 轮播项内容构建函数
/// @param autoplay 是否自动播放，默认为true
/// @param interval 自动播放间隔时间，默认为3000ms
/// @param onTap 点击轮播项回调
/// @param indicatorType 指示器类型，可选'none'、'dot'、'bar'，默认为'dot'
class SimpleSwiper<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) content;
  final bool autoplay;
  final Duration interval;
  final void Function(int index, T item)? onTap;
  final String indicatorType;

  const SimpleSwiper({
    super.key,
    required this.items,
    required this.content,
    this.autoplay = true,
    this.interval = const Duration(milliseconds: 3000),
    this.onTap,
    this.indicatorType = 'dot',
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
        bottom: 16.0,
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
                color: index == _currentPage ? Colors.white : Colors.white54,
                borderRadius: BorderRadius.circular(4.0),
              ),
            );
          }),
        ),
      );
    }

    // 默认使用bar类型
    return Positioned(
      bottom: 16.0,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 80.0,
          height: 4.0,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                left: _currentPage * (80.0 / widget.items.length),
                top: 0,
                bottom: 0,
                width: 80.0 / widget.items.length,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.items.length,
          scrollDirection: Axis.horizontal,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return GestureDetector(
              onTap: () => widget.onTap?.call(index, item),
              child: widget.content(context, index, item),
            );
          },
        ),
        _buildIndicator(),
      ],
    );
  }
}
