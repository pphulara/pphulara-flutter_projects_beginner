import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:student_attendance/model/user.dart';
import 'package:student_attendance/pages/homescreen.dart';

class QrPage extends StatefulWidget {
  final String? action;
  QrPage({required this.action});

  @override
  State<QrPage> createState() => _QrPageState(action: action);
}

class _QrPageState extends State<QrPage> {
  final String? action;
  double? _deviceHeight, _deviceWidth;
  final String targetQrCode = "Student Attendance App - By Priyanshu";

  _QrPageState({required this.action});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        backgroundColor: Colors.blue,
        title: Text(
          "Scan QR to $action",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "NexaBold",
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        height: _deviceHeight!*0.8,
        width: _deviceWidth,
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.1, vertical: _deviceHeight! * 0.2),
        child: Center(
          child: MobileScanner(
            fit: BoxFit.fill,
            onDetect: (barcodeCapture) async{
              final barcode = barcodeCapture.barcodes.first;
              if (barcode.rawValue == targetQrCode)  {
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

                        try {
                          String checkIn = snap2['checkIn'];

                          await FirebaseFirestore.instance
                              .collection("students")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .update({
                            'date': Timestamp.now(),
                            'checkIn': checkIn,
      
                          });
                        } catch (e) {

                          await FirebaseFirestore.instance
                              .collection("students")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .set({
                            'date': Timestamp.now(),
                            'checkIn': DateFormat('hh:mm').format(DateTime.now()),
                            });
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              }
            },
          ),
        ),
      ),
    );
  }
}
