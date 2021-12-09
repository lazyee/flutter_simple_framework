import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tap.dart';

class TitleBar extends StatelessWidget {
  final String? title;
  final TextStyle? titleTextStyle;
  final Widget? titleWidget;
  final bool isShowBackArrow;
  final Widget? leftWidget;
  final VoidCallback? onTapLeftWidget;
  final Widget? rightWidget;
  final double height;
  final Color color; //返回按钮和标题文字的颜色
  final Color? backgroundColor;
  const TitleBar(
      {Key? key,
      this.title,
      this.titleTextStyle,
      this.isShowBackArrow = true,
      this.leftWidget,
      this.height = 50,
      this.rightWidget,
      this.titleWidget,
      this.onTapLeftWidget,
      this.color = Colors.black,
      this.backgroundColor})
      : super(key: key);

  Widget _buildRightWidget() {
    if (rightWidget != null) {
      return Positioned(
          right: 0,
          child: Container(
            alignment: Alignment.center,
            child: rightWidget!,
            height: height,
          ));
    }

    return SizedBox();
  }

  Widget _buildLeftWidget() {
    if (!isShowBackArrow) return SizedBox();
    if (leftWidget != null) return leftWidget!;

    return Tap(
        onTap: this.onTapLeftWidget ?? Get.back,
        child: Container(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: color,
          ),
          width: height,
          height: height,
        ));
  }

  Widget _buildTitleWidget() {
    if (titleWidget != null) return titleWidget!;

    if (title == null) return SizedBox();

    TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: color,
      fontSize: 16,
    );

    return Text(
      title ?? "",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textStyle.merge(titleTextStyle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: height,
            padding: EdgeInsets.fromLTRB(height, 0, height, 0),
            child: _buildTitleWidget(),
          ),
          _buildLeftWidget(),
          _buildRightWidget()
        ],
      ),
    );
  }
}
