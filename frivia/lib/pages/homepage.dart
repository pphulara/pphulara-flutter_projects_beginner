import 'package:flutter/material.dart';
import 'package:frivia/pages/gamepage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _homePage();
  }
}

class _homePage extends State<HomePage>{
  double? _deviceHeight,_deviceWidth;
  double _difficultyLevel = 0;
  List <String> _difficulties=['Easy','Medium','Hard'];


  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 42, 40, 40),
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [title(),SizedBox(height: _deviceHeight!*0.05,),subtitle(),difficultySlider(),startButton(context)],
        ),
      ),
    );
  }

  Widget title(){
    return Text("Frivia", style: TextStyle(fontSize: 80,color: Colors.white),);
  }

  Widget subtitle(){
    return Text(_difficulties[_difficultyLevel.toInt()], style: TextStyle(fontSize: 30,color: Colors.white),);
  }

  Widget startButton(BuildContext context){
    return MaterialButton(
      onPressed: (){
         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Gamepage(difficulty: _difficulties[_difficultyLevel.toInt()],)),
            );
      },
      color: Colors.blue,
      height: _deviceHeight!*0.08,
      minWidth: _deviceWidth!*0.8,
      child: Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: _deviceHeight!*0.03,
        ),
        ),
    );
  }

  Widget difficultySlider(){
    return Slider(value: _difficultyLevel, onChanged: (_value){
      setState(() {
        _difficultyLevel=_value;
      });
    },
    activeColor: Colors.blue,
    min: 0,
    max: 2,
    divisions: 2,);
  }
}