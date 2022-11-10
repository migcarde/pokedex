import 'package:flutter/widgets.dart';
import 'package:pokedex/common/dimens.dart';

class DialogAdapterWidget extends StatelessWidget {
  const DialogAdapterWidget({
    Key? key,
    required this.mobileDialog,
    this.tabletDialog,
    this.desktopDialog,
  }) : super(key: key);

  final Widget mobileDialog;
  final Widget? tabletDialog;
  final Widget? desktopDialog;

  @override
  Widget build(BuildContext context) {
    return _getWidget(MediaQuery.of(context).size.width);
  }

  Widget _getWidget(double width) {
    if (width <= Dimens.tabletWidth) {
      return mobileDialog;
    } else if (width <= Dimens.desktopWidth) {
      return tabletDialog ?? mobileDialog;
    } else {
      return desktopDialog ?? tabletDialog ?? mobileDialog;
    }
  }
}
