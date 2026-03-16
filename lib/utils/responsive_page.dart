import 'package:flutter/material.dart';

/// A small helper that makes pages responsive: provides SafeArea, scroll
/// on small devices, ensures content fills available height and adds
/// standard padding.
class ResponsivePage extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const ResponsivePage({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(padding: padding, child: child),
              ),
            ),
          );
        },
      ),
    );
  }
}
