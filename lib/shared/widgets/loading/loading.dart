import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

///小米风格加载动画
class MiLoadingMobile extends StatefulWidget {
  final double size;
  final Color color;
  final bool isAnimating; // 是否播放动画

  const MiLoadingMobile({
    super.key,
    this.size = 24.0,
    this.color = Colors.black,
    this.isAnimating = true,
  });

  @override
  State<MiLoadingMobile> createState() => _MiLoadingMobileState();
}

class _MiLoadingMobileState extends State<MiLoadingMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // 根据isAnimating参数决定是否播放动画
    if (widget.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant MiLoadingMobile oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 当isAnimating参数变化时，控制动画的播放和停止
    if (widget.isAnimating != oldWidget.isAnimating) {
      if (widget.isAnimating) {
        _controller.repeat();
      } else {
        // 停止动画时，保持当前动画值不变
        _controller.stop();
        // 等待1.5秒后，将动画值重置为0
        // Future.delayed(const Duration(milliseconds: 1500), () {
        //   setState(() {
        //     _controller.value = 0.0;
        //   });
        // });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _LoadingMobilePainter(
              color: widget.color,
              angle: _controller.value * 360,
              strokeWidth: widget.size / 12,
            ),
          );
        },
      ),
    );
  }
}

class _LoadingMobilePainter extends CustomPainter {
  final Color color;
  final double angle;
  final double strokeWidth;

  _LoadingMobilePainter({
    required this.color,
    required this.angle,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // 绘制圆形边框
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - strokeWidth,
      paint,
    );

    // 绘制旋转圆点
    final radius = size.width / 2 - strokeWidth * 4;
    final radians = angle * 3.14159265 / 180;
    final center = Offset(size.width / 2, size.height / 2);
    final dotX = center.dx + radius * cos(radians);
    final dotY = center.dy + radius * sin(radians);

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(dotX, dotY), strokeWidth * 1.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _LoadingMobilePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.angle != angle;
  }
}

/// 基于SVG的加载动画组件
class WeLoading extends StatefulWidget {
  final double size;
  final Color? color;
  final bool isRotating; // 是否播放旋转动画

  const WeLoading({
    super.key,
    this.size = 16.0,
    this.color,
    this.isRotating = true,
  });

  @override
  State<WeLoading> createState() => _WeLoadingState();
}

/// 基于SVG的加载动画组件
class _WeLoadingState extends State<WeLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    // 创建动画控制器，持续时间1000毫秒
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // 创建旋转动画，从0度到360度，线性插值
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 360.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    // 根据isRotating参数决定是否开始动画
    if (widget.isRotating) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant WeLoading oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 当isRotating参数变化时，控制动画的播放和停止
    if (widget.isRotating != oldWidget.isRotating) {
      if (widget.isRotating) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value * (3.14159265 / 180), // 转换为弧度
            child: widget.color == null
                ? SvgPicture.asset(
                    'assets/drawable/ic_loading.svg',
                    width: widget.size,
                    height: widget.size,
                  )
                : SvgPicture.asset(
                    'assets/drawable/ic_loading.svg',
                    width: widget.size,
                    height: widget.size,
                    colorFilter: ColorFilter.mode(
                      widget.color!,
                      BlendMode.srcIn,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
