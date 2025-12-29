import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:coolmall_flutter/features/goods/model/goods.dart';
import 'package:coolmall_flutter/features/goods/model/goods_spec.dart';
import 'package:coolmall_flutter/shared/widgets/image/network_image.dart';
import 'package:coolmall_flutter/shared/widgets/text/price_text.dart';
import 'package:coolmall_flutter/shared/widgets/title/title_with_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../model/goods_detail.dart';

/// 规格选择弹窗组件
class SpecSelectModal extends StatefulWidget {
  final Goods goods;
  final List<GoodsSpec> specs;
  final GoodsSpec? selectedSpec;
  final Function(GoodsSpec) onSpecSelected;
  final Function(SelectedGoods) onAddToCart;
  final Function(SelectedGoods) onBuyNow;
  final VoidCallback? onDismiss;
  final VoidCallback? onRetry;

  const SpecSelectModal({
    super.key,
    required this.goods,
    required this.specs,
    this.selectedSpec,
    required this.onSpecSelected,
    required this.onAddToCart,
    required this.onBuyNow,
    this.onDismiss,
    this.onRetry,
  });

  @override
  State<SpecSelectModal> createState() => _SpecSelectModalState();
}

class _SpecSelectModalState extends State<SpecSelectModal> {
  int _quantity = 1;
  bool isGrid = true;
  GoodsSpec? _selectedSpec;

  @override
  void initState() {
    super.initState();
    _quantity = 1;
    isGrid = true;
    _selectedSpec = widget.selectedSpec;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击阴影区域关闭弹窗
      onTap: widget.onDismiss,
      child: Container(
        color: Colors.black54,
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            final colorScheme = Theme.of(context).colorScheme;
            return GestureDetector(
              // 防止点击弹窗内部时触发关闭
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // 拖拽指示器
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '选择规格',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // 商品信息和图片
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: NetworkImageWidget(
                            imageUrl:
                                widget.selectedSpec?.images?.first ??
                                widget.goods.mainPic,
                            fit: BoxFit.cover,
                            cornerRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // 商品信息
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PriceText(
                                price:
                                    widget.selectedSpec?.price ??
                                    widget.goods.price,
                                integerTextSize: 22,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.selectedSpec != null
                                    ? '已选：${widget.selectedSpec!.name}'
                                    : '未选择',
                                style: TextStyle(
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.75,
                                  ),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '库存：${widget.selectedSpec?.stock ?? 0}',
                                style: TextStyle(
                                  color: colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.6),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(height: 0.5, color: colorScheme.outline),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleWithLine(title: "规格分类"),
                        SvgPicture.asset(
                          isGrid
                              ? 'assets/drawable/ic_menu_list.svg'
                              : 'assets/drawable/ic_menu.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.6),
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // isGrid
                    //     ? _buildGridLayout(colorScheme)
                    //     : const SizedBox(height: 12),
                    // 规格选择
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 规格列表
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: widget.specs.map((spec) {
                                final isSelected = _selectedSpec?.id == spec.id;
                                return GestureDetector(
                                  onTap: () => widget.onSpecSelected(spec),
                                  // onTap: () => setState(() {
                                  //   _selectedSpec = spec;
                                  // }),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? primaryDefault.withValues(
                                              alpha: 0.05,
                                            )
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected
                                            ? primaryDefault
                                            : colorScheme.outline.withValues(
                                                alpha: 0.8,
                                              ),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      spec.name,
                                      style: TextStyle(
                                        color: isSelected
                                            ? primaryDefault
                                            : colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 16),

                            // 数量选择
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TitleWithLine(title: '数量'),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (_quantity > 1) {
                                          setState(() {
                                            _quantity--;
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 24,
                                      alignment: Alignment.center,
                                      child: Text('$_quantity'),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _quantity++;
                                        });
                                      },
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: primaryDefault,
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 底部按钮
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              if (_selectedSpec != null) {
                                widget.onAddToCart(
                                  SelectedGoods(
                                    goods: widget.goods,
                                    spec: _selectedSpec,
                                    count: _quantity,
                                  ),
                                );
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: primaryDefault),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('加入购物车'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (widget.selectedSpec != null) {
                                widget.onBuyNow(
                                  SelectedGoods(
                                    goods: widget.goods,
                                    spec: widget.selectedSpec,
                                    count: _quantity,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryDefault,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('立即购买'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridLayout(ColorScheme colorScheme) {
    return GridView.builder(
      itemCount: widget.specs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final spec = widget.specs[index];
        return _buildSpecItem(spec, colorScheme);
      },
    );
  }

  Widget _buildSpecItem(GoodsSpec spec, ColorScheme colorScheme) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: widget.selectedSpec == spec
              ? primaryDefault
              : colorScheme.outline.withValues(alpha: 0.8),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NetworkImageWidget(
            showBackground: true,
            width: 100,
            height: 100,
            imageUrl: spec.images?.first ?? widget.goods.mainPic,
            fit: BoxFit.cover,
            cornerRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          Expanded(
            child: Text(
              spec.name,
              style: TextStyle(
                fontSize: 12,
                color: widget.selectedSpec == spec
                    ? primaryDefault
                    : colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
