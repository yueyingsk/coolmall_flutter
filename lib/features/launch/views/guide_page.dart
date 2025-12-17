import 'package:coolmall_flutter/features/launch/models/guide_page_data.dart';
import 'package:coolmall_flutter/features/launch/state/guide_state.dart';
import 'package:coolmall_flutter/features/launch/widgets/guide_content_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 引导页视图
class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    context.read<GuideState>().pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GuideState>(
      builder: (context, viewModel, child) {
        return GuideContentView(
          guidePages: guidePageDataList,
          currentPage: viewModel.currentPage,
          isLastPage: viewModel.isLastPage,
          onPageChanged: viewModel.onPageChanged,
          onSkipClick: () => viewModel.skipGuide(context),
          onNextClick: () => viewModel.nextPage(context),
          pageController: viewModel.pageController,
        );
      },
    );
  }
}
