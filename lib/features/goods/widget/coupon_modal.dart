import 'package:coolmall_flutter/features/goods/model/coupon.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/modal/bottom_modal.dart';
import '../../../shared/widgets/coupon/coupon_card.dart';

/// 优惠券弹窗组件
/// 参考KT代码CouponModal设计，使用统一的BottomModal和CouponCard组件
class CouponModal extends StatelessWidget {
  final bool isVisible;
  final List<Coupon> coupons;
  final Function(Coupon) onCouponReceive;
  final VoidCallback? onDismiss;
  final String? title;

  const CouponModal({
    super.key,
    required this.isVisible,
    required this.coupons,
    required this.onCouponReceive,
    this.onDismiss,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BottomModal(
      isVisible: isVisible,
      title: title ?? '优惠券',
      onDismiss: onDismiss,
      child: coupons.isEmpty ? _buildEmptyState() : _buildCouponList(),
    );
  }

  /// 构建空状态视图
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_offer, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            '暂无可领取优惠券',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }

  /// 构建优惠券列表
  Widget _buildCouponList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          ...coupons.map(
            (coupon) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CouponCard(
                coupon: coupon,
                mode: CouponCardMode.receive,
                onActionClick: () => onCouponReceive(coupon),
                showDescription: true,
                expandable: true,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
