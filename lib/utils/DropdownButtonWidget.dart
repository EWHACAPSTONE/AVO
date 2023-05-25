import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatelessWidget {
  final String selectedValue;
  final void Function(String?) onChanged;

  DropdownButtonWidget({
    required this.selectedValue,
    required this.onChanged,
  });
  final List<String> _options = ['한 번 진동', '두 번 진동', '세 번 진동', '연속 진동'];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 5,
            offset: Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          iconSize: 50,
          iconEnabledColor: Colors.black,
          style: TextStyle(
              fontFamily: 'NanumSquare',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black),
          dropdownColor: Color.fromRGBO(255, 255, 255, 0.9),
          borderRadius: BorderRadius.circular(10),
          value: selectedValue,
          items: _options.map(
            (item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            },
          ).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
