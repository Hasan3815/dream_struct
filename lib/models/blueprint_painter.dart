// import 'package:flutter/material.dart';

// class BlueprintPainter extends CustomPainter {
//   final List rooms;

//   BlueprintPainter(this.rooms);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;

//     final textPainter = TextPainter(
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );

//     for (var room in rooms) {
//       double x = room["x"] * 40;
//       double y = room["y"] * 40;
//       double w = room["width"] * 40;
//       double h = room["height"] * 40;

//       Rect rect = Rect.fromLTWH(x, y, w, h);
//       canvas.drawRect(rect, paint);

//       textPainter.text = TextSpan(
//         text: room["name"],
//         style: TextStyle(color: Colors.black, fontSize: 12),
//       );

//       textPainter.layout();
//       textPainter.paint(canvas, Offset(x + 5, y + 5));
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }