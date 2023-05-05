import 'package:flutter/material.dart';

class MyBloc {
  final pageController = PageController(viewportFraction: .8);
  final currentPage = ValueNotifier<double>(0.0);
  final appBarHided = ValueNotifier<bool>(false);

  void _pageListener() {
    currentPage.value = pageController.page!;
  }

  void hideShowAppBar() {
    appBarHided.value = !appBarHided.value;
  }

  void init() {
    pageController.addListener(_pageListener);
  }

  void dispose() {
    pageController.removeListener(_pageListener);
    pageController.dispose();
  }
}
