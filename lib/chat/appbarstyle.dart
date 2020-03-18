import 'package:flutter/material.dart';

class CubicBezierShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();
    Offset control1 = Offset(rect.width, rect.height * 1.8);
    Offset control2 = Offset(0.0, 0.0);
    Offset endPoint = Offset(rect.width, rect.height * 0.0);
    path.lineTo(0.0, rect.height* 1.20);
    path.cubicTo(
        control2.dx, control2.dy, control1.dx, control1.dy, endPoint.dx,
        endPoint.dy);
    path.lineTo(0.0, 0.0);
    
    path.close();
    return path;
  }
}

class CubicBezierShapeBorderBottom extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();
    Offset control1 = Offset(rect.width, rect.height * 0.66);
    Offset control2 = Offset(0.0, rect.height * -2.33);
    Offset endPoint = Offset(rect.width, rect.height * -2.0);
    path.cubicTo(
        control2.dx, control2.dy, control1.dx, control1.dy, endPoint.dx,
        endPoint.dy);
    path.lineTo(rect.width, rect.height);
    path.lineTo(0.0, rect.height);
    path.lineTo(0.0, 0.0);

    
    path.close();
    return path;
  }
}


class CubicBezierLogin extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();
    Offset control1 = Offset(-rect.width * 0.2, rect.height * 1.25);
    Offset control2 = Offset(rect.width * 0.8, 0.0);
    Offset endPoint = Offset(rect.width, rect.height);
    path.lineTo(rect.width * 0.2, 0.0);
    path.cubicTo(
        control2.dx, control2.dy, control1.dx, control1.dy, endPoint.dx,
        endPoint.dy);
    path.lineTo(rect.width, 0.0);
    
    path.close();
    return path;
  }
}