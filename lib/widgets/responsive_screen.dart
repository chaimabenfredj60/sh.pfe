import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool scrollable;

  const ResponsiveScreen({
    Key? key,
    required this.child,
    this.padding,
    this.scrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.getHorizontalPadding(context);

    final effectivePadding = padding ?? EdgeInsets.all(horizontalPadding);

    final content = Padding(
      padding: effectivePadding,
      child: child,
    );

    if (scrollable) {
      return SingleChildScrollView(child: content);
    }
    return content;
  }
}
