import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CostomDropDownButtonClass extends StatelessWidget{
  late List<String> item;
  late double width;

  CostomDropDownButtonClass({required this.item , required this.width});
  
    @override
    Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width*0.05),
      width: width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(59, 56, 56, 1),
        borderRadius: BorderRadius.circular(10), 
      ),
      child: DropdownButton(
      value: item.first,
      onChanged: (_) { },
      items: item.map((e){
      return DropdownMenuItem(
        child : Text(e),
        value : e,
    );
    },
    ).toList(),
      underline: Container(),
      dropdownColor: const Color.fromRGBO(59, 56, 56, 1),
      style: 
      const TextStyle(
        color: Colors.white,
      ),
      ),
    );
  }
}