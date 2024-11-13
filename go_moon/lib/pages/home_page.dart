// ignore_for_file: unused_import

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_moon/widgets/costomDropDownWidget.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  late double _devicehieght,_devicewidth;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _devicehieght=MediaQuery.of(context).size.height;
    _devicewidth=MediaQuery.of(context).size.width;
      return Scaffold(
      body: SafeArea(
        child :Padding(padding: EdgeInsets.symmetric(horizontal: _devicewidth* 0.05),
        child: SizedBox(
          width: _devicewidth,
          height: _devicehieght,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child:_astroImageWidget(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   _pageTitle(),
                  _bookride(),
                ]
              ),
            ]
            
          ),
          ),
          ),
      )
      );
  }

  Widget _pageTitle(){
    return const Text("GO MOON",
    textAlign: TextAlign.center,
    style: 
    TextStyle(
      color: Colors.white ,
      fontSize: 60,
      fontWeight: FontWeight.bold,)
      );
  }

  // ignore: unused_element
  Widget _astroImageWidget(){
    return Container(
        height: _devicehieght*0.55,
        width: _devicewidth*0.55,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/astro_moon.png"),
        )
        ),
      );
  }

  Widget _numberOfPeopleDropDown(){
    return CostomDropDownButtonClass(item: const ['1','2','3','4'], width: _devicewidth*0.35);
  }

  Widget _passengerInformation(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _numberOfPeopleDropDown(),
        _passengerClassDropDown(),
      ],
    );
  }

  Widget _stationNamesDropDown(){
    return CostomDropDownButtonClass(item: const ['GOMUKH STATION','ARAWALI STATION','NANDA DEVI STATION','KAILASH STATION'], width: _devicewidth);
  }

  Widget _passengerClassDropDown(){
    return CostomDropDownButtonClass(item: const ['ECONOMY','SECOND CLASS','THIRD CLASS','AC'], width: _devicewidth*0.45);
  }

  Widget _bookride(){
    return Container(
      height: _devicehieght*0.35,
      child: Column(
        mainAxisAlignment :MainAxisAlignment.spaceAround,
        children: [
          _stationNamesDropDown(),
          _passengerInformation(),
          _rideButton(),
        ]
      )
    );
  }

  Widget _rideButton(){
    return Container(
      width : _devicewidth,
      decoration: BoxDecoration(
        color:  const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(10), 
      ),
      child: MaterialButton(onPressed: (){},
      child: const Text("BOOK MY RIDE!!",
        style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}