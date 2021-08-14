import 'package:flutter/material.dart';

class FocusNodeGestureDetector extends StatelessWidget {
  final List<FocusNode?> focusNodes;
  final Widget? child;
  final VoidCallback? onTap;

  const FocusNodeGestureDetector(
      {Key? key, this.focusNodes = const [], this.child, this.onTap})
      : super(key: key);

  void unAllFocus() {
    focusNodes.forEach((item) {
      if (item != null) {
        if (item.hasFocus) {
          item.unfocus();
        }
      }
    });
  }

  bool hasFocus() {
    for (int i = 0; i < focusNodes.length; i++) {
      if (focusNodes[i]?.hasFocus == true) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap?.call();
        unAllFocus();
      },
      child: child,
    );
  }
}
