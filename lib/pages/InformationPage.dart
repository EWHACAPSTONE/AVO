import 'package:flutter/material.dart';
import 'package:get/get.dart';

class informationPage extends StatelessWidget{




  @override
  Widget build(BuildContext context) {
     var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(15, 35, 0, 0),
            child: IconButton(
              onPressed: () {
                Get.toNamed('/');
              },
              icon: Image(image: AssetImage('images/icons/back.png')),
            ),
            height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10),
                child: Image(
                    image: AssetImage('images/logo.png'), width: w * 0.3)),
            Text(
              "about AVO",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
        Image(image: (AssetImage('images/avo_4.png')), width: w * 0.9),
         Image(image: (AssetImage('images/avoInfo.png')), width: w * 0.9),

      ],
    ));
  }

 

}
