import 'package:coolmall_flutter/core/network/entity/network_state.dart';
import 'package:coolmall_flutter/features/goods/model/goods_spec.dart';
import 'package:coolmall_flutter/features/goods/repository/goods_repository.dart';
import 'package:flutter/material.dart';
import '../model/goods_detail.dart';

/// Flutter版本商品详情页面状态类
class GoodsDetailState extends ChangeNotifier {
  // 商品详情数据
  GoodsDetail? _goodsDetail;
  NetworkState _networkState = NetworkState.loading;

  // 规格选择状态
  bool _isSpecModalVisible = false;
  List<GoodsSpec> _specs = [];
  GoodsSpec? _selectedSpec;

  // 优惠券弹窗状态
  bool _isCouponModalVisible = false;

  // 动画状态
  bool _hasAnimated = false;

  // 购物车状态（示例数据）
  int _cartCount = 0;

  // Getters
  GoodsDetail? get goodsDetail => _goodsDetail;
  NetworkState get networkState => _networkState;
  bool get isSpecModalVisible => _isSpecModalVisible;
  List<GoodsSpec> get specs => _specs;
  GoodsSpec? get selectedSpec => _selectedSpec;
  bool get isCouponModalVisible => _isCouponModalVisible;
  bool get hasAnimated => _hasAnimated;
  int get cartCount => _cartCount;

  // 获取商品信息，如果规格已选择则返回规格价格
  int get currentPrice {
    if (_goodsDetail == null) return 0;
    return _selectedSpec?.price ?? _goodsDetail!.goodsInfo.price;
  }

  // 获取当前选中的规格价格文本
  String get currentPriceText {
    return '¥${currentPrice.toStringAsFixed(2)}';
  }

  // 获取规格选择状态文本
  String get specSelectionText {
    if (_selectedSpec != null) {
      return '已选择：${_selectedSpec!.name}';
    }
    return '请选择规格';
  }

  // 初始化数据
  Future<void> loadGoodsDetail(int goodsId) async {
    _networkState = NetworkState.loading;
    notifyListeners();

    try {
      _goodsDetail = await goodsRepository.getGoodsDetail(goodsId);

      _networkState = NetworkState.success;
      loadGoodsSpecs();
      // 添加到足迹记录
      await _addToFootprint();
    } catch (e) {
      debugPrint(e.toString());
      _networkState = NetworkState.error;
    }

    notifyListeners();
  }

  // 重新加载数据
  Future<void> retryLoad() async {
    if (_goodsDetail != null) {
      await loadGoodsDetail(_goodsDetail!.goodsInfo.id);
    }
  }

  // 加载商品规格
  Future<void> loadGoodsSpecs() async {
    if (_goodsDetail?.goodsInfo.specs.isNotEmpty == true) return;
    if (_goodsDetail == null) return;

    notifyListeners();

    _specs = await goodsRepository.getGoodsSpec(_goodsDetail!.goodsInfo.id);

    notifyListeners();
  }

  // 选择规格
  void selectSpec(GoodsSpec spec) {
    if (_selectedSpec?.id == spec.id) {
      // 取消选择
      _selectedSpec = null;
    } else {
      // 选择新规格
      _selectedSpec = spec;
    }
    notifyListeners();
  }

  // 显示规格选择弹窗
  void showSpecModal() {
    _isSpecModalVisible = true;
    // 弹窗展开时加载规格数据
    loadGoodsSpecs();
    notifyListeners();
  }

  // 隐藏规格选择弹窗
  void hideSpecModal() {
    _isSpecModalVisible = false;
    notifyListeners();
  }

  // 规格弹窗展开完成回调
  void onSpecModalExpanded() {
    loadGoodsSpecs();
  }

  // 显示优惠券弹窗
  void showCouponModal() {
    _isCouponModalVisible = true;
    notifyListeners();
  }

  // 隐藏优惠券弹窗
  void hideCouponModal() {
    _isCouponModalVisible = false;
    notifyListeners();
  }

  // 领取优惠券
  Future<void> receiveCoupon(int couponId) async {
    if (_goodsDetail == null) return;

    try {
      // 模拟API调用
      await Future.delayed(const Duration(milliseconds: 800));

      // 更新优惠券状态
      final couponIndex = _goodsDetail!.coupon.indexWhere(
        (c) => c.id == couponId,
      );
      if (couponIndex >= 0) {
        _goodsDetail!.coupon[couponIndex] = _goodsDetail!.coupon[couponIndex]
            .copyWith();
        notifyListeners();
      }

      // 隐藏弹窗
      hideCouponModal();

      // 显示成功消息
      _showSuccessMessage('优惠券领取成功');
    } catch (e) {
      _showErrorMessage('领取失败，请重试');
    }
  }

  // 加入购物车
  Future<void> addToCart(SelectedGoods selectedGoods) async {
    try {
      // 模拟API调用
      await Future.delayed(const Duration(milliseconds: 500));

      // 更新购物车数量
      _cartCount += selectedGoods.count;

      // 隐藏弹窗
      hideSpecModal();

      // 显示成功消息
      _showSuccessMessage('加入购物车成功');
    } catch (e) {
      _showErrorMessage('加入购物车失败');
    }
  }

  // 立即购买
  void buyNow(SelectedGoods selectedGoods) {
    // 隐藏弹窗
    hideSpecModal();

    // 跳转到确认订单页面（这里只是模拟）
    _showSuccessMessage('正在跳转到确认订单页面...');

    // 实际项目中会使用 Navigator.of(context).pushNamed(...)
  }

