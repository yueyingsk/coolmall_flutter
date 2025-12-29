import 'package:coolmall_flutter/features/goods/model/coupon.dart';
import 'package:flutter/material.dart';

/// 优惠券卡片模式
enum CouponCardMode {
  receive, // 领取模式
  select, // 选择模式
  view, // 查看模式（我的优惠券）
}

/// 优惠券状态（自动计算）
enum CouponStatus {
  available, // 可用
  selected, // 已选择
  used, // 已使用
  expired, // 已过期
  insufficient, // 不满足使用条件
}

/// 优惠券卡片组件
/// 参考KT代码CouponCard设计，支持多种模式和状态
class CouponCard extends StatelessWidget {
  final Coupon coupon;
  final CouponCardMode mode;
  final bool isSelected;
  final double? currentPrice;
  final VoidCallback? onActionClick;
  final bool showDescription;
  final bool expandable;

  const CouponCard({
    super.key,
    required this.coupon,
    this.mode = CouponCardMode.receive,
    this.isSelected = false,
    this.currentPrice,
    this.onActionClick,
    this.showDescription = true,
    this.expandable = true,
  });

  @override
  Widget build(BuildContext context) {
    // 计算优惠券状态
    final status = _calculateStatus();

    // 判断是否为不可用状态
    final isUnavailable =
        status == CouponStatus.used ||
        status == CouponStatus.expired ||
        status == CouponStatus.insufficient;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          // 主要内容
          CouponCardContent(
            coupon: coupon,
            status: status,
            mode: mode,
            showDescription: showDescription,
            expandable: expandable,
            onActionClick: onActionClick,
          ),

          // 不可用状态的灰色蒙版
          if (isUnavailable)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
        ],
      ),
    );
  }

  CouponStatus _calculateStatus() {
    // 检查是否已使用
    if (coupon.status == 1) return CouponStatus.used;

    // 检查是否已过期
    if (coupon.status == 2 || _isExpired(coupon.endTime)) {
      return CouponStatus.expired;
    }

    // 检查是否满足使用条件
    if (mode == CouponCardMode.select && currentPrice != null) {
      final condition = coupon.condition;
      if (currentPrice! < condition.fullAmount) {
        return CouponStatus.insufficient;
      } else if (isSelected) {
        return CouponStatus.selected;
      } else {
        return CouponStatus.available;
      }
    }

    // 选择模式下检查是否已选择
    if (mode == CouponCardMode.select && isSelected) {
      return CouponStatus.selected;
    }

    // 其他情况为可用状态
    return CouponStatus.available;
  }

  bool _isExpired(String? endTime) {
    if (endTime == null || endTime.isEmpty) return false;
    try {
      final expireDate = DateTime.parse(endTime);
      final currentDate = DateTime.now();
      return expireDate.isBefore(currentDate);
    } catch (e) {
      return false;
    }
  }
}

/// 优惠券卡片内容
class CouponCardContent extends StatefulWidget {
  final Coupon coupon;
  final CouponStatus status;
  final CouponCardMode mode;
  final bool showDescription;
  final bool expandable;
  final VoidCallback? onActionClick;

  const CouponCardContent({
    super.key,
    required this.coupon,
    required this.status,
    required this.mode,
    required this.showDescription,
    required this.expandable,
    this.onActionClick,
  });

  @override
  State<CouponCardContent> createState() => _CouponCardContentState();
}

class _CouponCardContentState extends State<CouponCardContent> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 上半部分：优惠券主要信息
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 左侧优惠券图标
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1976D2), Color(0xFF1565C0)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.local_offer,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // 中间信息区域
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 优惠券标题
                    Text(
                      widget.coupon.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // 有效期
                    Text(
                      '有效期至：${widget.coupon.endTime.substring(0, 10)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // 右侧金额和条件区域
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 优惠券金额
                  Text(
                    '¥${widget.coupon.amount}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 使用条件
                  Text(
                    '满${widget.coupon.condition.fullAmount.toInt()}可用',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),

        // 分割线
        if (widget.showDescription || widget.expandable)
          const Divider(height: 1),

        // 下半部分：说明和操作按钮
        if (widget.showDescription || widget.expandable)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // 左侧：可展开的说明
                Expanded(
                  child:
                      widget.expandable && widget.coupon.description.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    '使用说明',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                ],
                              ),
                            ),
                            // 展开的详细说明
                            if (isExpanded) ...[
                              const SizedBox(height: 4),
                              Text(
                                widget.coupon.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ],
                        )
                      : widget.showDescription &&
                            widget.coupon.description.isNotEmpty
                      ? Text(
                          widget.coupon.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : const SizedBox.shrink(),
                ),

                // 右侧：操作按钮
                CouponActionButton(
                  status: widget.status,
                  mode: widget.mode,
                  onClick: widget.onActionClick,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// 优惠券操作按钮
class CouponActionButton extends StatelessWidget {
  final CouponStatus status;
  final CouponCardMode mode;
  final VoidCallback? onClick;

  const CouponActionButton({
    super.key,
    required this.status,
    required this.mode,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case CouponStatus.available:
        final buttonText = _getButtonText();
        return ElevatedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            minimumSize: const Size(60, 28),
          ),
          child: Text(buttonText, style: const TextStyle(fontSize: 12)),
        );

      case CouponStatus.selected:
        return Text('已选择', style: TextStyle(fontSize: 12, color: Colors.blue));

      case CouponStatus.used:
      case CouponStatus.expired:
      case CouponStatus.insufficient:
        return Text(
          _getStatusText(),
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        );
    }
  }

  String _getButtonText() {
    switch (mode) {
      case CouponCardMode.receive:
        return '领取';
      case CouponCardMode.select:
        return '选择';
      case CouponCardMode.view:
        return '使用';
    }
  }

  String _getStatusText() {
    switch (status) {
      case CouponStatus.used:
        return '已使用';
      case CouponStatus.expired:
        return '已过期';
      case CouponStatus.insufficient:
        return '条件不足';
      default:
        return '';
    }
  }
}
