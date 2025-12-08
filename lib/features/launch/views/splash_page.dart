import 'package:coolmall_flutter/features/launch/viewmodel/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  // 动画控制器
  late AnimationController _animationController;

  // Logo 动画
  late Animation<double> _logoOffsetY;
  late Animation<double> _logoRotation;
  late Animation<double> _logoAlpha;

  // 文本动画
  late Animation<double> _textAlpha;

  // 背景模糊动画
  late Animation<double> _backgroundBlur;

  @override
  void initState() {
    super.initState();
    // 初始化动画控制器
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // 配置 Logo 动画
    _logoOffsetY = Tween<double>(begin: 160.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.83), // 1000ms / 1200ms
      ),
    );

    _logoRotation = Tween<double>(begin: -15.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.83),
      ),
    );

    _logoAlpha = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.67), // 800ms / 1200ms
      ),
    );

    // 配置文本动画
    _textAlpha = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.33, 1.0), // 400ms delay, 800ms duration
      ),
    );

    // 配置背景模糊动画
    _backgroundBlur = Tween<double>(begin: 0.0, end: 50.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.83), // 与logo动画同步
      ),
    );

    // 启动动画
    _animationController.forward();

    // 延迟导航
    _startNavigation();
  }

  void _startNavigation() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        context.read<SplashViewModel>().checkAndNavigate(context);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SizedBox.expand(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 背景模糊 Logo
              _buildBackgroundLogo(),

              // 前景内容
              _buildForegroundContent(),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建背景模糊 Logo
  Widget _buildBackgroundLogo() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Center(
          child: Opacity(
            opacity: 0.8,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: _backgroundBlur.value,
                sigmaY: _backgroundBlur.value,
              ),
              child: SvgPicture.asset(
                'assets/drawable/ic_logo.svg',
                width: 240,
                height: 240,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  /// 构建前景内容
  Widget _buildForegroundContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 上方空白区域
        const Spacer(),

        // 前景 Logo
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _logoOffsetY.value),
              child: Transform.rotate(
                angle: _logoRotation.value * 3.1415926535 / 180, // 转换为弧度
                child: Opacity(
                  opacity: _logoAlpha.value,
                  child: SvgPicture.asset(
                    'assets/drawable/ic_logo.svg',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ),

        const Spacer(),

        // 文本内容
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _textAlpha.value,
              child: Column(
                children: [
                  Text(
                    '青商城',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '© 2025 Yueyingsk & CoolMallFlutter Contributors',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        // 底部边距
        const SizedBox(height: 32),
      ],
    );
  }
}
