import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? radius;
  final Color? color;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Gradient? gradient;
  final BoxDecoration? decoration;
  final BoxConstraints? constraints;
  const CustomContainer({
        super.key,
        this.radius,
        this.color,
        this.child,
        this.width,
        this.height,
        this.borderColor,
        this.padding,
        this.margin,
        this.borderRadius,
        this.gradient,
        this.decoration,
        this.constraints,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      constraints: constraints,
      decoration: decoration ??
          BoxDecoration(
              gradient: gradient,
              border: borderColor != null
                  ? Border.all(color: borderColor ?? Colors.grey)
                  : null,
              borderRadius: borderRadius ??
                  BorderRadius.all(Radius.circular(radius ?? 0.0)),
              color: color),
      child: child,
    );
  }
}