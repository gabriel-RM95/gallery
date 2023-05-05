import 'package:flutter/material.dart';

import '../../logic/bloc.dart';

class MyAnimatedAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAnimatedAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = DataProvider.of(context);
    return ValueListenableBuilder<bool>(
        valueListenable: bloc.appBarHided,
        builder: (context, appBarHided, child) {
          return TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: appBarHided ? 0.0 : 1.0),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: AppBar(
                    toolbarHeight: kToolbarHeight * 1.5 * value,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: const Text(
                      'Faces',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.5);
}
