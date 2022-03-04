import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../main.dart';

class PersonData extends StatelessWidget {
  final ChatModel data;
  PersonData({required this.data});

  String text='';


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
        Container(
        height: 150,
        width: 150,
        child: Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(130)),
              depth: 5,
              lightSource: LightSource.topLeft,
              color: Colors.white),
              child: CircularPercentIndicator(
                radius: 68.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 8.0,
                percent: ShowCircul(),
                center: NeumorphicText(
                  '${this.data.bmi}',
                  style: NeumorphicStyle(
                    depth: 4, //customize depth here
                    color: Colors.green.shade800, //customize color here
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold//customize size here
                    // AND others usual text style properties (fontFamily, fontWeight, ...)
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.white,
                progressColor: ShowCirculColor()
              ),
            ),),
            SizedBox(
              height: 150,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)
                  ),
                  color: Colors.white
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NeumorphicText(
                        'Hello dear ${this.data.name}',
                        style: NeumorphicStyle(
                          depth: 4, //customize depth here
                          color: Colors.black54, //customize color here
                        ),
                        textStyle: NeumorphicTextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold//customize size here
                          // AND others usual text style properties (fontFamily, fontWeight, ...)
                        ),
                      ),
                      SizedBox(height: 20,),
                      NeumorphicText(Showtext(),
                        style: NeumorphicStyle(
                          depth: 4, //customize depth here
                          color: Colors.black54, //customize color here
                        ),
                        textStyle: NeumorphicTextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold//customize size here
                          // AND others usual text style properties (fontFamily, fontWeight, ...)
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {


                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>BmiApp(title: '',)),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          width: 200,
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.concave,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(12)),
                                depth: 4,
                                lightSource: LightSource.topLeft,
                                color: Colors.blue.shade900),
                            child:Center(
                              child: NeumorphicText(
                                'ReCalculate',
                                style: NeumorphicStyle(
                                  depth: 4, //customize depth here
                                  color: Colors.white, //customize color here
                                ),
                                textStyle: NeumorphicTextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold//customize size here
                                  // AND others usual text style properties (fontFamily, fontWeight, ...)
                                ),
                              ),
                            ) ,
                          ),
                        ),
                      ),
                      NeumorphicText(
                        'thank you for using our app \nGoodLuck',
                        style: NeumorphicStyle(
                          depth: 4, //customize depth here
                          color: Colors.black54, //customize color here
                        ),
                        textStyle: NeumorphicTextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold//customize size here
                          // AND others usual text style properties (fontFamily, fontWeight, ...)
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
  Showtext(){
    if(this.data.bmi<24&&this.data.bmi>18){

     return 'your Bmi is ${this.data.bmi}\nYoure Completly Safe';
    }else if(this.data.bmi<18){
     return 'your Bmi is ${this.data.bmi}\n you are so thin,See a nutritionist ';

    }else if(this.data.bmi>24){
     return 'your Bmi is ${this.data.bmi}\n you are so fat,See a nutritionist ';
    }


  }
  ShowCirculColor(){
    if(this.data.bmi<24&&this.data.bmi>18){

     return Colors.green;
    }else if(this.data.bmi<18){
     return Colors.yellow;

    }else if(this.data.bmi>24){
     return Colors.red;
    }


  }
  ShowCircul(){
    if(this.data.bmi<24&&this.data.bmi>18){

     return 0.5;
    }else if(this.data.bmi<18){
     return 0.3;

    }else if(this.data.bmi>24){
     return 0.9;
    }


  }
}
