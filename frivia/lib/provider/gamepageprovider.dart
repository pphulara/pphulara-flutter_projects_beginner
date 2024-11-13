import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier{
  final Dio _dio=Dio();
  BuildContext context;
  final int no_of_question=10;
  String? difficulty_of_question;
  List? list_of_questions;
  int _questioncount=0;
  int score=0;

  GamePageProvider({required this.context , required this.difficulty_of_question}){
    _dio.options.baseUrl='https://opentdb.com/api.php';
    _getquestion();
  }

  Future <void> _getquestion() async {
    var _response = await _dio.get(
      '', 
      queryParameters:{
        'amount':no_of_question,
        'type':'boolean',
        'difficulty':difficulty_of_question,
        }
  );

  var _data=jsonDecode(_response.toString());
  list_of_questions = _data["results"];
  notifyListeners();

  }

  String getcurrentquestion(){
    return list_of_questions![_questioncount]["question"];
  }

  void answer(String _answer) async{
    bool isCorrect = list_of_questions![_questioncount]["correct_answer"] == _answer;
    _questioncount++;
    isCorrect? score++ : null ;
    showDialog(context: context, builder: (BuildContext _context){
      return AlertDialog(
        backgroundColor: isCorrect? Colors.green : Colors.red,
        title: Column(
          children: [
            Text(
              isCorrect? "Right Answer" : "Wrong Answer",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              ),
            isCorrect? Icon(Icons.check_circle, color: Colors.white,) : Icon(Icons.cancel_sharp,color: Colors.white,),
          ],
        ),
      );
    });
    await Future.delayed(Duration(seconds: 1));
    Navigator.pop(context);
    if(_questioncount==no_of_question){
      endgame();
    }
    else{
    notifyListeners();
    }
  }

  Future <void> endgame() async{
    showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("SCORE"+ "\n" +"$score /10",style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
          textAlign: TextAlign.center,),
        );
      }
      );
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}