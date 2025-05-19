import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

typedef OnPageViewed = void Function(int page);

class DSOnboardingScreen extends StatefulWidget {
  final List<Widget> pages;
  final VoidCallback onSkip;
  final OnPageViewed onPageViewed;
  const DSOnboardingScreen({
    required this.pages,
    required this.onSkip,
    required this.onPageViewed,
    super.key,
  });

  @override
  State<DSOnboardingScreen> createState() => _DSOnboardingScreenState();
}

class _DSOnboardingScreenState extends State<DSOnboardingScreen> {
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onPageViewed(_controller.page?.round() ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ds = DesignSystemProvider.of(context);
    return Scaffold(
      backgroundColor: ds.colorScheme.primary.color,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.pages,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _PageIndicator(
                  pages: widget.pages.length,
                  controller: _controller,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DSButton(
                      variant: DSButtonVariant.secondary,
                      onPressed: () {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: DSText(DSString.of(DSTextConstants.labelContinue)),
                    ),
                    DSButton(
                      variant: DSButtonVariant.tertiary,
                      onPressed: () {
                        widget.onSkip();
                      },
                      child: DSText(DSString.of(DSTextConstants.labelSkip)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatefulWidget {
  final PageController controller;
  final int pages;
  const _PageIndicator({
    required this.pages,
    required this.controller,
  });

  @override
  State<_PageIndicator> createState() => __PageIndicatorState();
}

class __PageIndicatorState extends State<_PageIndicator> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final ds = DesignSystemProvider.of(context);
    final light = ds.colorScheme.disabled.color;
    final selected = ds.colorScheme.light.color;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < widget.pages; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 8,
              width: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: (widget.controller.page?.round() ?? 0) == i
                    ? selected
                    : light,
              ),
            ),
          ),
      ],
    );
  }
}
