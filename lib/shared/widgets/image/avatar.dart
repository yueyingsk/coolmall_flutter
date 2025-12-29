import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'network_image.dart';

/// 用户头像组件
///
/// 该组件封装了用户头像的显示逻辑，支持登录和未登录状态：
/// - 未登录状态：显示默认头像（白色背景 + 用户图标）
/// - 登录状态：显示用户的网络头像
/// - 支持点击事件
///
/// @param avatarUrl 用户头像URL，为空或null时显示默认头像
/// @param size 头像大小，默认为36.0
/// @param onClick 点击头像的回调
/// @param showBorder 是否显示边框，默认为false
/// @param borderColor 边框颜色
/// @param borderWidth 边框宽度
class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.avatarUrl,
    this.size = 36.0,
    this.onClick,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  final String? avatarUrl;
  final double size;
  final VoidCallback? onClick;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final shouldShowDefaultAvatar = avatarUrl == null || avatarUrl!.isEmpty;

    final avatarWidget = shouldShowDefaultAvatar
        ? _buildDefaultAvatar(context)
        : _buildNetworkAvatar(context);

    final borderDecoration = showBorder
        ? BoxDecoration(
            border: Border.all(
              color: borderColor ?? Theme.of(context).dividerColor,
              width: borderWidth,
            ),
            shape: BoxShape.circle,
          )
        : null;

    final contentWidget = Container(
      width: size,
      height: size,
      decoration: borderDecoration,
      child: ClipOval(child: avatarWidget),
    );

    if (onClick != null) {
      return InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(size / 2),
        child: contentWidget,
      );
    }

    return contentWidget;
  }

  /// 构建默认头像（未登录状态）
  Widget _buildDefaultAvatar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/drawable/ic_my_fill.svg',
          width: size * 0.5,
          height: size * 0.5,
          colorFilter: ColorFilter.mode(
            Theme.of(
              context,
            ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  /// 构建网络头像（登录状态）
  Widget _buildNetworkAvatar(BuildContext context) {
    return NetworkImageWidget(
      imageUrl: avatarUrl!,
      width: size,
      height: size,
      fit: BoxFit.cover,
      showBackground: false,
      cornerRadius: null, // 圆形头像不需要圆角
    );
  }
}

/// 小尺寸头像组件
///
/// 适用于聊天界面等需要小头像的场景
///
/// @param avatarUrl 用户头像URL
/// @param onClick 点击头像的回调
/// @param showBorder 是否显示边框
class SmallAvatar extends StatelessWidget {
  const SmallAvatar({
    super.key,
    this.avatarUrl,
    this.onClick,
    this.showBorder = false,
  });

  final String? avatarUrl;
  final VoidCallback? onClick;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Avatar(
      avatarUrl: avatarUrl,
      size: 24.0,
      onClick: onClick,
      showBorder: showBorder,
    );
  }
}

/// 中等尺寸头像组件
///
/// 适用于个人资料页面等场景
///
/// @param avatarUrl 用户头像URL
/// @param onClick 点击头像的回调
/// @param showBorder 是否显示边框
class MediumAvatar extends StatelessWidget {
  const MediumAvatar({
    super.key,
    this.avatarUrl,
    this.onClick,
    this.showBorder = false,
  });

  final String? avatarUrl;
  final VoidCallback? onClick;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Avatar(
      avatarUrl: avatarUrl,
      size: 48.0,
      onClick: onClick,
      showBorder: showBorder,
    );
  }
}

/// 大尺寸头像组件
///
/// 适用于头像上传、详情页等场景
///
/// @param avatarUrl 用户头像URL
/// @param onClick 点击头像的回调
/// @param showBorder 是否显示边框
class LargeAvatar extends StatelessWidget {
  const LargeAvatar({
    super.key,
    this.avatarUrl,
    this.onClick,
    this.showBorder = true,
  });

  final String? avatarUrl;
  final VoidCallback? onClick;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Avatar(
      avatarUrl: avatarUrl,
      size: 80.0,
      onClick: onClick,
      showBorder: showBorder,
      borderColor: Theme.of(context).dividerColor,
      borderWidth: 1.0,
    );
  }
}
