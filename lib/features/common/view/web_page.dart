import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:coolmall_flutter/features/common/model/web_view_data.dart';
import 'package:coolmall_flutter/features/common/state/web_view_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// WebView页面主界面
class WebPage extends StatelessWidget {
  const WebPage({super.key});

  void _openInBrowser(BuildContext context, WebViewState webViewState) {
    final currentUrl = webViewState.currentUrl;
    if (currentUrl.isNotEmpty) {
      final uri = Uri.parse(currentUrl);
      _launchUrlInBrowser(uri);
    }
  }

  void _launchUrlInBrowser(Uri uri) {
    // 分离UI操作和业务逻辑，避免在异步回调中使用BuildContext
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WebViewState>(
      builder: (context, webViewState, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              webViewState.pageTitle.isNotEmpty ? webViewState.pageTitle : '网页',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: () => webViewState.navigateBack(context),
            ),
            actions: [
              _WebPageTopBarActions(
                showDropdownMenu: webViewState.isDropdownMenuVisible,
                onShowDropdownMenu: () => webViewState.showDropdownMenu,
                onDismissDropdownMenu: webViewState.dismissDropdownMenu,
                onRefreshClick: webViewState.refreshPage,
                onOpenInBrowser: () => _openInBrowser(context, webViewState),
              ),
            ],
          ),
          body: WebViewContent(
            webViewData: webViewState.webViewData,
            currentProgress: webViewState.currentProgress,
            shouldRefresh: webViewState.shouldRefresh,
            onTitleChange: webViewState.updatePageTitle,
            onProgressChange: webViewState.updateProgress,
            onResetRefreshState: webViewState.resetRefreshState,
          ),
        );
      },
    );
  }
}

/// WebView顶部栏操作按钮组件
class _WebPageTopBarActions extends StatelessWidget {
  final bool showDropdownMenu;
  final VoidCallback onShowDropdownMenu;
  final VoidCallback onDismissDropdownMenu;
  final VoidCallback onRefreshClick;
  final VoidCallback onOpenInBrowser;

  const _WebPageTopBarActions({
    required this.showDropdownMenu,
    required this.onShowDropdownMenu,
    required this.onDismissDropdownMenu,
    required this.onRefreshClick,
    required this.onOpenInBrowser,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'refresh':
            onRefreshClick();
            break;
          case 'browser':
            onOpenInBrowser();
            break;
        }
      },
      onCanceled: onDismissDropdownMenu,
      icon: const Icon(Icons.more_vert, size: 20),
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'refresh',
          child: Row(
            children: [
              Icon(Icons.refresh, size: 18),
              SizedBox(width: 8),
              Text('刷新'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'browser',
          child: Row(
            children: [
              Icon(Icons.open_in_browser, size: 18),
              SizedBox(width: 8),
              Text('用浏览器打开'),
            ],
          ),
        ),
      ],
    );
  }
}

/// WebView内容组件
class WebViewContent extends StatefulWidget {
  final WebViewData webViewData;
  final int currentProgress;
  final bool shouldRefresh;
  final Function(String) onTitleChange;
  final Function(int) onProgressChange;
  final VoidCallback onResetRefreshState;

  const WebViewContent({
    super.key,
    required this.webViewData,
    required this.currentProgress,
    required this.shouldRefresh,
    required this.onTitleChange,
    required this.onProgressChange,
    required this.onResetRefreshState,
  });

  @override
  State<WebViewContent> createState() => _WebViewContentState();
}

class _WebViewContentState extends State<WebViewContent> {
  WebViewController? _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    if (!kIsWeb) {
      try {
        _controller = WebViewController();
        // 设置加载进度监听
        _controller!.setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url) {
              widget.onProgressChange(10);
              setState(() {
                _isLoading = true;
              });
            },
            onProgress: (progress) {
              widget.onProgressChange(progress);
              if (progress == 100) {
                setState(() {
                  _isLoading = false;
                });
                widget.onProgressChange(100);
              }
            },
            onPageFinished: (url) {
              widget.onProgressChange(100);
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (error) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
        );
        _controller!.loadRequest(Uri.parse(widget.webViewData.url));
      } catch (e) {
        _controller = null;
      }
    }
  }

  @override
  void didUpdateWidget(WebViewContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 处理刷新逻辑
    if (oldWidget.shouldRefresh != widget.shouldRefresh &&
        widget.shouldRefresh) {
      if (kIsWeb) {
        // Web平台刷新
        setState(() {});
      } else if (_controller != null) {
        _controller!.reload();
      }
      widget.onResetRefreshState();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Web平台使用iframe或直接打开URL
    if (kIsWeb) {
      return _buildWebView();
    }

    // 移动平台使用WebView
    return _buildMobileView();
  }

  Widget _buildWebView() {
    // Web平台直接在新窗口打开URL
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uri = Uri.parse(widget.webViewData.url);
      launchUrl(uri, mode: LaunchMode.externalApplication);
      // 打开后自动返回
      if (mounted) {
        context.pop();
      }
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('正在打开网页...'),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileView() {
    if (_controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        WebViewWidget(controller: _controller!),
        if (_isLoading || widget.currentProgress < 100)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              value: widget.currentProgress / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(primaryDefault),
            ),
          ),
      ],
    );
  }
}
