// @dart=2.9
import 'package:flutter/material.dart';
import 'package:alkhadm/sql_helper.dart';
import 'dart:math'as math;

class CustomButtonNBar extends StatefulWidget {
  @override
  _CustomButtonNBarState createState() => _CustomButtonNBarState();
}

class _CustomButtonNBarState extends State<CustomButtonNBar> {
  @override
  Widget build(BuildContext context) {
    SQL_Helper sqlHelper = SQL_Helper();
    return FutureBuilder(
      builder: (context, s) {
        return BottomNavigationBar(
          currentIndex: 2,
          selectedFontSize: 20,
          unselectedFontSize: 20,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money),
                label: "معاملات : " + s.data[0].toString()),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "اشتراكات : " + s.data[1].toString()),
            BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: "صافي : " + (s.data[1] + s.data[0]).toString())
          ],
        );
      },
      future: sqlHelper.getTotal(),
    );
  }
}

//////////////////////////////////
class MyShape extends CircularNotchedRectangle{
  @override
  Path getOuterPath(Rect host, Rect guest) {
    if (guest == null || !host.overlaps(guest))
      return Path()..addRect(host);
      final double notchRadius = guest.width / 2.0;

      const double s1 = 8.0;
      const double s2 = 1.0;

      final double r = notchRadius;
      final double a = -1.0 * r - s2;
      final double b = host.top - guest.center.dy;

      final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
      final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
      final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
      final double p2yA = math.sqrt(r * r - p2xA * p2xA);
      final double p2yB = math.sqrt(r * r - p2xB * p2xB);

      // ignore: deprecated_member_use
      final List<Offset> p = List<Offset>(6);

      // p0, p1, and p2 are the control points for segment A.    
      p[0] = Offset(a - s1, b);
      p[1] = Offset(a, b);
      final double cmp = b < 0 ? -1.0 : 1.0;
      p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA,- p2yA) : Offset(p2xB, p2yB);

      // p3, p4, and p5 are the control points for segment B, which is a mirror
      // of segment A around the y axis.
      p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
      p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
      p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

      // translate all points back to the absolute coordinate system.
      for (int i = 0; i < p.length; i += 1)
        p[i] += guest.center;
      return Path()
        ..moveTo(host.left, host.top)
        ..lineTo(p[1].dx, p[1].dy)
        ..arcToPoint(
          p[4],
          radius: Radius.circular(notchRadius),
          clockwise: true,
        )
        ..lineTo(host.right, host.top)
        ..lineTo(host.right, host.bottom)
        ..lineTo(host.left, host.bottom)
        ..close();
    }
}