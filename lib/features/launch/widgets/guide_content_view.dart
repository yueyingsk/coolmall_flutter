import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:coolmall_flutter/features/launch/models/guide_page_data.dart';
import 'package:coolmall_flutter/features/launch/widgets/guide_page_content.dart';
import 'package:coolmall_flutter/features/launch/widgets/page_indicator.dart';
import 'package:flutter/material.dart';

/// 引导页主内容组件
class GuideContentView extends StatelessWidget {
  /// 引导页数据列表
  final List<GuidePageData> guidePages;

  /// 当前页面索引
  final int currentPage;

  /// 是否为最后一页
  final bool isLastPage;

  /// 页面控制器
  final PageController pageController;

  /// 跳过按钮点击回调
  final VoidCallback onSkipClick;

  /// 下一页按钮点击回调
  final VoidCallback onNextClick;

  /// 页面切换回调
  final ValueChanged<int> onPageChanged;

  const GuideContentView({
    super.key,
    required this.guidePages,
    required this.currentPage,
    required this.isLastPage,
    required this.pageController,
    required this.onSkipClick,
    required this.onNextClick,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 顶部跳过按钮
          Positioned(
            top: MediaQuery.of(context).padding.top + 16.0,
            right: 16.0,
            child: TextButton(
              onPressed: onSkipClick,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8.0,
                ),
              ),
              child: Text(
                '跳过',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),

          // 主要内容区域
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 48.0), // 顶部占位
              // 水平分页器
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: guidePages.length,
                  onPageChanged: onPageChanged,
                  itemBuilder: (context, index) {
                    return GuidePageContent(pageData: guidePages[index]);
                  },
                ),
              ),

              // 页面指示器
              Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: PageIndicator(
                  pageCount: guidePages.length,
                  currentPage: currentPage,
                ),
              ),

              // 下一页/开始体验按钮
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isLastPage ? 160.0 : 120.0,
                  height: 48.0,
                  child: ElevatedButton(
                    onPressed: onNextClick,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDefault,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    ),
                    child: Text(
                      isLastPage ? '开始体验' : '继续',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
