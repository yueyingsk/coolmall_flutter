import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:coolmall_flutter/features/goods/state/goods_category_state.dart';
import 'package:coolmall_flutter/features/goods/widget/filter_bar.dart';
import 'package:coolmall_flutter/features/goods/widget/filter_dialog.dart';
import 'package:coolmall_flutter/features/main/model/home_data.dart';
import 'package:coolmall_flutter/shared/widgets/image/network_image.dart';
import 'package:coolmall_flutter/shared/widgets/refresh/scrollbar_refresh_layout.dart';
import 'package:coolmall_flutter/shared/widgets/text/price_text.dart';
import 'package:coolmall_flutter/shared/widgets/waterfall_flow/sliver_goods_waterfall_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class GoodsCategoryPage extends StatefulWidget {
  const GoodsCategoryPage({super.key});

  @override
  State<GoodsCategoryPage> createState() => _GoodsCategoryPageState();
}

class _GoodsCategoryPageState extends State<GoodsCategoryPage> {
  final GlobalKey _filterButtonKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  // 当前AppBar可见性
  bool _currentAppBarVisible = true;
  //记录上一次状态变化后偏移的极值，以此为标准来计算偏移量
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    // 监听滚动事件，通过滚动偏移量判断AppBar可见性
    _scrollController.addListener(() {
      // print(_scrollController.offset);
      if (_currentAppBarVisible) {
        // 当AppBar可见时，往上滑动偏移量增大，触发隐藏AppBar，30是阈值
        if (_scrollController.offset - 30 > _lastScrollOffset) {
          updateScrollInfo(true);
        }
        //appbar可见时，继续往下滑动，将偏移量的极值更新为当前偏移量，如果往上滑动，则不更新
        if (_scrollController.offset < _lastScrollOffset) {
          updateScrollInfo(false);
        }
      } else {
        // 当AppBar不可见时，往下滑动偏移量减小，触发显示AppBar，30是阈值
        if (_scrollController.offset + 30 < _lastScrollOffset) {
          updateScrollInfo(true);
        }
        //appbar不可见时，继续往上滑动，将偏移量的极值更新为当前偏移量，如果往下滑动，则不更新
        if (_scrollController.offset > _lastScrollOffset) {
          updateScrollInfo(false);
        }
      }
    });
    context.read<GoodsCategoryState>().getGoodsListData();
  }

  @override
  void dispose() {
    context.read<GoodsCategoryState>().refreshController.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GoodsCategoryState>(
        builder: (context, state, child) {
          return ScrollbarRefreshLayout(
            onRefresh: state.refreshData,
            onLoading: state.loadMoreData,
            controller: state.refreshController,
            scrollController: _scrollController,
            sliverAppBars: [
              _buildAppBar(context),
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: _FilterBarDelegate(
                  child: FilterBar(
                    currentSortType: state.sortState.currentSortType,
                    currentSortState: state.sortState.currentSortState,
                    filtersVisible: state.sortState.isFilterVisible,
                    onSortClick: (sortType) {
                      state.updateSortType(sortType);
                    },
                    onFiltersClick: () {
                      _showFilterDialog();
                    },
                    onToggleLayout: () {
                      state.toggleViewType();
                    },
                    isGridLayout: !state.sortState.isListView,
                    isAppBarVisible: state.isAppBarVisible,
                    filterButtonKey: _filterButtonKey,
                  ),
                ),
              ),
            ],
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  sliver: state.sortState.isListView
                      ? _buildListView(state.goods)
                      : _buildWaterfallFlow(state.goods),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 构建AppBar
  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      leadingWidth: 40,
      leading: Padding(
        padding: const EdgeInsets.all(6),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            'assets/drawable/ic_left.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onSurface,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Container(
        width: double.infinity,
        height: 42,
        padding: EdgeInsets.only(left: 16, right: 4, top: 4, bottom: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), // 圆形边框，半径为高度的一半
          color: Theme.of(context).colorScheme.surfaceContainerHighest, // 浅色背景
        ),
        child: Row(
          children: [
            // 搜索图标
            SvgPicture.asset(
              'assets/drawable/ic_search.svg',
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurfaceVariant,
                BlendMode.srcIn,
              ),
            ),
            // 输入框
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: '输入内容进行搜索',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  hintStyle: TextStyle(fontSize: 14),
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                onChanged: (value) {
                  // 更新状态中的搜索文本
                  context.read<GoodsCategoryState>().updateSearchText(value);
                },
                onSubmitted: (value) {
                  // 执行搜索
                  context.read<GoodsCategoryState>().performSearch();
                },
              ),
            ),
            // 搜索按钮
            Container(
              height: 34, // 与搜索框高度一致
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), // 圆形边框，半径为高度的一半
                color: Theme.of(context).colorScheme.primary,
              ),
              child: GestureDetector(
                onTap: () {
                  // 执行搜索
                  context.read<GoodsCategoryState>().performSearch();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Center(
                    child: Text(
                      '搜索',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () {
              context.read<GoodsCategoryState>().toggleViewType();
            },
            child: SvgPicture.asset(
              context.read<GoodsCategoryState>().sortState.isListView
                  ? 'assets/drawable/ic_menu.svg'
                  : 'assets/drawable/ic_menu_list.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
      floating: true,
      pinned: false,
      snap: false,
      elevation: 0,
      onStretchTrigger: () async {
        // 拉伸触发回调
      },
    );
  }

  /// 构建瀑布流视图
  Widget _buildWaterfallFlow(List<Goods> goods) {
    return SliverGoodsWaterfallFlow(
      goodsList: goods,
      onItemTap: (goods) {
        // 跳转到商品详情页
      },
    );
  }

  /// 构建列表视图
  Widget _buildListView(List<Goods> goods) {
    return SliverList.builder(
      itemCount: goods.length,
      itemBuilder: (context, index) {
        final goodsItem = goods[index];
        return GestureDetector(
          onTap: () {
            // 跳转到商品详情页
          },
          child: Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 显示筛选弹窗
  void _showFilterDialog() {
    RenderBox renderBox =
        _filterButtonKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    // 更新筛选器可见性状态
    context.read<GoodsCategoryState>().setFilterVisible(true);

    // 创建覆盖层状态
    OverlayState overlayState = Overlay.of(context);

    // 初始化覆盖层条目引用
    OverlayEntry? filterEntry;

    // 定义动画结束回调
    void onAnimationEnd() {
      if (filterEntry != null) {
        filterEntry.remove();
        context.read<GoodsCategoryState>().setFilterVisible(false);
      }
    }

    // 创建筛选弹窗覆盖层
    filterEntry = OverlayEntry(
      builder: (context) {
        // 创建FilterDialog的GlobalKey

        return FilterDialog(
          buttonOffset: offset,
          onConfirm: () {}, // 确认操作在FilterDialog内部处理
          onReset: () {
            // 重置筛选
          },
          onClose: () {}, // 关闭操作在FilterDialog内部处理
          onAnimationEnd: onAnimationEnd, // 动画结束回调
        );
      },
    );

    // 插入覆盖层
    overlayState.insert(filterEntry);
  }

  void updateScrollInfo(bool isUpdateAppbar) {
    if (isUpdateAppbar) {
      _currentAppBarVisible = !_currentAppBarVisible;
      context.read<GoodsCategoryState>().updateAppBarVisibility(
        _currentAppBarVisible,
      );
      _lastScrollOffset = _scrollController.offset;
    } else {
      _lastScrollOffset = _scrollController.offset;
    }
  }
}

/// FilterBar代理类，用于实现吸顶效果
class _FilterBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _FilterBarDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
