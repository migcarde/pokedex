import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/text_styles.dart';
import 'package:pokedex/widgets/crystal_card.dart';

class SomethingWrongContent extends StatelessWidget {
  const SomethingWrongContent({Key? key}) : super(key: key);

  static const _imageSize = 200.0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CrystalCard(
          child: Padding(
        padding: const EdgeInsets.all(Dimens.largeDimen),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Oops, something was wrong',
              style: TextStyles.bold(
                  fontSize: Dimens.largeText, textColor: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.bigDimen),
              child: Image.asset(
                'assets/pikachu.png',
                fit: BoxFit.fill,
                height: _imageSize,
                width: _imageSize,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
