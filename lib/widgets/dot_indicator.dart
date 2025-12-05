import 'package:flutter/material.dart';

class DotIndicator extends Decoration {
  final Color color;
  final double radius;

  const DotIndicator({this.color = Colors.blue, this.radius = 4});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DotPainter(color, radius);
  }
}

class _DotPainter extends BoxPainter {
  final Color color;
  final double radius;

  _DotPainter(this.color, this.radius);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration config) {
    final Offset circleOffset = Offset(
      offset.dx + config.size!.width / 2,
      offset.dy + config.size!.height,
    );
    final Paint paint = Paint()..color = color;
    canvas.drawCircle(circleOffset, radius, paint);
  }
}