import 'package:flutter/material.dart';

class Tap extends StatelessWidget {
  final Widget? child;
  final GestureTapCallback? onTap;
  final EdgeInsets padding;
  final bool enable;
  const Tap(
      {Key? key,
      this.child,
      this.onTap,
      this.padding = EdgeInsets.zero,
      this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: !enable,
        child: InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            child: child,
            padding: padding,
          ),
          onTap: onTap,
        ));
  }
}
