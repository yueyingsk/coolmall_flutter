import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:coolmall_flutter/shared/widgets/refresh/refresh_layout.dart';
import 'package:coolmall_flutter/shared/widgets/text/price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coolmall_flutter/shared/widgets/image/network_image.dart';
import 'package:coolmall_flutter/shared/widgets/swiper/swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RefreshController controller = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: RefreshLayout(
          controller: controller,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildBanner(context)),
              SliverToBoxAdapter(child: _buildCouponSection(context)),
              SliverToBoxAdapter(child: _buildCategory(context)),
              SliverToBoxAdapter(child: _buildFlashSale(context)),
              SliverToBoxAdapter(child: _buildRecommendGoods(context)),
              SliverToBoxAdapter(child: _buildAllGoods(context)),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建AppBar
  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  /// 构建轮播图
  Widget _buildBanner(BuildContext context) {
    final List<String> bannerImages = [
      'https://via.placeholder.com/800x400/FF5733/FFFFFF?text=Banner+1',
      'https://via.placeholder.com/800x400/33FF57/FFFFFF?text=Banner+2',
      'https://via.placeholder.com/800x400/3357FF/FFFFFF?text=Banner+3',
    ];

    return SizedBox(
      width: double.infinity,
      height: 170,
      child: SimpleSwiper(
        items: bannerImages,
        autoplay: true,
        onTap: (index) {
          // 点击轮播图的回调
        },
        content: (context, index) {
          return NetworkImageWidget(
            imageUrl: bannerImages[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  /// 构建优惠券区域
  Widget _buildCouponSection(BuildContext context) {
    final List<Map<String, dynamic>> coupons = [
      {'title': '满100减20优惠券', 'id': 1},
      {'title': '满200减50优惠券', 'id': 2},
      {'title': '满300减100优惠券', 'id': 3},
    ];

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
                            item['title'],
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
  Widget _buildCategory(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'name': '手机',
        'icon': 'https://via.placeholder.com/50/FF5733/FFFFFF?text=手机',
        'id': 1,
      },
      {
        'name': '电脑',
        'icon': 'https://via.placeholder.com/50/33FF57/FFFFFF?text=电脑',
        'id': 2,
      },
      {
        'name': '家电',
        'icon': 'https://via.placeholder.com/50/3357FF/FFFFFF?text=家电',
        'id': 3,
      },
      {
        'name': '服装',
        'icon': 'https://via.placeholder.com/50/FF33A8/FFFFFF?text=服装',
        'id': 4,
      },
      {
        'name': '食品',
        'icon': 'https://via.placeholder.com/50/FFC300/FFFFFF?text=食品',
        'id': 5,
      },
      {
        'name': '美妆',
        'icon': 'https://via.placeholder.com/50/900C3F/FFFFFF?text=美妆',
        'id': 6,
      },
      {
        'name': '运动',
        'icon': 'https://via.placeholder.com/50/1ABC9C/FFFFFF?text=运动',
        'id': 7,
      },
      {
        'name': '母婴',
        'icon': 'https://via.placeholder.com/50/3498DB/FFFFFF?text=母婴',
        'id': 8,
      },
      // 这里可以添加更多分类，演示第二行不足5个的情况
    ];

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
  Widget _buildCategoryItem(
    BuildContext context,
    Map<String, dynamic>? category,
  ) {
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
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
            child: NetworkImageWidget(
              width: 60,
              height: 60,
              imageUrl: category['icon'],
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(category['name'], style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> goods = [
    {
      'name': 'iPhone 15',
      'price': '5999',
      'image': 'https://via.placeholder.com/100x100',
      'id': 1,
    },
    {
      'name': 'Samsung S24',
      'price': '4999',
      'image': 'https://via.placeholder.com/100x100',
      'id': 2,
    },
    {
      'name': 'Xiaomi 14',
      'price': '3999',
      'image': 'https://via.placeholder.com/100x100',
      'id': 3,
    },
    {
      'name': 'Huawei P60',
      'price': '4999',
      'image': 'https://via.placeholder.com/100x100',
      'id': 4,
    },
  ];

  /// 构建限时精选区域
  Widget _buildFlashSale(BuildContext context) {
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
            height: 192,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: goods.length,
              itemBuilder: (context, index) {
                return _buildFlashSaleItem(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSaleItem(BuildContext context, int index) {
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: NetworkImageWidget(
                imageUrl: goods[index]['image'],
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              goods[index]['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            PriceText(
              price: int.parse(goods[index]['price']),
              integerTextSize: 14,
            ),
          ],
        ),
      ),
    );
  }

  /// 构建推荐商品区域
  Widget _buildRecommendGoods(BuildContext context) {
    final List<Map<String, dynamic>> goods = [
      {
        'name': '小米手环8',
        'price': '299',
        'image': 'https://via.placeholder.com/100x100',
        'id': 1,
      },
      {
        'name': 'AirPods Pro',
        'price': '1999',
        'image': 'https://via.placeholder.com/100x100',
        'id': 2,
      },
      {
        'name': 'MacBook Air',
        'price': '7999',
        'image': 'https://via.placeholder.com/100x100',
        'id': 3,
      },
    ];

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
              '推荐商品',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: NetworkImageWidget(
                        imageUrl: goodsItem['image'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            goodsItem['name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: Text(
                              goodsItem['name'],
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
                              PriceText(price: int.parse(goodsItem['price'])),
                              Text(
                                '已售666件',
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

  // 全部商品
  Widget _buildAllGoods(BuildContext context) {
    final List<Map<String, dynamic>> goods = [
      {
        'name': '商品1',
        'price': '100',
        'image': 'https://via.placeholder.com/100x100',
        'id': 1,
      },
      {
        'name': '商品2',
        'price': '200',
        'image': 'https://via.placeholder.com/100x100',
        'id': 2,
      },
      {
        'name': '商品3',
        'price': '300',
        'image': 'https://via.placeholder.com/100x100',
        'id': 3,
      },
      {
        'name': '商品4',
        'price': '400',
        'image': 'https://via.placeholder.com/100x100',
        'id': 4,
      },
      {
        'name': '商品5',
        'price': '500',
        'image': 'https://via.placeholder.com/100x100',
        'id': 5,
      },
      {
        'name': '商品6',
        'price': '600',
        'image': 'https://via.placeholder.com/100x100',
        'id': 6,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              '全部商品',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
          ),
          itemCount: goods.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              color: bgWhiteLight,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    // 跳转到商品详情页
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: NetworkImageWidget(
                            width: double.infinity,
                            imageUrl: goods[index]['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        goods[index]['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        goods[index]['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: textTertiaryLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceText(price: int.parse(goods[index]['price'])),
                          Text(
                            '已售666件',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