  // 触发动画
  void triggerAnimation() {
    _hasAnimated = true;
    notifyListeners();
  }

  // 跳转到购物车页面
  void navigateToCart() {
    _showInfoMessage('正在跳转到购物车页面...');
  }

  // 跳转到客服页面
  void navigateToCustomerService() {
    _showInfoMessage('正在跳转到客服页面...');
  }

  // 分享商品
  void shareGoods() {
    _showInfoMessage('正在分享商品...');
  }

  // 跳转到评论页面
  void navigateToComments() {
    _showInfoMessage('正在跳转到评论页面...');
  }

  // 添加到足迹
  Future<void> _addToFootprint() async {
    if (_goodsDetail != null) {
      // 模拟添加足迹记录
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  // // 模拟创建商品详情数据
  // GoodsDetail _createMockGoodsDetail(int goodsId) {
  //   return GoodsDetail(
  //     goodsInfo: Goods(
  //       id: goodsId,
  //       title: 'iPhone 15 Pro Max 256GB 深空黑色 钛金属 移动联通电信5G手机',
  //       subTitle: '最新A17 Pro芯片，专业级摄像系统，持久续航',
  //       price: 8999,
  //       sold: 15680,
  //       mainPic: 'https://example.com/iphone15-main.jpg',
  //       content: '这是iPhone 15 Pro Max的详细描述',
  //       pics: [
  //         'https://example.com/iphone15-1.jpg',
  //         'https://example.com/iphone15-2.jpg',
  //         'https://example.com/iphone15-3.jpg',
  //         'https://example.com/iphone15-4.jpg',
  //       ],
  //       createTime: "null",
  //       updateTime: "null",
  //       typeId: 1,
  //       contentPics: [],
  //       recommend: false,
  //       featured: false,
  //       status: 1,
  //       sortNum: 0,
  //       specs: [],
  //     ),
  //     specs: [
  //       GoodsSpec(
  //         id: 1,
  //         goodsId: goodsId,
  //         name: '128GB 深空黑色',
  //         price: 7999,
  //         stock: 50,
  //         images: ['https://example.com/spec1.jpg'],
  //         sortNum: 0,
  //       ),
  //       GoodsSpec(
  //         id: 2,
  //         goodsId: goodsId,
  //         name: '256GB 深空黑色',
  //         price: 8999,
  //         stock: 30,
  //         images: ['https://example.com/spec2.jpg'],
  //         sortNum: 1,
  //       ),
  //       GoodsSpec(
  //         id: 3,
  //         goodsId: goodsId,
  //         name: '512GB 深空黑色',
  //         price: 10999,
  //         stock: 15,
  //         images: ['https://example.com/spec3.jpg'],
  //         sortNum: 2,
  //       ),
  //       GoodsSpec(
  //         id: 4,
  //         goodsId: goodsId,
  //         name: '256GB 原色钛金属',
  //         price: 9299,
  //         stock: 25,
  //         images: ['https://example.com/spec4.jpg'],
  //         sortNum: 3,
  //       ),
  //     ],
  //     coupon: [
  //       Coupon(
  //         id: 1,
  //         title: '新用户专享优惠券',
  //         amount: 100,
  //         startTime: '2024-01-01T00:00:00Z',
  //         endTime: '2024-12-31T23:59:59Z',
  //         createTime: '',
  //         updateTime: '',
  //         description: '',
  //         type: 0,
  //         num: 0,
  //         receivedNum: 0,
  //         status: 0,
  //         condition: Condition(fullAmount: 0),
  //       ),
  //       Coupon(
  //         id: 2,
  //         title: '双11狂欢券',
  //         amount: 200,
  //         startTime: '2024-01-01T00:00:00Z',
  //         endTime: '2024-12-31T23:59:59Z',
  //         createTime: '',
  //         updateTime: '',
  //         description: '',
  //         type: 0,
  //         num: 0,
  //         receivedNum: 0,
  //         status: 0,
  //         condition: Condition(fullAmount: 0),
  //       ),
  //     ],
  //     comment: [
  //       Comment(
  //         id: 1,
  //         userId: 1001,
  //         userName: '张**',
  //         nickName: '张三',
  //         avatarUrl: 'https://example.com/avatar1.jpg',
  //         content: '手机非常好用，拍照效果很棒，电池也很耐用，推荐购买！',
  //         createTime: '2024-01-15T10:30:00Z',
  //         updateTime: '2024-01-15T10:30:00Z',
  //         pics: [],
  //         goodsId: 3,
  //         orderId: 3,
  //         starCount: 3,
  //       ),
  //       Comment(
  //         id: 2,
  //         userId: 1002,
  //         userName: '李**',
  //         nickName: '李四',
  //         avatarUrl: 'https://example.com/avatar2.jpg',
  //         content: '整体体验不错，就是价格有点贵，但质量确实很好。',
  //         starCount: 4,
  //         createTime: '2024-01-14T15:20:00Z',
  //         updateTime: '2024-01-14T15:20:00Z',
  //         pics: [],
  //         goodsId: 2,
  //         orderId: 2,
  //       ),
  //     ],
  //   );
  // }

  // 显示消息方法（实际项目中会使用SnackBar或Toast）
  void _showSuccessMessage(String message) {
    debugPrint('✅ $message');
  }

  void _showErrorMessage(String message) {
    debugPrint('❌ $message');
  }

  void _showInfoMessage(String message) {
    debugPrint('ℹ️ $message');
  }

  /// 初始化参数
  void initParams(int extra) {
    var goodsId = extra;
    // 加载商品详情
    loadGoodsDetail(goodsId);
  }
}
