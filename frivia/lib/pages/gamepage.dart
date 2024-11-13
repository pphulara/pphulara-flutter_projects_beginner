import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frivia/provider/gamepageprovider.dart';

// ignore: must_be_immutable
class Gamepage extends StatelessWidget{
  double? _deviceHeight;
  double? _deviceWidth;
  GamePageProvider? _pageProvider;
  String? difficulty;
  Gamepage({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth=MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_context)=>GamePageProvider(context : context, difficulty_of_question: difficulty!.toLowerCase()),
      child: buildUI(),
      );
  }


  Widget buildUI() {
    return Builder(
      builder: (_context) {
        _pageProvider = _context.watch<GamePageProvider>();
        if(_pageProvider!.list_of_questions!=null){
          return Scaffold(
          backgroundColor: const Color.fromARGB(255, 42, 40, 40),
          body: SafeArea(
            child:
              Container(
                child: gameUI(),
                padding: EdgeInsets.symmetric(horizontal: _deviceHeight!*0.05),
            )
          ),
        );
        }
        else{
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      }
    );
  }

  Widget gameUI(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        questionText(),
        SizedBox(height: _deviceHeight!*0.01,),
        Column(
          children: [
            trueButton(),
            SizedBox(height: _deviceHeight!*0.01,),
            falseButton(),
        ],
      )],
    );
  }

  Widget questionText(){
    return Text(_pageProvider!.getcurrentquestion(),
    textAlign: TextAlign.center,
      style: TextStyle(      
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: _deviceHeight!*0.03,
      ),
      );
  }

  Widget trueButton(){
    return MaterialButton(
      onPressed: (){
        _pageProvider?.answer("True");
      },
      color: Colors.green ,
      height: _deviceHeight!*0.08,
      minWidth: _deviceWidth!*0.8,
      child: Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: _deviceHeight!*0.03,
        ),
        ),
    );
  }

  Widget falseButton(){
    return MaterialButton(
      onPressed: (){
        _pageProvider?.answer("True");
      },
      color: Colors.red ,
      height: _deviceHeight!*0.08,
      minWidth: _deviceWidth!*0.8,
      child: Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: _deviceHeight!*0.03,
        ),
        ),
    );
  }
}