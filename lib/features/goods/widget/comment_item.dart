import 'package:coolmall_flutter/features/goods/model/goods_detail.dart';
import 'package:coolmall_flutter/shared/widgets/image/network_image.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/image/avatar.dart';
import '../../../shared/widgets/rate/we_rate.dart';

/// 评论Item组件 - 紧凑型布局
///
/// 设计特点：左侧头像+内容，右侧单张图片，多图显示数量标识
///
/// @param comment 评价数据
/// @param onClick 点击事件回调
class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment, this.onClick});

  final Comment comment;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 左侧：用户头像
            Avatar(avatarUrl: comment.avatarUrl, size: 32.0),

            const SizedBox(width: 12.0),

            // 中间：内容区域
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 用户昵称
                  Text(
                    comment.nickName.isEmpty ? '匿名用户' : comment.nickName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 4.0),

                  // 星级评分
                  WeRate(
                    value: comment.starCount,
                    count: 5,
                    size: 14.0,
                    animationEnabled: false,
                  ),

                  const SizedBox(height: 4.0),

                  // 评价文本内容
                  if (comment.content.isNotEmpty)
                    Text(
                      comment.content,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: null, // 不限制行数
                    ),
                ],
              ),
            ),

            // 右侧：图片区域
            if (comment.pics.isNotEmpty) ...[
              const SizedBox(width: 12.0),
              CommentImagePreview(images: comment.pics, size: 60.0),
            ],
          ],
        ),
      ),
    );
  }
}

/// 评论图片预览组件 - 单图显示，多图标识
///
/// @param images 图片URL列表
/// @param size 图片大小
class CommentImagePreview extends StatelessWidget {
  const CommentImagePreview({
    super.key,
    required this.images,
    this.size = 60.0,
  });

  final List<String> images;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 显示第一张图片
            if (images.isNotEmpty)
              NetworkImageWidget(
                imageUrl: images.first,
                fit: BoxFit.cover,
                cornerRadius: BorderRadius.circular(8.0),
              ),

            // 如果有多张图片，显示数量标识
            if (images.length > 1)
              Positioned(
                bottom: 4.0,
                right: 4.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '+${images.length - 1}',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 评论Item列表组件
///
/// 用于展示多个评论项
///
/// @param comments 评论列表
/// @param onCommentTap 单个评论项点击回调
class CommentList extends StatelessWidget {
  const CommentList({super.key, required this.comments, this.onCommentTap});

  final List<Comment> comments;
  final Function(Comment)? onCommentTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: comments.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final comment = comments[index];
        return CommentItem(
          comment: comment,
          onClick: onCommentTap != null ? () => onCommentTap!(comment) : null,
        );
      },
    );
  }
}
