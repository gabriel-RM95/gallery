import 'package:flutter/material.dart';

import 'data_provider.dart';

class DataProvider extends InheritedWidget {
  final MyBloc myBloc;

  DataProvider({super.key, required this.myBloc, Widget? child})
      : super(child: child!);

  static MyBloc of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<DataProvider>()!.myBloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
