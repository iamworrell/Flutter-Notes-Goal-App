import 'package:flutter/material.dart';
import 'package:notes_and_goal/goals/create_goals_page.dart';

class GoalsTags extends StatefulWidget {
  final int index;
  const GoalsTags({super.key, required this.index});

  @override
  State<GoalsTags> createState() => _GoalsTagsState(index);
}

class _GoalsTagsState extends State<GoalsTags> {
  final index;

  _GoalsTagsState(this.index);

  @override
  Widget build(BuildContext context) {

    String title = "";

    //Give tag a title based on the index generated by the listview
    switch(index)
    {
      case 0: title = "Add Goals";
              break;
      case 1: title = "Goals in Progress";
              break;
      case 2: title = "Completed Goals";
              break;
    }
    
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button background color
              foregroundColor: Colors.white, // Text color
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal), // Text styling
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              elevation: 0, // Shadow elevation
              shadowColor: Colors.black, // Shadow color
              side: const BorderSide(color: Colors.black, width: 0), // Border color and width
            ),
              onPressed: () => {
                //only the button with the add goals title can navigate
                if(title == "Add Goals")
                {
                    Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const CreateGoals())
                        ),
                }
                
            }, child: Text(title)),
            ],
        ),
    );
  }
}