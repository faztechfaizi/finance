import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String? text;
  final Color? color;
  final Widget child;
  final VoidCallback? onTap;

  const AppButton({
    super.key,
    this.text,
    this.height,
    this.width,
    required this.onTap,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Center(child: child),
      ),
    );
  }
}
