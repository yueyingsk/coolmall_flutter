import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../loading/loading.dart';

/// 带加载状态的网络图片组件
///
/// 该组件封装了网络图片加载功能，提供了加载中、加载失败、加载成功三种状态的UI显示。
///
/// @param imageUrl 图片资源URL
/// @param modifier 应用于整个组件的修饰符
/// @param size 图片大小，设置宽高相等的尺寸。如果为null，则不设置大小
/// @param contentScale 图片的内容缩放模式，默认为Crop
/// @param loadingColor 加载动画的颜色
/// @param errorColor 错误图标的颜色，默认为灰色
/// @param onErrorClick 图片加载失败时点击错误图标的回调，如果为null则不显示可点击的图标
/// @param showBackground 是否显示背景颜色，默认为false
/// @param backgroundColor 背景颜色，默认为ThemeData.scaffoldBackgroundColor
/// @param cornerRadius 圆角半径，默认为null（无圆角）
class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final Widget Function(BuildContext)? loadingWidget;
  final Widget Function(BuildContext)? errorWidget;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? loadingColor;
  final Color errorColor;
  final VoidCallback? onErrorClick;
  final bool showBackground;
  final Color backgroundColor;
  final BorderRadius? cornerRadius;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.loadingWidget,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.loadingColor,
    this.errorColor = Colors.grey,
    this.onErrorClick,
    this.showBackground = false,
    this.backgroundColor = Colors.transparent,
    this.cornerRadius,
  });

  @override
  Widget build(BuildContext context) {
    // 处理背景颜色
    final bgColor = showBackground ? backgroundColor : Colors.transparent;

    // 构建容器修饰符
    final containerDecoration = BoxDecoration(
      color: bgColor,
      borderRadius: cornerRadius,
    );

    return Container(
      width: width,
      height: height,
      decoration: containerDecoration,
      child: ClipRRect(
        borderRadius: cornerRadius ?? BorderRadius.zero,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
          placeholder: (context, url) => _buildLoadingWidget(context),
          errorWidget: (context, url, error) => _buildErrorWidget(context),
        ),
      ),
    );
  }

  /// 构建加载中状态的Widget
  Widget _buildLoadingWidget(BuildContext context) {
    if (loadingWidget != null) {
      return loadingWidget!(context);
    }

    return Center(child: WeLoading(size: 24.0, color: loadingColor));
  }

  /// 构建加载错误状态的Widget
  Widget _buildErrorWidget(BuildContext context) {
    if (errorWidget != null) {
      return errorWidget!(context);
    }

    final errorIcon = SvgPicture.asset(
      'assets/drawable/ic_error.svg',
      colorFilter: ColorFilter.mode(errorColor, BlendMode.srcIn),
      width: 24,
      height: 24,
    );

    if (onErrorClick != null) {
      return Center(
        child: GestureDetector(onTap: onErrorClick, child: errorIcon),
      );
    }

    return Center(child: errorIcon);
  }
}

/// 带SVG支持的网络图片组件
///
/// 该组件支持加载网络图片和SVG图片
class NetworkSvgImageWidget extends StatelessWidget {
  final String imageUrl;
  final Widget Function(BuildContext)? loadingWidget;
  final Widget Function(BuildContext)? errorWidget;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final Color loadingColor;
  final Color errorColor;
  final VoidCallback? onErrorClick;
  final bool showBackground;
  final Color backgroundColor;
  final BorderRadius? cornerRadius;

  const NetworkSvgImageWidget({
    super.key,
    required this.imageUrl,
    this.loadingWidget,
    this.errorWidget,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.loadingColor = Colors.blue,
    this.errorColor = Colors.grey,
    this.onErrorClick,
    this.showBackground = false,
    this.backgroundColor = Colors.transparent,
    this.cornerRadius,
  });

  @override
  Widget build(BuildContext context) {
    // 处理背景颜色
    final bgColor = showBackground ? backgroundColor : Colors.transparent;

    // 构建容器修饰符
    final containerDecoration = BoxDecoration(
      color: bgColor,
      borderRadius: cornerRadius,
    );

    return Container(
      width: width,
      height: height,
      decoration: containerDecoration,
      child: ClipRRect(
        borderRadius: cornerRadius ?? BorderRadius.zero,
        child: FutureBuilder<Widget>(
          future: _loadSvgImage(),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 加载中
              return _buildLoadingWidget(context);
            } else if (snapshot.hasError) {
              // 加载失败
              return _buildErrorWidget(context);
            } else {
              // 加载成功
              return snapshot.data ?? const SizedBox();
            }
          },
        ),
      ),
    );
  }

  /// 加载SVG图片
  Future<Widget> _loadSvgImage() async {
    try {
      // 使用flutter_svg加载网络SVG图片
      return SvgPicture.network(
        imageUrl,
        width: width,
        height: height,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        fit: fit,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// 构建加载中状态的Widget
  Widget _buildLoadingWidget(BuildContext context) {
    if (loadingWidget != null) {
      return loadingWidget!(context);
    }

    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
      ),
    );
  }

  /// 构建加载错误状态的Widget
  Widget _buildErrorWidget(BuildContext context) {
    if (errorWidget != null) {
      return errorWidget!(context);
    }

    final errorIcon = SvgPicture.asset(
      'assets/drawable/ic_error.svg',
      colorFilter: ColorFilter.mode(errorColor, BlendMode.srcIn),
      width: 24,
      height: 24,
    );

    if (onErrorClick != null) {
      return Center(
        child: GestureDetector(onTap: onErrorClick, child: errorIcon),
      );
    }

    return Center(child: errorIcon);
  }
}
