// 导航项枚举，封装导航配置信息
enum NavItem {
  home("主页", "assets/lottie/home.json"),
  category("分类", "assets/lottie/category.json"),
  cart("购物车", "assets/lottie/cart.json"),
  me("我的", "assets/lottie/me.json");

  final String label; // 导航项标签
  final String animationPath; // 动画文件路径

  const NavItem(this.label, this.animationPath);
}
