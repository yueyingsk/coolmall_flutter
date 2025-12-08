import 'package:coolmall_flutter/features/launch/models/guide_page_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 引导页单个页面内容组件
class GuidePageContent extends StatelessWidget {
  /// 引导页数据
  final GuidePageData pageData;

  /// 修饰符
  final EdgeInsets padding;

  const GuidePageContent({
    super.key,
    required this.pageData,
    this.padding = const EdgeInsets.symmetric(horizontal: 40.0),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 引导页图片
          SvgPicture.asset(
            pageData.image,
            width: 240.0,
            height: 240.0,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 32.0),
          // 标题 - 粗体，居中
          Text(
            pageData.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0, 
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24.0),
          // 描述 - 次要文本，居中
          Padding(
            padding: padding,
            child: Text(
              pageData.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0, 
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
