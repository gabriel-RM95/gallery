import 'package:flutter/material.dart';

import '../../logic/bloc.dart';
import '../../logic/data_provider.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_page_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyBloc myBloc = MyBloc();

  @override
  void initState() {
    super.initState();
    myBloc.init();
  }

  @override
  void dispose() {
    myBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DataProvider(
      myBloc: myBloc,
      child: const Scaffold(
        appBar: MyAnimatedAppBar(),
        body: MyPageViewBody(),
      ),
    );
  }
}
