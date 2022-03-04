import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:height_slider/height_slider.dart';

import 'component/ageWeight.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BmiApp(title: 'sda',

    ),
  ));
}

class BmiApp extends StatefulWidget {
  final String title;

  const BmiApp({Key? key, required this.title}) : super(key: key);

  @override
  _BmiAppState createState() => _BmiAppState();
}

class _BmiAppState extends State<BmiApp> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController =  TextEditingController();
  final now = DateTime.now();
  final berlinWallFell = DateTime.utc(1989, 11, 9);


  int height = 170;
  int weight = 60;
  int bmi = 0;
  int age = 20;
  bool gender = false;
  bool _first = true;
  String name='';
  String text='';
  String tim='';
   ChatModel chatmodel = ChatModel(name: '', age: 0, weight:0, height:0, bmi: 0, tim: '',);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //show history
                Container(
                  margin: EdgeInsets.all(15),
                  child: NeumorphicButton(
                    child: Icon(Icons.history),
                    onPressed: () {
                      setState(() {
                        _first = !_first;
                      });
                    },
                  ),
                ),
                // restart calculator
                Container(
                  margin: EdgeInsets.all(15),
                  child: NeumorphicButton(
                    child: Icon(Icons.restart_alt),
                    onPressed: () {
                      setState(() {
                        persons.clear();
                        height = 170;
                        name='';
                        weight = 60;
                        bmi = 0;
                        age = 20;
                        gender = false;
                        _first = true;
                      });
                    },
                  ),
                ),
              ],),
              Center(
                  child: AnimatedCrossFade(
                duration: Duration(milliseconds: 1100),
                firstChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textFild(),
                    genderr(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        agrAndWeight(),
                        Height()
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        print(now);
                        setState(() {
                          CalcBmi(height, weight);
                           chatmodel= ChatModel(
                              name: name, age: age, height: height, weight: weight,bmi: bmi,tim:tim);
                          if (_formKey.currentState!.validate()){
                            dialog();
                            persons.add(chatmodel);
                            print(chatmodel.bmi);



                          }else{
                          }

                          _textController.clear();
                        });

                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 50,
                        width: 320,
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.concave,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12)),
                              depth: 4,
                              lightSource: LightSource.topLeft,
                              color: Colors.blue.shade800),
                          child:Center(
                            child: NeumorphicText(
                              'Calculate',
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
                  ],
                ),
                secondChild: history(),
                crossFadeState:
                    _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget history() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15)
      ),
      child:
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            NeumorphicText(
              'History',
              style: NeumorphicStyle(
                depth: 4, //customize depth here
                color: Colors.grey, //customize color here
              ),
              textStyle: NeumorphicTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold//customize size here
                // AND others usual text style properties (fontFamily, fontWeight, ...)
              ),
            ),

            Container(
                padding: EdgeInsets.all(25),
                width: 340,
                height: 450,
                child: ListView.builder(
                    itemCount: persons.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 10,
                        child: ListTile(
                          onTap: (){
                            print(this.bmi);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>PersonData(data: persons[index],)),
                            );
                          },
                          title: Text(persons[index].name),
                          subtitle: Text('age :${persons[index].age}'),
                          trailing: Column(
                            children: [

                              Text(persons[index].bmi.toString(),style: TextStyle(fontWeight: FontWeight.bold),),

                            ],
                          )
                        ),
                      );
                    })),
          ],

      ),

    );
  }
  Widget textFild(){
    return Form(
      key: _formKey,
      child: Container(
        height: 45,
        width: 320,
        margin: EdgeInsets.symmetric(vertical: 10),

        child: Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(12)),
              depth: 5,
              lightSource: LightSource.topLeft,
              color: Colors.white),
          child: TextFormField(
            controller: _textController,
            validator: (value){
              if (value == null || value.isEmpty) {
                return 'Enter first name';
              }
              return null;

            },
            onChanged: (text){
              name=text;
            },
            decoration: InputDecoration(
                hintText: 'First name...',
                border:InputBorder.none,
                contentPadding: EdgeInsets.all(10)

            ),
          ),
        ),
      ),
    );

  }
  Widget agrAndWeight(){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          height: 189,
          width: 150,
          child: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(12)),
                depth: 5,
                lightSource: LightSource.topLeft,
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicText(
                  'age',
                  style: NeumorphicStyle(
                    depth: 4, //customize depth here
                    color: Colors.grey, //customize color here
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 18, //customize size here
                    // AND others usual text style properties (fontFamily, fontWeight, ...)
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                NeumorphicText(
                  age.toString(),
                  style: NeumorphicStyle(
                    depth: 4, //customize depth here
                    color: Colors.grey, //customize color here
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 35, //customize size here
                    // AND others usual text style properties (fontFamily, fontWeight, ...)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicButton(
                        margin: EdgeInsets.all(10),
                        onPressed: () {
                          setState(() {
                            age--;
                          });
                        },
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            boxShape:
                            NeumorphicBoxShape.circle()),
                        padding: const EdgeInsets.all(16.5),
                        child: Text(
                          "-",
                          style: TextStyle(
                              color: Colors.black, fontSize: 25),
                        )),
                    NeumorphicButton(
                        margin: EdgeInsets.all(10),
                        onPressed: () {
                          setState(() {
                            age++;
                          });
                        },
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            boxShape:
                            NeumorphicBoxShape.circle()),
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "+",
                          style: TextStyle(
                              color: Colors.black, fontSize: 25),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
          height: 189,
          width: 150,
          child: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(12)),
                depth: 5,
                lightSource: LightSource.topLeft,
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicText(
                  'weight',
                  style: NeumorphicStyle(
                    depth: 5, //customize depth here
                    color: Colors.grey, //customize color here
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 18, //customize size here
                    // AND others usual text style properties (fontFamily, fontWeight, ...)
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                NeumorphicText(
                  weight.toString(),
                  style: NeumorphicStyle(
                    depth: 4, //customize depth here
                    color: Colors.grey, //customize color here
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 35, //customize size here
                    // AND others usual text style properties (fontFamily, fontWeight, ...)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicButton(
                        margin: EdgeInsets.all(10),
                        onPressed: () {
                          setState(() {
                            weight--;
                          });
                        },
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            boxShape:
                            NeumorphicBoxShape.circle()),
                        padding: const EdgeInsets.all(16.5),
                        child: Text(
                          "-",
                          style: TextStyle(
                              color: Colors.black, fontSize: 25),
                        )),
                    NeumorphicButton(
                        margin: EdgeInsets.all(10),
                        onPressed: () {
                          setState(() {
                            weight++;
                          });
                        },
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            boxShape:
                            NeumorphicBoxShape.circle()),
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "+",
                          style: TextStyle(
                              color: Colors.black, fontSize: 25),
                        )),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  Widget genderr(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              gender=false;

            });
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 150,
            child: Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(12)),
                  depth: 5,
                  lightSource: LightSource.topLeft,
                  color: (gender == false)
                      ? Colors.blueAccent
                      : Colors.white),
              child: Center(
                child: NeumorphicText(
                  "Male",
                  style: NeumorphicStyle(
                    depth: 5, //customize depth here
                    color: (gender == false)
                        ? Colors.white
                        : Colors.grey, //customize color here
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 18, //customize size here
                    // AND others usual text style properties (fontFamily, fontWeight, ...)
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              gender = true;
            });
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 150,
            child: Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(12)),
                  depth: 4,
                  lightSource: LightSource.topLeft,
                  color:
                  (gender == true) ? Colors.pink : Colors.white),
              child: Center(
                child: NeumorphicText(
                  "Female",
                  style: NeumorphicStyle(
                    depth: 4, //customize depth here
                    color: (gender == true)
                        ? Colors.white
                        : Colors.grey, //customize color here
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 18, //customize size here
                    // AND others usual text style properties (fontFamily, fontWeight, ...)
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget Height(){
    return   Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 390,
      width: 153,
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(12)),
            depth: 5,
            lightSource: LightSource.topLeft,
            color: Colors.white),
        child: HeightSlider(
          height: height,
          onChange: (val) => setState(() {
            height = val;
          }),
          unit: 'cm', // optional
        ),
      ),
    );
  }
  Future<Object?> dialog(){
    return showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          negativeText: 'Recalculate',
          positiveText: 'More',
          titleText: '$bmi',
          contentText:chatmodel.tim,

          onPositiveClick: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>PersonData(data: chatmodel)),
            );
          },
          onNegativeClick: () {
            setState(() {
              height=170;
              age=20;
              weight=60;

            });

            Navigator.pop(context);
          },
        );
      },
      animationType: DialogTransitionType.slideFromTopFade,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );

  }

  CalcBmi(int height,int weight){
    var b = height/100;
    var Bmi=weight/(b*b).round();
    bmi=Bmi.round();
    tim=now.toString();
  }

}

List<ChatModel> persons = [];

class ChatModel {
  final String name;
  final int age;
  final int height;
  final int weight;
  final int bmi;
  final String tim;

  ChatModel(

      {required this.name,
      required this.age,
      required this.height,
      required this.weight,
        required this.bmi,
        required this.tim,

      });
}
