import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/model.dart';
import '../../logic/bloc.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _scrollController = ScrollController();
  bool hide = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = DataProvider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            TweenAnimationBuilder(
                duration: const Duration(milliseconds: 2000),
                tween: Tween(begin: 0.0, end: hide ? 305.0 : 0.0),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(value, 0.0),
                    child: Hero(
                      tag: widget.item.name,
                      flightShuttleBuilder: (flightContext, animation,
                          flightDirection, fromHeroContext, toHeroContext) {
                        return AnimatedBuilder(
                          animation: animation,
                          child: Image.asset(
                            widget.item.image,
                            fit: BoxFit.fill,
                            height: size.height * .6,
                            width: 300,
                          ),
                          builder: (context, child) {
                            final rotateValue = flightDirection ==
                                    HeroFlightDirection.pop
                                ? Curves.easeInBack.transform(animation.value)
                                : Curves.easeOutBack.transform(animation.value);
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..translate(
                                    animation.value * (size.height * .25),
                                    rotateValue * -100)
                                ..rotateZ(rotateValue * (-pi / 2)),
                              child: child,
                            );
                          },
                        );
                      },
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(size.height * .25, -100)
                          ..rotateZ(-pi / 2),
                        child: Image.asset(
                          widget.item.image,
                          fit: BoxFit.fill,
                          height: size.height * .6,
                          width: 300,
                        ),
                      ),
                    ),
                  );
                }),
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (_scrollController.offset > 0.0 && !hide) {
                  setState(() {
                    hide = true;
                  });
                } else if (_scrollController.offset <= 0.0 && hide) {
                  setState(() {
                    hide = false;
                  });
                }
                return true;
              },
              child: ListView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 250),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.item.name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'By ${widget.item.by}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<bool>(
                      valueListenable: bloc.appBarHided,
                      builder: (context, appBarHided, child) {
                        return TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 1000),
                            tween: Tween(
                                begin: appBarHided ? 1.0 : 0.0,
                                end: appBarHided ? 0.0 : 1.0),
                            curve:
                                appBarHided ? Curves.elasticOut : Curves.ease,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0.0, -100 * value),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        widget.item.description,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        'SPEC',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'First Info',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                'Second Info',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                'Third Info',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                'Fourth Info',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 50),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.item.firstInfo,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                widget.item.secondInfo,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                widget.item.thirdInfo,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                widget.item.fourthInfo,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                    const Text(
                                      'GALLERY',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: 350,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {
                                          final itemList = items[index];
                                          return Image.asset(
                                            itemList.image,
                                            fit: BoxFit.fill,
                                            width: 300,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }),
                ],
              ),
            ),
            Positioned(
              left: 20,
              top: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
