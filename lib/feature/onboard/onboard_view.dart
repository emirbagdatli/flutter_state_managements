import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_managements/feature/onboard/onboard_model.dart';
import 'package:flutter_state_managements/feature/onboard/tab_indicator.dart';
import 'package:flutter_state_managements/product/padding/page_padding.dart';
import 'package:flutter_state_managements/product/widget/onboard_card.dart';

part 'module/start_fab_button.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  final String _skipTitle = 'Skip';

  int _selectedIndex = 0;

  ValueNotifier<bool> isBackEnable = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  void _incrementAndChange([int? value]) {
    if (_isLastPage && value == null) {
      _changeBackEnable(true);
      // isBackEnable.value = true;
      return;
    }
    _changeBackEnable(false);

    _incrementSelectedPage();
  }

  void _changeBackEnable(bool value) {
    if (value == isBackEnable.value) return;
    isBackEnable.value = !isBackEnable.value;
  }

  bool get _isLastPage => OnBoardModels.onboardItems.length - 1 == _selectedIndex;
  bool get _isFirstPage => _selectedIndex == 0;

  void _incrementSelectedPage([int? value]) {
    setState(() {
      if (value != null) {
        _selectedIndex = value;
      } else {
        _selectedIndex++;
      }
      //  value ?? _selectedIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [
            ValueListenableBuilder<bool>(
              valueListenable: isBackEnable,
              builder: (BuildContext context, bool value, Widget? child) {
                return value ? const SizedBox() : TextButton(onPressed: () {}, child: Text(_skipTitle));
              },
            ),
          ],
          leading: _isFirstPage
              ? null
              : IconButton(icon: const Icon(Icons.chevron_left_rounded), color: Colors.grey, onPressed: () {})),
      body: Padding(
        padding: const PagePadding.all(),
        child: Column(
          children: [
            Expanded(
              child: _pageView(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabIndicator(
                  selectedIndex: _selectedIndex,
                ),
                _StartFabButton(
                  isLastPage: _isLastPage,
                  onPressed: () {
                    //  _incrementSelectedPage();
                    _incrementAndChange();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _pageView() {
    return PageView.builder(
        onPageChanged: (value) {
          _incrementAndChange(value);
        },
        itemCount: OnBoardModels.onboardItems.length,
        itemBuilder: (context, index) {
          return OnBoardCard(model: OnBoardModels.onboardItems[index]);
        });
  }
}
