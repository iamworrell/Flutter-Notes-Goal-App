import 'package:flutter/material.dart';
import 'package:notes_and_goal/goals/goals_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditGoals extends StatefulWidget {
  final String title;
  final String deadline;
  final String creationTime;
  final String goal;
  const EditGoals({super.key, required this.goal, required this.title, required this.deadline, required this.creationTime});

  @override
  // ignore: no_logic_in_create_state
  State<EditGoals> createState() => _EditGoalsState(title, deadline, creationTime, goal);
}

class _EditGoalsState extends State<EditGoals> {
  //this method runs at start of app
  @override
  void initState()
  {
    loadSavedGoals();
    super.initState();
  }

  List<String>? storedGoals = [];

  //load notes currently in device storage
  void loadSavedGoals() async {
    //get access to the shared preference object
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //store list of strings in list variable
    storedGoals = prefs.getStringList("listOfGoals");
  }

  //this method swicthes the list of notes in phone storage with the 
  //new storedNotes List
  void deleteGoal() async {
    //get access to the shared preference object
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    //set local variables stored in device
    prefs.setStringList("listOfGoals", storedGoals!);
  }
  
  final String title;
  final String deadline;
  final String creationTime;
  final String goal;

  _EditGoalsState(this.title, this.creationTime, this.deadline, this.goal);

  @override
  Widget build(BuildContext context) {


    //Format Dates
    int? deadlineYear = DateTime.parse(deadline).year;
    int? deadlineMonth = DateTime.parse(deadline).month;
    int? deadlineDay = DateTime.parse(deadline).day;

    int? creationYear = DateTime.parse(creationTime).year;
    int? creationMonth = DateTime.parse(creationTime).month;
    int? creationDay = DateTime.parse(creationTime).day;
    int? hour = DateTime.parse(creationTime).hour;
    int? minute = DateTime.parse(creationTime).minute;

    //Calculate the number of days until deadline
    DateTime startDate = DateTime(creationYear, creationMonth, creationDay);
    DateTime endDate = DateTime(deadlineYear, deadlineMonth, deadlineDay);

    int daysBetween = endDate.difference(startDate).inDays;

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
                  child: Text("$title", style: const TextStyle()),
                ) 
                ],) 
              ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Card(
          color: Color.fromARGB(255, 105, 148, 218),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      shadowColor: null,
      elevation: 0,

      //color of card when elevation is applied
      surfaceTintColor: null,
      borderOnForeground: true,

      //shape of the card will take effect on the child
      //if this is set to none the color of the child will be above the card shape and color
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: const BoxDecoration(
          
          //Gradient Color
          // gradient: LinearGradient(
          // colors: [Color(0xffd4ebec), Color(0xffbdc8cb), Color(0xffbdc8cb), Color(0xffb0bbbe)],
          // begin: Alignment.topCenter,
          // end: Alignment.bottomCenter,
          // stops: [0, 0.7, 0.7, 1]
          // ),
        ),
        height: 300,
        width: 500,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$daysBetween', style: const TextStyle(),), 
            const Text('Days to Deadline', style: TextStyle(),), 
            const SizedBox(height: 120), 
            Container(
                      width: 300,
            height: 40,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                    child: const Text("Extend Deadline")),
            
            ),
            Container(
                      width: 300,
            height: 40,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                    child: const Text("Add Reminder")),
            
            ),
            ],
        ),
      ),
    ),
        Container(
          margin: EdgeInsets.fromLTRB(250, 0, 0, 24),
          alignment: Alignment.center,
          child: Column(children: [
            const Icon(Icons.av_timer_sharp, size: 40, color: Colors.white,),
            const Text("Deadline: ", style: TextStyle(color: Colors.red),),
            Text("$deadlineMonth /$deadlineDay /$deadlineYear", style: const TextStyle(color: Colors.red),)
          ],)
          
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 250, 24),
          alignment: Alignment.center,
          child: Column(children: [
            const Icon(Icons.create_outlined, size: 30, color: Colors.white,),
            const Text("Created at: ", style: TextStyle(color: Colors.white),),
            Text("$creationMonth /$creationDay /$creationYear", style: const TextStyle(color: Colors.white),)
          ],)
          
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
          alignment: Alignment.center,
          child: Column(children: [
            Icon(Icons.lightbulb_outline, size: 30, color: Colors.white,),
            Text("Created at: ", style: TextStyle(color: Colors.white),),
          ],)
          
        ),
      ],
    ),
    Container(
                      width: 370,
            height: 40,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white, 
                backgroundColor: Colors.red[500], 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
                    onPressed: () => {
                      //since storedGoals List is based on data in storage
                      //the goal received from the goals_homepage should be within the List
                      //remove the goal from the List
                      storedGoals?.remove(goal),
                      
                      //this method then swicthes the list of goals in phone storage with the 
                      //new storedGoals List
                      deleteGoal(),
                      
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const GoalsHomePage()),
                      )
                    }, 
                    child: const Icon(Icons.delete_forever_outlined, color: Colors.white,)),
            
            ),

        ],),
    );
  }
}