import 'package:flutter/material.dart';
import 'package:coolmall_flutter/features/main/model/home_data.dart';
import 'package:coolmall_flutter/shared/widgets/image/network_image.dart';
import 'package:coolmall_flutter/shared/widgets/text/price_text.dart';
import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

/// 商品瀑布流,用于Sliver列表
class SliverGoodsWaterfallFlow extends StatelessWidget {
  final List<Goods> goodsList;
  final void Function(Goods goods)? onItemTap;

  const SliverGoodsWaterfallFlow({
    super.key,
    required this.goodsList,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        return _buildGoodsItem(context, goodsList[index]);
      }, childCount: goodsList.length),
    );
  }

  Widget _buildGoodsItem(BuildContext context, Goods goods) {
    return Card(
      elevation: 0,
      color: bgWhiteLight,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () {
            if (onItemTap != null) {
              onItemTap!(goods);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(minHeight: 100),
                child: NetworkImageWidget(
                  width: double.infinity,
                  imageUrl: goods.mainPic,
                  fit: BoxFit.contain,
                  cornerRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                goods.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                goods.subTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: textTertiaryLight),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PriceText(price: goods.price),
                  Text(
                    '已售${goods.sold}件',
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
  }
}
