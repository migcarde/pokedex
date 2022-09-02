import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';

class ScreenAdapterWidget extends StatelessWidget {
  final Widget mobileScreen;
  final Widget? tabletScreen;
  final Widget? desktopScreen;

  const ScreenAdapterWidget({
    Key? key,
    required this.mobileScreen,
    this.tabletScreen,
    this.desktopScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget screen;
    if (MediaQuery.of(context).size.width <= Dimens.tabletWidth) {
      screen = mobileScreen;
    } else if (MediaQuery.of(context).size.width <= Dimens.desktopWidth) {
      screen = tabletScreen ?? mobileScreen;
    } else {
      screen = desktopScreen ?? tabletScreen ?? mobileScreen;
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/pokedex_background.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: screen,
      ),
    );
  }
}
