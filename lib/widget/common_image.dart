import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CommonImage extends StatelessWidget {
  final String? url;
  final String? asset;
  final File? file;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeHolder;
  final Widget? failed;
  final String? package;

  const CommonImage(
      {Key? key,
      this.file,
      this.asset,
      this.url,
      this.width,
      this.height,
      this.failed,
      this.placeHolder,
      this.package,
      this.fit = BoxFit.cover})
      : super(key: key);

  const CommonImage.url(this.url,
      {Key? key,
      this.width,
      this.height,
      this.placeHolder,
      this.failed,
      this.asset,
      this.file,
      this.package,
      this.fit = BoxFit.cover})
      : super(key: key);

  const CommonImage.asset(this.asset,
      {Key? key,
      this.url,
      this.file,
      this.width,
      this.height,
      this.package,
      this.failed,
      this.placeHolder,
      this.fit = BoxFit.cover})
      : super(key: key);

  const CommonImage.file(this.file,
      {Key? key,
      this.asset,
      this.url,
      this.width,
      this.height,
      this.failed,
      this.placeHolder,
      this.package,
      this.fit = BoxFit.cover})
      : super(key: key);

  Widget onLoadStateChanged(ExtendedImageState state) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return Container(
            child: placeHolder ?? SizedBox(), width: width, height: height);
      case LoadState.completed:
        return ExtendedRawImage(
          image: state.extendedImageInfo?.image,
          width: width,
          height: height,
          fit: fit,
        );
      case LoadState.failed:
        return Container(
            color: Color(0xFFF0F0F0),
            child: failed ?? SizedBox(),
            width: width,
            height: height);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (asset != null) {
      return ExtendedImage.asset(
        asset!,
        width: width,
        height: height,
        fit: fit,
        package: package,
        loadStateChanged: onLoadStateChanged,
      );
    }

    if (file != null) {
      return ExtendedImage.file(
        file!,
        width: width,
        height: height,
        fit: fit,
        loadStateChanged: onLoadStateChanged,
      );
    }

    if (url != null) {
      return ExtendedImage.network(
        url!,
        width: width,
        height: height,
        fit: fit,
        loadStateChanged: onLoadStateChanged,
      );
    }

    return Container(child: SizedBox(), width: width, height: height);
  }
}
