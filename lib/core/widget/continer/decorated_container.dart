import 'package:flutter/material.dart';

import '../../resource/app_color.dart';

//A Decorated Container With Default Shadow Effect
class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    super.key,
    this.color,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.child,
    this.border,
    this.alignment,
    this.shape,
    this.boxShadow,
    this.image,
    this.borderRadius,
    this.isGradient,
  });
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Widget? child;
  final BoxBorder? border;
  final AlignmentGeometry? alignment;
  final BoxShape? shape;
  final List<BoxShadow>? boxShadow;
  final DecorationImage? image;
  final BorderRadiusGeometry? borderRadius;
  final bool? isGradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      alignment: alignment,
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        gradient: isGradient != null
            ? const LinearGradient(
                colors: [AppColor.white, AppColor.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        border: border,
        image: image,
        borderRadius: shape == BoxShape.circle
            ? null
            : borderRadius ?? BorderRadius.circular(3),
        boxShadow: boxShadow ??
            [
              const BoxShadow(
                color: Color.fromARGB(28, 130, 130, 130),
                blurRadius: 2,
                spreadRadius: 0,
                offset:
                    // changes position of shadow
                    Offset(3, 5),
              ),
            ],
        shape: shape ?? BoxShape.rectangle,
        color: color ?? AppColor.white,
      ),
      child: child,
    );
  }
}
