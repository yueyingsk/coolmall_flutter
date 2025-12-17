import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:coolmall_flutter/features/main/state/home_state.dart';
import 'package:coolmall_flutter/shared/widgets/refresh/scrollbar_refresh_layout.dart';
import 'package:coolmall_flutter/shared/widgets/text/price_text.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_svg/svg.dart';
import 'package:coolmall_flutter/shared/widgets/image/network_image.dart';
import 'package:coolmall_flutter/shared/widgets/swiper/swiper.dart';
import 'package:provider/provider.dart';
import 'package:coolmall_flutter/features/main/models/home_data.dart';
import 'package:coolmall_flutter/shared/widgets/waterfall_flow/goods_waterfall_flow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeState>().getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeState>(
        builder: (context, state, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ScrollbarRefreshLayout(
              onRefresh: state.refreshData,
              onLoading: state.loadMoreData,
              controller: state.refreshController,
              sliverAppBars: [_buildAppBar(context)],
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildBanner(context, state.homeData?.banner ?? []),
                  ),
                  SliverToBoxAdapter(
                    child: _buildCouponSection(
                      context,
                      state.homeData?.coupon ?? [],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _buildCategory(
                      context,
                      state.homeData?.category ?? [],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _buildFlashSale(
                      context,
                      state.homeData?.flashSale ?? [],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _buildAllGoodsTitle(context, "推荐商品"),
                  ),
                  SliverToBoxAdapter(
                    child: _buildRecommendGoods(
                      context,
                      state.homeData?.recommend ?? [],
                    ),
                  ),
                  // 全部商品标题
                  SliverToBoxAdapter(
                    child: _buildAllGoodsTitle(context, '全部商品'),
                  ),
                  // 全部商品列表（瀑布流）
                  GoodsWaterfallFlow(
                    goodsList: state.goods,
                    onItemTap: (goods) {
                      // 跳转到商品详情页
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建AppBar
  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      leadingWidth: 50,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SvgPicture.asset(
          width: 34,
          height: 34,
          'assets/drawable/ic_logo.svg',
        ),
      ),
      centerTitle: true,
      titleSpacing: 0,
      title: Container(
        width: double.infinity,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              width: 18,
              height: 18,
              'assets/drawable/ic_search.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '搜索商品',
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SvgPicture.asset(
            width: 27,
            height: 27,
            'assets/drawable/ic_github.svg',
          ),
        ),
      ],
      floating: true,
      pinned: false,
      snap: false,
      elevation: 0,
    );
  }

  /// 构建轮播图
  Widget _buildBanner(BuildContext context, List<Banner> banner) {
    return SizedBox(
      width: double.infinity,
      height: 170,
      child: SimpleSwiper(
        items: banner,
        autoplay: true,
        onTap: (index) {
          // 点击轮播图的回调
        },
        content: (context, index) {
          return NetworkImageWidget(
            imageUrl: banner[index].pic,
            fit: BoxFit.cover,
            cornerRadius: BorderRadius.circular(12),
          );
        },
      ),
    );
  }

  /// 构建优惠券区域
  Widget _buildCouponSection(BuildContext context, List<Coupon> coupons) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 30,
                child: SimpleSwiper(
                  items: coupons,
                  autoplay: true,
                  indicatorType: 'none',
                  content: (context, index) {
                    final item = coupons[index];
                    return Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                          ),
                          child: SvgPicture.asset(
                            width: 18,
                            height: 18,
                            'assets/drawable/ic_coupon.svg',
                            colorFilter: ColorFilter.mode(
                              Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.9),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 1,
              height: 20,
              color: Colors.grey.withValues(alpha: 0.3),
            ),
            const SizedBox(width: 12),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                // 显示优惠券弹窗
              },
              child: Text(
                '领取',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建分类区域
  Widget _buildCategory(BuildContext context, List<Banner> categories) {
    // 计算需要的行数
    final int rows = (categories.length / 5).ceil();

    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Column(
          spacing: 4,
          children: [
            for (int row = 0; row < rows; row++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int col = 0; col < 5; col++)
                    Expanded(
                      child: _buildCategoryItem(
                        context,
                        row * 5 + col < categories.length
                            ? categories[row * 5 + col]
                            : null, // 传递null表示空白项
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  /// 构建单个分类项
  Widget _buildCategoryItem(BuildContext context, Banner? category) {
    // 如果是空白项，返回空容器
    if (category == null) {
      return Container();
    }

    return GestureDetector(
      onTap: () {
        // 跳转到分类页
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: NetworkImageWidget(
              width: 60,
              height: 60,
              imageUrl: category.pic,
              fit: BoxFit.cover,
              cornerRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 4),
          Text(category.name ?? '', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  /// 构建限时精选区域
  Widget _buildFlashSale(BuildContext context, List<Goods> goods) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      width: 20,
                      height: 20,
                      'assets/drawable/ic_time.svg',
                    ),
                    const SizedBox(width: 8),
                    Text('限时精选', style: TextStyle(fontSize: 14)),
                  ],
                ),
                Text(
                  '查看全部',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 0.5, color: Theme.of(context).colorScheme.outline),
          Container(
            padding: EdgeInsetsGeometry.all(12),
            height: 195,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: goods.length,
              itemBuilder: (context, index) {
                return _buildFlashSaleItem(context, index, goods);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSaleItem(
    BuildContext context,
    int index,
    List<Goods> goods,
  ) {
    return GestureDetector(
      onTap: () {
        // 跳转到商品详情页
      },
      child: Container(
        margin: EdgeInsetsGeometry.only(
          right: index == goods.length - 1 ? 0 : 8,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NetworkImageWidget(
              imageUrl: goods[index].mainPic,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              cornerRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 4),
            Text(
              goods[index].title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            PriceText(price: goods[index].price, integerTextSize: 14),
          ],
        ),
      ),
    );
  }

  /// 构建推荐商品区域
  Widget _buildRecommendGoods(BuildContext context, List<Goods> goods) {
    return Column(
      children: [
        for (var goodsItem in goods)
          GestureDetector(
            onTap: () {
              // 跳转到商品详情页
            },
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Container(
                height: 116,
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    NetworkImageWidget(
                      imageUrl: goodsItem.mainPic,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      cornerRadius: BorderRadius.circular(8),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            goodsItem.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: Text(
                              goodsItem.subTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: textTertiaryLight,
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PriceText(price: goodsItem.price),
                              Text(
                                '已售${goodsItem.sold}件',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget? _buildAllGoodsTitle(BuildContext context, String title) {
    return Column(
      children: [
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 4),
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
