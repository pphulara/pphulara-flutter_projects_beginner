import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:student_attendance/model/user.dart';
import 'package:student_attendance/pages/qr_page.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn = "--/--";

  Color primary = Colors.blue;

  @override
  void initState() {
    super.initState();
    _getRecord();
  }


  void _getRecord() async {
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

      setState(() {
        checkIn = snap2['checkIn'];
      });
    } catch(e) {
      setState(() {
        checkIn = "--/--";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32),
                  child: Text(
                    "Welcome,",
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "NexaRegular",
                      fontSize: screenWidth / 7,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: screenHeight*0.11, left: screenWidth*0.01),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Student " + User.studentId,
                    style: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: screenWidth / 15,
                      color: primary,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                "Today's Status",
                style: TextStyle(
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 15,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Check In Time :",
                          style: TextStyle(
                            fontFamily: "NexaRegular",
                            fontSize: screenWidth / 15,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          checkIn,
                          style: TextStyle(
                            fontFamily: "NexaBold",
                            fontSize: screenWidth / 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: DateTime.now().day.toString(),
                  style: TextStyle(
                    color: primary,
                    fontSize: screenWidth / 12,
                    fontFamily: "NexaBold",
                  ),
                  children: [
                    TextSpan(
                      text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth / 15,
                        fontFamily: "NexaBold",
                      ),
                    ),
                  ],
                ),
              )
            ),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('hh:mm:ss a').format(DateTime.now()),
                    style: TextStyle(
                      fontFamily: "NexaRegular",
                      fontSize: screenWidth / 17,
                      color: Colors.black54,
                    ),
                  ),
                );
              },
            ),
            _qrScanner(),
            ],
        ),
      )
    );
  }

  Widget _qrScanner(){
     if(checkIn == "--/--"){
      return GestureDetector(
        onTap: (){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>QrPage(action:  "Check In")));
        },
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: screenHeight*0.05),
              child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.expand,
                          size: 150,
                          weight: 0.001,
                          color: primary,
                        ),
                        Icon(
                          FontAwesomeIcons.camera,
                          size: 80,
                          color: primary,
                        ),
                   ],
              ),
            ),
            Text(
              ' Scan QR To Check In',
              style: TextStyle(
                            fontFamily: "NexaRegular",
                            fontSize: screenWidth / 18,
                            color: Colors.black54,
                          ),
            ),
          ],
        ),
      );
     }
     else{
      return Container(
              margin: const EdgeInsets.only(top: 32, bottom: 32),
              child: Text(
                "Attendance Marked For Today! \n Have A Nice Day Ahead",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "NexaRegular",
                  fontSize: screenWidth / 18,
                  color: Colors.black54,
                ),
              ),
            );
     }
  }
}


