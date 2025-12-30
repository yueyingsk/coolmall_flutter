import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:coolmall_flutter/features/goods/model/coupon.dart';
import 'package:coolmall_flutter/features/goods/model/goods_detail.dart';
import 'package:coolmall_flutter/features/goods/model/goods_spec.dart';
import 'package:coolmall_flutter/shared/widgets/text/price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// 商品信息卡片组件
class GoodsInfoCard extends StatelessWidget {
  final GoodsDetail goodsDetail;
  final GoodsSpec? selectedSpec;
  final VoidCallback onShowCoupon;
  final VoidCallback onShowSpecModal;
  final String specSelectionText;

  const GoodsInfoCard({
    super.key,
    required this.goodsDetail,
    this.selectedSpec,
    required this.onShowCoupon,
    required this.onShowSpecModal,
    required this.specSelectionText,
  });

  /// 优惠券项
  Widget couponItem(ThemeData theme, Coupon coupon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 0.5, color: colorDanger),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/drawable/ic_coupon.svg',
            width: 12,
            height: 12,
            colorFilter: ColorFilter.mode(colorDanger, BlendMode.srcIn),
          ),
          const SizedBox(width: 4),
          Text(
            "满${coupon.condition.fullAmount}元减${coupon.amount}元",
            style: theme.textTheme.labelSmall?.copyWith(color: colorDanger),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final goods = goodsDetail.goodsInfo;
    final coupons = goodsDetail.coupon;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 价格和已售信息
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PriceText(
                price: selectedSpec?.price ?? goods.price,
                integerTextSize: 22,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  '已售 ${goods.sold}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          if (coupons.isNotEmpty) SizedBox(height: 8),
          if (coupons.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: coupons.map((e) => couponItem(theme, e)).toList(),
            ),
          const SizedBox(height: 12),
          // 商品标题
          Text(
            goods.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // 副标题
          Text(
            goods.subTitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 12),

          // 规格选择
          GestureDetector(
            onTap: onShowSpecModal,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outline,
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/drawable/ic_cube.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      specSelectionText,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/drawable/ic_right.svg',
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
