import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// 底部操作栏组件
class GoodsActionBar extends StatelessWidget {
  final bool hasAnimated;
  final VoidCallback? onAddToCartClick;
  final VoidCallback? onBuyNowClick;
  final VoidCallback? onCsClick;
  final VoidCallback? onCartClick;

  const GoodsActionBar({
    super.key,
    this.hasAnimated = false,
    this.onAddToCartClick,
    this.onBuyNowClick,
    this.onCsClick,
    this.onCartClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 4),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // 客服按钮
          _buildActionButton(
            icon: "assets/drawable/ic_customer_service.svg",
            label: '客服',
            onTap: onCsClick,
          ),

          const SizedBox(width: 8),

          // 购物车按钮
          _buildActionButton(
            icon: "assets/drawable/ic_cart.svg",
            label: '购物车',
            onTap: onCartClick,
          ),

          const Spacer(),

          // 立即购买按钮
          Row(
            children: [
              // 加购物车按钮
              SizedBox(
                height: 32,
                child: OutlinedButton(
                  onPressed: onAddToCartClick,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryDefault),
                    foregroundColor: primaryDefault,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('加购物车'),
                ),
              ),
              const SizedBox(width: 16),
              // 立即购买按钮
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: onBuyNowClick,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDefault,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('立即购买'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    required String label,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            SvgPicture.asset(icon, width: 20, height: 20),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
