import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// 通用列表项组件
/// @param title 标题文本
/// @param leadingIcon 前置图标
/// @param leadingIconTint 前置图标颜色
/// @param leadingContent 自定义前置内容，优先级高于leadingIcon
/// @param description 描述文本
/// @param trailingText 尾部文本
/// @param trailingContent 自定义尾部内容，优先级高于trailingText
/// @param showArrow 是否显示右箭头，默认为true
/// @param showDivider 是否显示底部分隔线，默认为true
/// @param verticalPadding 垂直内边距
/// @param horizontalPadding 水平内边距
/// @param onClick 点击回调
class AppListItem extends StatelessWidget {
  const AppListItem({
    super.key,
    required this.title,
    this.leadingIcon,
    this.leadingIconTint,
    this.leadingContent,
    this.description,
    this.trailingText,
    this.trailingContent,
    this.showArrow = true,
    this.showDivider = true,
    this.verticalPadding,
    this.horizontalPadding,
    this.onClick,
  });

  final String title;
  final IconData? leadingIcon;
  final Color? leadingIconTint;
  final Widget? leadingContent;
  final String? description;
  final String? trailingText;
  final Widget? trailingContent;
  final bool showArrow;
  final bool showDivider;
  final double? verticalPadding;
  final double? horizontalPadding;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onClick,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding ?? 12.0,
              horizontal: horizontalPadding ?? 12.0,
            ),
            child: Row(
              children: [
                // 前置内容：自定义内容或图标
                if (leadingContent != null)
                  leadingContent!
                else if (leadingIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(leadingIcon, size: 20, color: leadingIconTint),
                  ),

                // 标题和描述
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // 描述文本（如果有）
                      if (description != null && description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            description!,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.75),
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),

                // 尾部内容
                if (trailingContent != null)
                  trailingContent!
                else if (trailingText != null && trailingText!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      trailingText!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.75),
                      ),
                    ),
                  ),

                // 右箭头
                if (showArrow)
                  SvgPicture.asset(
                    'assets/drawable/ic_right.svg',
                    width: 16,
                    height: 16,
                  ),
              ],
            ),
          ),
        ),

        // 底部分隔线
        if (showDivider)
          Divider(height: 0.5, color: Theme.of(context).colorScheme.outline),
      ],
    );
  }
}

/// 带有标题的分组列表项
/// @param title 标题文本
/// @param items 列表项内容
/// @param showDivider 是否显示底部分隔线，默认为true
class GroupAppListItem extends StatelessWidget {
  const GroupAppListItem({
    super.key,
    required this.title,
    required this.items,
    this.showDivider = true,
  });

  final String title;
  final List<Widget> items;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 分组标题
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade400),
          ),
        ),

        // 列表项
        Container(
          color: Theme.of(context).colorScheme.surface,
          child: Column(children: items),
        ),

        if (showDivider) const SizedBox(height: 8.0),
      ],
    );
  }
}

/// 无点击效果的列表项
/// @param title 标题文本
/// @param leadingIcon 前置图标
/// @param leadingIconTint 前置图标颜色
/// @param leadingContent 自定义前置内容，优先级高于leadingIcon
/// @param description 描述文本
/// @param showDivider 是否显示底部分隔线，默认为false
/// @param verticalPadding 垂直内边距
/// @param horizontalPadding 水平内边距
class StaticAppListItem extends StatelessWidget {
  const StaticAppListItem({
    super.key,
    required this.title,
    this.leadingIcon,
    this.leadingIconTint,
    this.leadingContent,
    this.description,
    this.showDivider = false,
    this.verticalPadding,
    this.horizontalPadding,
  });

  final String title;
  final IconData? leadingIcon;
  final Color? leadingIconTint;
  final Widget? leadingContent;
  final String? description;
  final bool showDivider;
  final double? verticalPadding;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 16.0,
            horizontal: horizontalPadding ?? 16.0,
          ),
          child: Row(
            children: [
              // 前置内容：自定义内容或图标
              if (leadingContent != null)
                leadingContent!
              else if (leadingIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(leadingIcon, size: 20, color: leadingIconTint),
                ),

              // 标题和描述
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.bodyLarge),

                    // 描述文本（如果有）
                    if (description != null && description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          description!,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 底部分隔线
        if (showDivider) const Divider(),
      ],
    );
  }
}
