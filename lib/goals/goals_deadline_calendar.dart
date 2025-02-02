import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes_and_goal/goals/goals_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalsDeadline extends StatefulWidget {
  //Accept id of goal
  final goalId;
  final goalObject;
  GoalsDeadline({Key? mykey, required this.goalId, required this.goalObject}) : super(key: mykey);

  @override
  _GoalsDeadlineState createState() => _GoalsDeadlineState(goalId, goalObject);
}

class _GoalsDeadlineState extends State<GoalsDeadline> {
  final goalId;
  final goalObject;
  _GoalsDeadlineState(this.goalId, this.goalObject);

  
  DateTime _dateTime = DateTime.now();
  DateTime selectedDate = DateTime.now();

  List<String>? volatileListOfGoals = [];
  int indexOfGoal = 0;
  var goalConvertedToMap;
  var goalConvertedToString;
  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;
    return Scaffold(
      backgroundColor: const Color(0xffdcdcd1),
      appBar: AppBar(
              backgroundColor: const Color(0xffdcdcd1),
              toolbarHeight: 100,
              //remove back button
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: const Text("Choose a Deadline", style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 2, // Spacing between letters
                    color: Colors.black,
                    fontFamily: 'San Francisco',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal, // Italic text
                    decoration: TextDecoration.none, // Underlined text
                    decorationColor: null, // Decoration color
                    decorationThickness: 2,

                  )),
                ) 
                ],) 
              ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            SizedBox(
              height: 100,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _dateTime,
                onDateTimeChanged: (dateTime) {
                  setState(() {
                    print(dateTime);
                    selectedDate = dateTime;
                  });
                },
              ),
            ),
            SizedBox(height: 30),
            Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    
                    children: [
                      Container(
                      width: 100,
            height: 40,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white, 
                backgroundColor: Colors.grey[500], 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
                    onPressed: () => {
                      Navigator.pop(
                        context,
                        
                      )
                    }, 
                    child: const Text("Cancel")),
            
            ),
                    

                    Container(
                      width: 100,
            height: 40,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white, 
                backgroundColor: Colors.blue[400], 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
                      
                    onPressed: ()async  => {
                      prefs = await SharedPreferences.getInstance(),
                      volatileListOfGoals = prefs.getStringList("listOfGoals"),

                      //locate index of goal we are giving deadline to
                      indexOfGoal = volatileListOfGoals!.indexOf(goalObject),
                      
                      //convert json string to map
                      goalConvertedToMap = jsonDecode(volatileListOfGoals![indexOfGoal]),

                      //update deadline
                      goalConvertedToMap["deadline"] = "$selectedDate",
                      print(goalConvertedToMap),

                      
                      //update the current local storage of goals with the new array
                      //remove old element
                      volatileListOfGoals?.remove(volatileListOfGoals![indexOfGoal]),

                      //convert goal object to string
                      goalConvertedToString = jsonEncode(goalConvertedToMap),

                      //add to object to array
                      volatileListOfGoals?.add(goalConvertedToString),

                      //update local storage
                      prefs.setStringList("listOfGoals", volatileListOfGoals!),

                      Navigator.pushNamedAndRemoveUntil(context, GoalsHomePage.route, arguments: GoalsDeadline,(Route<dynamic> route) => false),
                    }, 
                    child: const Text("Save")),
                    ),
                    
                  ],)
            
          ],
          
        )
    );
  }
}