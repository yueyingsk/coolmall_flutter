/// 引导页数据模型
class GuidePageData {
  /// 引导页图片资源
  final String image;

  /// 引导页标题
  final String title;

  /// 引导页描述
  final String description;

  const GuidePageData({
    required this.image,
    required this.title,
    required this.description,
  });
}

/// 引导页数据列表
const List<GuidePageData> guidePageDataList = [
  GuidePageData(
    image: 'assets/drawable/ic_book_writer.svg',
    title: '青商城 - 开源电商学习项目',
    description: '100% Flutter 开发的现代化电商应用\n完全开源免费，助力开发者快速成长\n提供完整的代码参考和学习资源',
  ),
  GuidePageData(
    image: 'assets/drawable/ic_home_screen.svg',
    title: '全平台应用新体验',
    description:
        '基于Flutter构建全平台流畅界面\n采用Clean Architecture 架构\nGrouter、Provider等主流技术全整合',
  ),
  GuidePageData(
    image: 'assets/drawable/ic_add_to_cart.svg',
    title: '完整电商业务流程',
    description: '用户认证、商品展示、搜索分类\n购物车管理、订单支付全流程实现\n贴近真实商业场景的学习案例',
  ),
  GuidePageData(
    image: 'assets/drawable/ic_dev_productivity.svg',
    title: '模块化架构设计',
    description:
        '参考 Google Now in Android 最佳实践\n高内聚低耦合，便于维护与扩展\n适合学习与二次开发的优质项目',
  ),
];
