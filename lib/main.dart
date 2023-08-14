import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnalogClock extends StatefulWidget {
  const AnalogClock({super.key});

  @override
  AnalogClockState createState() => AnalogClockState();
}

class AnalogClockState extends State<AnalogClock> {
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  late Timer _timer;
  DateTime _dateTime = DateTime.now();

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClockPainter(_dateTime),
      size: const Size(300, 300),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime dateTime;

  ClockPainter(this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(size.width, size.height) / 2;

    // Draw the clock face
    canvas.drawCircle(
        Offset(centerX, centerY), radius, Paint()..color = Colors.white);

    // Draw the hour lines
    for (int i = 1; i <= 12; i++) {
      double angle = (360 * i) / 12;
      double x = centerX + radius * cos(angle * pi / 180);
      double y = centerY + radius * sin(angle * pi / 180);
      canvas.drawLine(Offset(centerX, centerY), Offset(x, y),
          Paint()..color = Colors.black);
    }

    // Draw the minute and second hands
    int minute = dateTime.minute;
    int hour = dateTime.hour;
    double minuteAngle = (360 * minute) / 60;
    double hourAngle = (360 * hour) / 12 + (minuteAngle / 12);
    double minuteX = centerX + radius * cos(minuteAngle * pi / 180);
    double minuteY = centerY + radius * sin(minuteAngle * pi / 180);
    double hourX = centerX + radius * cos(hourAngle * pi / 180);
    double hourY = centerY + radius * sin(hourAngle * pi / 180);
    canvas.drawLine(Offset(centerX, centerY), Offset(minuteX, minuteY),
        Paint()..color = Colors.black);
    canvas.drawLine(Offset(centerX, centerY), Offset(hourX, hourY),
        Paint()..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
