import 'package:flutter/material.dart';

class CarouselFlowDelegate extends FlowDelegate {
  final double scrollOffset;

  CarouselFlowDelegate({required this.scrollOffset});

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      // Atur posisi item berdasarkan scrollOffset
      final double offset = (i - scrollOffset).abs();
      final double scale = 1.0 - (offset * 0.2).clamp(0.0, 0.5);

      final double dx = context.getChildSize(i)!.width * i - scrollOffset;
      final double dy =
          context.size.height / 2 - context.getChildSize(i)!.height * scale / 2;

      context.paintChild(
        i,
        transform: Matrix4.translationValues(dx, dy, 0)..scale(scale),
      );
    }
  }

  @override
  bool shouldRepaint(CarouselFlowDelegate oldDelegate) {
    return scrollOffset != oldDelegate.scrollOffset;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, constraints.maxHeight / 2);
  }
}
