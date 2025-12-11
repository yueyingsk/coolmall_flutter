import 'package:flutter/material.dart';
import 'package:coolmall_flutter/shared/widgets/refresh/refresh_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 是否为网格布局
  bool _isGrid = false;

  /// 产品数据列表

  /// 示例产品数据
  List<String> _products = List.generate(20, (index) => '产品 ${index + 1}');

  final RefreshController _smartRefreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('酷商城'),
        actions: [
          IconButton(
            icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGrid = !_isGrid;
              });
            },
          ),
        ],
      ),
      body: RefreshLayout(
        controller: _smartRefreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoadMore,
        child: _isGrid ? _buildGridContent() : _buildListContent(),
      ),
    );
  }

  /// 构建列表内容
  Widget _buildListContent() {
    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return _buildProductItem(_products[index], index, isGrid: false);
      },
    );
  }

  /// 构建网格内容
  Widget _buildGridContent() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return _buildProductItem(_products[index], index, isGrid: true);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
      ),
    );
  }

  /// 构建产品项
  Widget _buildProductItem(String product, int index, {required bool isGrid}) {
    return Card(
      margin: isGrid
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 产品图片
            Container(
              height: isGrid ? 120.0 : 150.0,
              width: double.infinity,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.image, size: 40.0, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 10.0),
            // 产品名称
            Text(
              product,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5.0),
            // 产品价格
            const Text(
              '¥99.99',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 下拉刷新回调
  Future<void> _onRefresh() async {
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      // 重置数据
      _products = List.generate(20, (index) => '产品 ${index + 1}');
    });
    _smartRefreshController.refreshCompleted();
    // 重置加载状态，确保可以继续加载更多
    _smartRefreshController.resetNoData();
  }

  /// 上拉加载更多回调
  Future<void> _onLoadMore() async {
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      // 加载更多数据
      final currentLength = _products.length;
      _products.addAll(
        List.generate(10, (index) => '产品 ${currentLength + index + 1}'),
      );

      // 如果数据超过50条，显示没有更多数据
      if (_products.length >= 50) {
        _smartRefreshController.loadNoData();
      } else {
        _smartRefreshController.loadComplete();
      }
    });
  }
}
