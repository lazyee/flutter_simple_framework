import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'tap.dart';

class TitleBar extends StatelessWidget {
  final String? title;
  final TextStyle? titleTextStyle;
  final Widget? titleWidget;
  final bool isShowBackArrow;
  final Widget? leftWidget;
  final VoidCallback? onTapLeftwidget;
  final Widget? rightWidget;
  final double height;

  final Color? backgroundColor;
  const TitleBar(
      {Key? key,
      this.title,
      this.titleTextStyle,
      this.isShowBackArrow = true,
      this.leftWidget,
      this.height = 55,
      this.rightWidget,
      this.titleWidget,
      this.onTapLeftwidget,
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
        onTap: this.onTapLeftwidget ?? Get.back,
        child: Container(
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20.w,
          ),
          width: height,
          height: height,
        ));
  }

  Widget _buildTitleWidget() {
    if (titleWidget != null) return titleWidget!;

    if (title == null) return SizedBox();

    TextStyle defultTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 17.sp,
    );

    return Text(
      title ?? "",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: titleTextStyle ?? defultTextStyle,
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
