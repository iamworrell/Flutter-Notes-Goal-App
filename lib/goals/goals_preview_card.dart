import 'package:flutter/material.dart';
import 'package:notes_and_goal/goals/edit_goals_page.dart';

class GoalsPreviewCard extends StatefulWidget {
  final title;
  final deadline;
  final creationTime;
  final goal;
  const GoalsPreviewCard({super.key, required this.goal, required this.title, required this.deadline, required this.creationTime});

  @override
  // ignore: no_logic_in_create_state
  State<GoalsPreviewCard> createState() => _GoalsPreviewCardState(title, deadline, creationTime, goal);
}

class _GoalsPreviewCardState extends State<GoalsPreviewCard> {
  final title;
  final deadline;
  final creationTime;
  final goal;

  _GoalsPreviewCardState(this.title, this.creationTime, this.deadline, this.goal);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        
      },
      child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(40, 10, 0, 0),
          width: 300,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue[300], // Background color
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
            boxShadow: const [
              BoxShadow(
                // color: Colors.grey.withOpacity(0.5),
                // spreadRadius: 2,
                // blurRadius: 5,
                // offset: Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(50, 0, 20, 0),
            leading: null,
            title: Text(title),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditGoals(title: title, deadline: deadline, creationTime: creationTime, goal: goal)),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          alignment: Alignment.center,
          child: null
        ),
      ],
    )
    );
    
  }
}