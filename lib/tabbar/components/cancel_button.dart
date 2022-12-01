import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class CancelButton extends StatelessWidget {
  const CancelButton(
      {super.key,
      required this.isHidden,
      required this.animationDuration,
      required this.size,
      required this.animationController,
      required this.tapEvent});

  final bool isHidden;
  final Duration animationDuration;
  final Size size;
  final AnimationController? animationController;
  final GestureTapCallback? tapEvent;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isHidden ? 0.0 : 1.0,
      duration: animationDuration,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: size.width,
          height: size.height * 0.1,
          alignment: Alignment.bottomCenter,
          child: IconButton(
            style: ButtonStyle(),
            icon: Icon(Icons.close),
            onPressed: tapEvent,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
