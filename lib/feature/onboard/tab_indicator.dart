import 'package:flutter/material.dart';

import 'onboard_model.dart';

class TabIndicator extends StatefulWidget {
  TabIndicator({Key? key, required this.selectedIndex}) : super(key: key);
  final int selectedIndex;
  @override
  State<TabIndicator> createState() => _TabIndicatorState();
}

class _TabIndicatorState extends State<TabIndicator> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void didUpdateWidget(covariant TabIndicator oldWidget) {
    //alt widgetdaki veriyi günceller
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _tabController.animateTo(widget.selectedIndex);
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: OnBoardModels.onboardItems.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabPageSelector(controller: _tabController);
  }
}
