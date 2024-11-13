import 'package:coincap/pages/homepage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Detailspage extends StatelessWidget{
final Map rates;
const Detailspage({required this.rates});
  
  @override
  Widget build(BuildContext context) {
    double _devicehieght = MediaQuery.of(context).size.height;
    double _devicewidth = MediaQuery.of(context).size.width;
    List _currencies=rates.keys.toList();
    List _exchangerates=rates.values.toList();
    return Scaffold(
      body : Container(
        height: _devicehieght,
        width: _devicewidth,
        child: ListView.builder(
          itemCount: _currencies.length,
          itemBuilder: (_context,_index){
            String _currency = _currencies[_index].toString().toUpperCase();
            String _exchangerate = _exchangerates[_index].toString().toUpperCase();
            return ListTile(
              title: Text("$_currency: $_exchangerate",style: TextStyle(color: Colors.white,fontSize: 20),),
            );
          },
        )
      ),
      backgroundColor: Color.fromARGB(255, 56, 83, 216),
    );
  }
}