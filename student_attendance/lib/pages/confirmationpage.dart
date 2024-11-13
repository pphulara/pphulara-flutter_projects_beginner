import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:student_attendance/model/user.dart';
import 'package:student_attendance/pages/todayscreen.dart';

class ConfirmationPage extends StatelessWidget {
  final String action; // "checkIn" or "checkOut"
  
  const ConfirmationPage({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm $action"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _confirmAction(action);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TodayScreen())); // Go back to TodayScreen
          },
          child: Text("Confirm $action"),
        ),
      ),
    );
  }

  Future<void> _confirmAction(String action) async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("students")
          .where('id', isEqualTo: User.studentId)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("students")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      if (action == "checkIn") {
        await FirebaseFirestore.instance
            .collection("students")
            .doc(snap.docs[0].id)
            .collection("Record")
            .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
            .update({
          'checkIn': DateFormat('hh:mm').format(DateTime.now()),
          'date': Timestamp.now(),
        });
      } else if (action == "checkOut") {
        await FirebaseFirestore.instance
            .collection("students")
            .doc(snap.docs[0].id)
            .collection("Record")
            .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
            .update({
          'checkOut': DateFormat('hh:mm').format(DateTime.now()),
          'date': Timestamp.now(),
        });
      }
    } catch (e) {
      // Handle errors, e.g., show an error message
      print("Error updating record: $e");
    }
  }
}
