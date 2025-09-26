import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AttendanceCheckinPage extends StatefulWidget {
  const AttendanceCheckinPage({super.key});

  @override
  State<AttendanceCheckinPage> createState() => _AttendanceCheckinPageState();
}

class _AttendanceCheckinPageState extends State<AttendanceCheckinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance Checkin')),
      body: Center(
        child: ElevatedButton(onPressed: () {}, child: Text('Checkin')),
      ),
    );
  }
}
