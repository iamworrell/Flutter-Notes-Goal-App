import 'package:flutter/material.dart';
import 'package:notes_and_goal/global_variables.dart';
import 'package:notes_and_goal/goals/goals_deadline_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateGoals extends StatefulWidget {
  const CreateGoals({super.key});

  @override
  State<CreateGoals> createState() => _CreateGoalsState();
}

class _CreateGoalsState extends State<CreateGoals> {
  var goalObject;
  var volatileGoalId;
  void initState()
  {
    
    super.initState();
  }
  //keeps track of what user is typing
  final _goalController = TextEditingController();


  DateTime currentTime = DateTime.now();

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
                  child: null
                ) 
                ],) 
              ),
      body: Column(
        children: [
          SizedBox(height: 300,),
          Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  height: 100,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: TextField(

                    //link this textfield to a variable to store user data
                    controller: _goalController,
                    cursorHeight: 30,
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    style: const TextStyle(
                        fontSize: 20.0,
                        leadingDistribution: TextLeadingDistribution.even,
                        overflow: TextOverflow.visible,
                        letterSpacing: 2.0,
                        wordSpacing: 1.0,
                        fontFamily: "Sans Serif",
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none 
                        ),
                    decoration: InputDecoration(
                      hintText: "Goal goes here...",
                      border: InputBorder.none,
                      
                      
                    ),

                    
                ),),
                SizedBox(height: 20,),
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
                backgroundColor: Colors.brown[500], 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
                      
                    onPressed: () async => {
                      //get access to the shared preference object
                      prefs = await SharedPreferences.getInstance(),

                      //store id in variable
                      volatileGoalId = prefs.getInt("GoalsId")!,

                      //increment id to make it unique
                      volatileGoalId++,

                      //update if in 
                      prefs.setInt("GoalsId", volatileGoalId),
                      

                      //add goal object to global array localGoalsArray
                      goalObject = '{"id": $volatileGoalId,"title" : "${_goalController.text}", "deadline" : "", "creation-time" : "$currentTime"}',
                      GlobalVariables.localGoalsArray.add(goalObject),
                      
                      //update the current local storage of goals with the new array
                      prefs.setStringList("listOfGoals", GlobalVariables.localGoalsArray),
                      

                      //To create the dialog for some reason we cant return the HelpLauchPage Widget directly
                      //in a Widget. We have to create a Scaffold and return HelpLaunchPage in the body
                      //GoalsDeadlineCard(goalId: volatileGoalId) - pass data to GoalsDeadlineCard() widget
                      //showDialog(context: context, builder: (context) => GoalsDeadlineCard(goalId: volatileGoalId, goalObject: goalObject))
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GoalsDeadlineCard(goalId: volatileGoalId, goalObject: goalObject))),
                      
                    }, 
                    child: const Text("Save")),
                    ),
                    
                  ],)
        ],
      )
    );
  }
}