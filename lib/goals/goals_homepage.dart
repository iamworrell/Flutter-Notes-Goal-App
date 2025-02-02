import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes_and_goal/goals/create_goals_page.dart';
import 'package:notes_and_goal/goals/goals_preview_card.dart';
import 'package:notes_and_goal/goals/goals_tags.dart';
import 'package:notes_and_goal/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalsHomePage extends StatefulWidget {
  //Variable for the routing
  static String route = "/goals";
  const GoalsHomePage({super.key});

  @override
  State<GoalsHomePage> createState() => _GoalsHomePageState();
}

class _GoalsHomePageState extends State<GoalsHomePage> {
  List<String> storedGoals = [];

  //this method runs at start of app
  @override
  void initState()
  {
    super.initState();
  }

  //Future allows us
  Future<List<String>> loadSavedGoals() async {
    //get access to the shared preference object
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //store list of strings in variable
    storedGoals = prefs.getStringList("listOfGoals")!;
    return storedGoals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: const Text("Goals", style: TextStyle(
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
      backgroundColor: const Color(0xffdcdcd1),
      body: FutureBuilder<List<String>>(

              // This connect the FutureBuilder and the Future
        future: loadSavedGoals(), // Your async function

        //what the Future returns is referred to as the snapshot object
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return LoadingScreen();
          }
          else if(snapshot.hasError)
          {
            return LoadingScreen();
          }
          else if(snapshot.hasData)
          {
            if(storedGoals.isEmpty)
            {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 250, 0),
                  child: const Text("Set Your Goals", 
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 2, // Spacing between letters
                    color: Colors.black,
                    fontFamily: 'San Francisco',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal, // Italic text
                    decoration: TextDecoration.none, // Underlined text
                    decorationColor: null, // Decoration color
                    decorationThickness: 2,
                  )),
                ),
                const SizedBox(height: 30),
                const Text("You currently don't have any goals"),
                      const SizedBox(height: 30),
                  GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const CreateGoals())
                              );
                  },
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  shape: const CircleBorder(
                    eccentricity: 1,
                    ),
                  color: Colors.brown[200],
                  child: const SizedBox(
                    width: 110,
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      Text("Add Goal",
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 2, // Spacing between letters
                        color: Colors.black,
                        fontFamily: 'San Francisco',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal, // Italic text
                        decoration: TextDecoration.none, // Underlined text
                        decorationColor: null, // Decoration color
                        decorationThickness: 2,
                        ),
                      ),
                      SizedBox(height: 0),
                      Icon(
                      Icons.add_circle_outline_outlined,
                      color: Colors.white,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),

                    ],
                  )
                  )
                  
                ),
                ),
                ],
              );
            }
            else
            {

            
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 250, 0),
                  child: const Text("Set Your Goals", 
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 2, // Spacing between letters
                    color: Colors.black,
                    fontFamily: 'San Francisco',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal, // Italic text
                    decoration: TextDecoration.none, // Underlined text
                    decorationColor: null, // Decoration color
                    decorationThickness: 2,
                  )),
                ), 
                SizedBox(height: 10,),
                Container(
          color: const Color(0xffdcdcd1),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: 70,
          child: Container(
            height: 0,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {

              //generate goal tags
              return GoalsTags(index: index);
            }),
          )
          
          
          ),
                
                 
                const SizedBox(height: 50,),
                
                Expanded(child: ListView.builder(
                  itemCount: storedGoals.length,
                  itemBuilder: (context, index) {
                    var mappedGoal = jsonDecode(storedGoals[index]);

                    return GoalsPreviewCard(title: mappedGoal["title"], deadline: mappedGoal["deadline"], creationTime: mappedGoal["creation-time"], goal: storedGoals[index]);
                  },
                ),),],
            );}
          } 
          else {
            return LoadingScreen();
          }
        })
      
    );
  }
} 