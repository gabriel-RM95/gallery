import 'package:flutter/material.dart';

import '../../data/model.dart';
import '../../logic/bloc.dart';
import '../pages/details_page.dart';

class MyPageViewBody extends StatelessWidget {
  const MyPageViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = DataProvider.of(context);
    return ValueListenableBuilder<double>(
        valueListenable: bloc.currentPage,
        builder: (context, currentPage, child) {
          return PageView.builder(
            controller: bloc.pageController,
            itemCount: items.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = items[index];
              var value = (currentPage - index).abs();

              return Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Transform.scale(
                      scale: 1 - value,
                      child: Hero(
                        tag: item.name,
                        child: Image.asset(
                          item.image,
                          fit: BoxFit.fill,
                          height: size.height * .6,
                          width: 300,
                        ),
                      ),
                    ),
                    Text(
                      item.name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'By ${item.by}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () async {
                        bloc.hideShowAppBar();
                        await Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 1000),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 1000),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    FadeTransition(
                              opacity: animation,
                              child: DataProvider(
                                  myBloc: bloc, child: DetailsPage(item: item)),
                            ),
                          ),
                        );
                        bloc.hideShowAppBar();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('SPEC'),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    const SizedBox.shrink(),
                  ],
                ),
              );
            },
          );
        });
  }
}
