import 'package:flutter/material.dart';

class CoverClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final controlPoint = Offset(size.width / 4, size.height);
    final endpoint = Offset(size.width / 2, size.height);

    final controlPoint2 = Offset(size.width * 3 / 4, size.height);
    final endpoint2 = Offset(size.width, size.height - 40.0);

    final path = Path()
      ..lineTo(0.0, size.height - 40.0)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endpoint.dx, endpoint.dy)
      ..quadraticBezierTo(
          controlPoint2.dx, controlPoint2.dy, endpoint2.dx, endpoint2.dy)
      ..lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
