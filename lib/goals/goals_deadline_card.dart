import 'package:flutter/material.dart';
import 'package:notes_and_goal/goals/goals_deadline_calendar.dart';

class GoalsDeadlineCard extends StatefulWidget {

  //Accept id of goal
  final goalId;
  final goalObject;
  GoalsDeadlineCard({Key? mykey, required this.goalId, required this.goalObject}) : super(key: mykey);

  @override
  _GoalsDeadlineCardState createState() => _GoalsDeadlineCardState(goalId, goalObject);
}

class _GoalsDeadlineCardState extends State<GoalsDeadlineCard>{
  final goalId;
  final goalObject;
  _GoalsDeadlineCardState(this.goalId, this.goalObject);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
        ElevatedButton(onPressed: 
        ()
        {
          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GoalsDeadline(goalId: goalId, goalObject: goalObject)),
                      );
        }
        
        , child: Text("Test"))
      ],
    )
    );
    
    // return Dialog(
    //   child: Container(
    //     padding: const EdgeInsets.symmetric(
    //       horizontal: 32,
    //       vertical: 16,
    //     ),
    //     height: 200,
    //     decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(5)
    //     ),
    //     child: Column(
    //       children: [
    //         Text("Would You like to Give this Goal a Deadline?",
    //           textAlign: TextAlign.center,
    //           style: TextStyle(fontWeight: FontWeight.w400),
    //         ),
    //         const SizedBox(
    //           height: 32,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Container(
    //               width: 100,
    //               height: 50,
    //               padding: EdgeInsets.all(0),
    //               margin: EdgeInsets.all(10),
    //               child: ElevatedButton(
    //                 style: ElevatedButton.styleFrom(
    //                 elevation: 0,
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(2),
    //                 ),
    //                 backgroundColor: Colors.blue[400],
    //                 foregroundColor: Colors.white, 
    //                 textStyle: TextStyle(fontFamily: "Sans-Serif", fontWeight: FontWeight.bold, letterSpacing: 5)
    //               ),
    //               onPressed: () {
    //                 Navigator.of(context).push(
    //                   //Then pass to GoalsDeadline
    //                   MaterialPageRoute(builder: (context) => GoalsDeadline(goalId: goalId, goalObject: goalObject))
    //                 );
    //               }, 
    //               child: const Text("Yes"))
    //             ),
    //             Container(
    //               width: 100,
    //               height: 50,
    //               padding: EdgeInsets.all(0),
    //               margin: EdgeInsets.all(10),
    //               child: ElevatedButton(
    //                 style: ElevatedButton.styleFrom(
    //                 elevation: 0,
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(2),
    //                 ),
    //                 backgroundColor: Colors.grey[500],
    //                 foregroundColor: Colors.white, 
    //                 textStyle: TextStyle(fontFamily: "Sans-Serif", fontWeight: FontWeight.bold, letterSpacing: 5)
    //               ),
    //               onPressed: () {
    //                 Navigator.pop(
    //                     context,
                        
    //                   );
    //               }, 
    //               child: const Text("No"))
    //             ),
                
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}