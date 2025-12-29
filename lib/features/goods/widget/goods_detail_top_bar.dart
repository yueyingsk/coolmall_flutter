import 'package:flutter/material.dart';

/// 商品详情页顶部导航栏组件
class GoodsDetailTopBar extends StatefulWidget {
  final ScrollController? scrollController;
  final PageController? pageController;
  final int imageCount;
  final VoidCallback? onBack;
  final VoidCallback? onShare;
  final bool hasAnimated;

  const GoodsDetailTopBar({
    super.key,
    this.scrollController,
    this.pageController,
    required this.imageCount,
    this.onBack,
    this.onShare,
    this.hasAnimated = false,
  });

  @override
  State<GoodsDetailTopBar> createState() => _GoodsDetailTopBarState();
}

class _GoodsDetailTopBarState extends State<GoodsDetailTopBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _hasPlayedAnimation = false;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // 监听滚动控制器
    if (widget.scrollController != null) {
      widget.scrollController!.addListener(_onScroll);
    }

    // 监听页面控制器
    if (widget.pageController != null) {
      widget.pageController!.addListener(_onPageChanged);
    }

    // 触发动画
    _triggerAnimation();
  }

  @override
  void didUpdateWidget(GoodsDetailTopBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasAnimated && !_hasPlayedAnimation) {
      _triggerAnimation();
    }
  }

  void _triggerAnimation() {
    if (widget.hasAnimated && !_hasPlayedAnimation) {
      _hasPlayedAnimation = true;
      _animationController.forward();
    }
  }

  void _onScroll() {
    // 这里可以根据滚动位置更新透明度
    // 在主页面中统一处理
  }

  void _onPageChanged() {
    if (widget.pageController != null) {
      setState(() {
        _currentPage = widget.pageController!.page ?? 0.0;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 轮播图时的背景透明度
    final bannerOpacity =
        1.0 - (_currentPage / (widget.imageCount - 1)).clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: const Offset(0, -20),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                right: 16,
                bottom: 8,
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    // 返回按钮
                    GestureDetector(
                      onTap: widget.onBack,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(
                              alpha: 0.3 * bannerOpacity + 0.3,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // 页面指示器（在轮播模式下显示）
                    if (widget.pageController != null &&
                        widget.imageCount > 1) ...[
                      AnimatedOpacity(
                        opacity: bannerOpacity < 0.5 ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_currentPage.floor() + 1}/${widget.imageCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],

                    // 分享按钮
                    GestureDetector(
                      onTap: widget.onShare,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(
                              alpha: 0.3 * bannerOpacity + 0.3,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
