import 'dart:convert';
import 'dart:math';
import 'package:coincap/pages/detailspage.dart';
import 'package:coincap/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Homepage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _homepagestate();
  }

}

class _homepagestate extends State <Homepage>{
  double? _devicehieght;
  double? _devicewidth;
  HTTPService? _http;
  String _selectedCoin = "Bitcoin";

  @override
  void initState() {
    super.initState();
    _http=GetIt.instance.get<HTTPService>();
  }

  @override
  Widget build(BuildContext context) {
    _devicehieght=MediaQuery.of(context).size.height;
    _devicewidth=MediaQuery.of(context).size.width;
   return Scaffold(
    // appBar: AppBar(
    //   centerTitle: true,
    //   backgroundColor: Color.fromARGB(255, 56, 111, 212),
    //   title: Text("RateBit",
    //   textAlign: TextAlign.center,
    //    style: TextStyle(
    //     fontSize: _devicehieght!*0.06,
    //    ),
    //   ),
    // ),
    body: SafeArea(child: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _coindropdown(),
        _datawidgets(),]
        ),
    ),
    ),
    backgroundColor: Color.fromARGB(255, 56, 83, 216),
   );
  }


  
  Widget _coindropdown(){
    List <String> _coins=["Bitcoin","Ethereum","Tether","Ripple","Cardano"];
    
    List <DropdownMenuItem<String>> _value= _coins.map((e) =>
    DropdownMenuItem<String>(
      value: e ,
      child: Text(e.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: _devicehieght!*0.045,
        fontWeight: FontWeight.w500,
      ),
    )
    )
    ).toList();
    return DropdownButton<String>(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      alignment: AlignmentDirectional.topCenter,
      value: _selectedCoin,
      items: _value, 
      onChanged: (String? value){
        setState(() {
          _selectedCoin=value!;
        });
      },
      dropdownColor: const Color.fromARGB(255, 76, 79, 255),
      icon: SizedBox.shrink(),
      underline: Container(),
      borderRadius: BorderRadius.circular(_devicewidth!*0.05),
      elevation: 9,
      );
  }


  Widget _datawidgets(){
    return FutureBuilder(
      future: _http!.get("/coins/$_selectedCoin".toLowerCase()),
      builder: (BuildContext _context, AsyncSnapshot _snapshot){
        if(_snapshot.hasData){
           Map _data=jsonDecode( _snapshot.data.toString());
           num _usdprice= _data["market_data"]["current_price"]["usd"];
           num _changevalue = _data["market_data"]["price_change_percentage_24h"];
           String _urlofimage = _data["image"]["small"];
           String _coindescription = _data["description"]["en"].toString();
           Map _exchangerates= _data["market_data"]["current_price"];
           return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector( 
                child: _coinImage(_urlofimage),
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext _context){
                  return Detailspage(rates: _exchangerates,);
                }));},),
              _price(_usdprice),
              _changeinvalue(_changevalue),
              _description(_coindescription)
            ],
           );
        }
        else{
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      }
      );
  }

  Widget _price(num _rate){
    return Text("${_rate.toStringAsFixed(2)} USD"
    ,style: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.w400,
    ),
    );
  }

  Widget _changeinvalue(num _change){
    return Text(
      "${_change.toString()}%",
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _coinImage(_imageurl){
    return Image.network(
      "$_imageurl",
      scale: 0.7,
    );
  }

  Widget _description(_textdescription){
    return Container(
      height:_devicehieght!*0.60,
      width: _devicewidth!*0.9,
      margin: EdgeInsets.symmetric(vertical: _devicehieght!*0.05),
      padding: EdgeInsets.symmetric(horizontal: _devicehieght!*0.01,vertical: _devicewidth!*0.01),
      child: SingleChildScrollView(
      child : Text(_textdescription,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),),

      )
      
    );
    
  }

}
