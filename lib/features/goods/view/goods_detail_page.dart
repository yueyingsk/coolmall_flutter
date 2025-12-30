import 'package:coolmall_flutter/core/network/entity/network_state.dart';
import 'package:coolmall_flutter/features/goods/widget/comment_item.dart';
import 'package:coolmall_flutter/shared/widgets/list/list_item.dart';
import 'package:coolmall_flutter/shared/widgets/loading/loading.dart';
import 'package:coolmall_flutter/shared/widgets/swiper/swiper.dart';
import 'package:coolmall_flutter/shared/widgets/image/network_image.dart';
import 'package:coolmall_flutter/shared/widgets/title/title_with_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../model/goods_detail.dart';
import '../state/goods_detail_state.dart';
import '../widget/goods_info_card.dart';
import '../widget/goods_action_bar.dart';
import '../widget/spec_select_modal.dart';
import '../widget/coupon_modal.dart';

/// Flutter版本商品详情页面
class GoodsDetailPage extends StatefulWidget {
  const GoodsDetailPage({super.key});

  @override
  State<GoodsDetailPage> createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  double _topBarAlpha = 0.0;

  @override
  void initState() {
    super.initState();

    // 监听滚动
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final scrollOffset = _scrollController.offset;
      final alpha = (scrollOffset / 200).clamp(0.0, 1.0);
      setState(() {
        _topBarAlpha = alpha;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<GoodsDetailState>(
          builder: (context, state, child) {
            return _buildContent(state);
          },
        ),
      ),
    );
  }

  Widget _buildContent(GoodsDetailState state) {
    switch (state.networkState) {
      case NetworkState.loading:
        return _buildLoadingView();
      case NetworkState.error:
        return _buildErrorView(state);
      case NetworkState.success:
        return _buildSuccessView(state);
    }
  }

  Widget _buildLoadingView() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [MiLoadingMobile(), SizedBox(height: 8), Text('加载中')],
        ),
      ),
    );
  }

  Widget _buildErrorView(GoodsDetailState state) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/drawable/ic_empty_network.svg',
              width: 64,
              height: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              '加载失败',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text(
              '网络连接异常，请检查网络后重试',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: state.retryLoad, child: const Text('重试')),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessView(GoodsDetailState state) {
    final goodsDetail = state.goodsDetail!;

    return Stack(
      children: [
        // 主内容区域 - 使用 CustomScrollView 实现懒加载
        Positioned.fill(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // 商品轮播图
              SliverToBoxAdapter(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SimpleSwiper(
                    items: goodsDetail.goodsInfo.pics,
                    autoplay: false,
                    content: (context, index) {
                      return NetworkImageWidget(
                        width: double.infinity,
                        imageUrl: goodsDetail.goodsInfo.pics[index],
                        fit: BoxFit.fitWidth,
                      );
                    },
                  ),
                ),
              ),

              // 内容区域
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),

                      // 商品信息卡片
                      GoodsInfoCard(
                        goodsDetail: goodsDetail,
                        selectedSpec: state.selectedSpec,
                        onShowCoupon: state.showCouponModal,
                        onShowSpecModal: state.showSpecModal,
                        specSelectionText: state.specSelectionText,
                      ),

                      const SizedBox(height: 12),

                      // 商品配送信息
                      _buildDeliveryInfo(),

                      const SizedBox(height: 12),

                      // 商品评价
                      if (goodsDetail.comment.isNotEmpty)
                        _buildCommentInfo(goodsDetail, state),

                      const SizedBox(height: 12),
                      if (goodsDetail.goodsInfo.contentPics.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppListItem(
                                title: "",
                                showArrow: false,
                                showDivider: false,
                                leadingContent: TitleWithLine(title: "商品详情"),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // 商品详情图片使用独立的 SliverList 实现真正的懒加载
              if (goodsDetail.goodsInfo.contentPics.isNotEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final pic = goodsDetail.goodsInfo.contentPics[index];
                      if (index ==
                          goodsDetail.goodsInfo.contentPics.length - 1) {
                        return NetworkImageWidget(
                          imageUrl: pic,
                          cornerRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        );
                      }
                      return NetworkImageWidget(imageUrl: pic);
                    }, childCount: goodsDetail.goodsInfo.contentPics.length),
                  ),
                ),

              // 底部间距
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),

        // 顶部导航栏（动态透明度）
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 56,
            padding: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: _topBarAlpha),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/drawable/ic_left.svg",
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: state.shareGoods,
                  child: Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/drawable/ic_share_triangle.svg",
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // 底部操作栏
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: GoodsActionBar(
            hasAnimated: state.hasAnimated,
            onAddToCartClick: state.showSpecModal,
            onBuyNowClick: state.showSpecModal,
            onCsClick: state.navigateToCustomerService,
            onCartClick: state.navigateToCart,
          ),
        ),

        if (state.isSpecModalVisible)
          /// 规格选择弹窗
          SpecSelectModal(
            goods: goodsDetail.goodsInfo,
            specs: state.specs,
            selectedSpec: state.selectedSpec,
            onSpecSelected: state.selectSpec,
            onAddToCart: state.addToCart,
            onBuyNow: state.buyNow,
            onDismiss: state.hideSpecModal,
            onRetry: state.retryLoad,
          ),

        if (state.isCouponModalVisible)
          CouponModal(
            isVisible: state.isCouponModalVisible,
            coupons: goodsDetail.coupon,
            onCouponReceive: (coupon) => state.receiveCoupon(coupon.id),
            onDismiss: state.hideCouponModal,
          ),
      ],
    );
  }

  Widget _buildDeliveryInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          AppListItem(
            leadingContent: TitleWithLine(title: "发货与服务"),
            title: '',
            showArrow: false,
          ),
          AppListItem(title: "发货", trailingText: "云南省  昆明市", showArrow: false),
          AppListItem(
            title: "服务",
            trailingText: "7天无理由退货 · 运费险 · 48小时发货",
            showArrow: false,
            showDivider: false,
          ),
        ],
      ),
    );
  }

  /// 评价信息 - 使用 SliverList 实现懒加载
  Widget _buildCommentInfo(GoodsDetail goodsDetail, GoodsDetailState state) {
    // 用户评价
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppListItem(
            title: "",
            leadingContent: TitleWithLine(title: "商品评价"),
            trailingText: "查看全部",
          ),
          // 对于评论列表，限制高度以避免无限扩展
          ...goodsDetail.comment.map((comment) {
            return Column(
              children: [
                CommentItem(comment: comment),
                if (comment != goodsDetail.comment.last)
                  Divider(
                    height: 0.5,
                    color: Theme.of(context).colorScheme.outline,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
