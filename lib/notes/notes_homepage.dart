import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes_and_goal/notes/create_notes_page.dart';
import 'package:notes_and_goal/notes/edit_notes_page.dart';
import 'package:notes_and_goal/notes/notes_preview_card.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});
  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  List<String> storedNotes = [];

  //this method runs at start of app
  @override
  void initState()
  {
    super.initState();
  }

  //Future allows us
  Future<List<String>> loadSavedNotes() async {
    //get access to the shared preference object
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //store list of strings in variable
    storedNotes = prefs.getStringList("listOfNotes")!;
    return storedNotes;
  }

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
            //put the appbar above of the body and not ontop of it
            extendBodyBehindAppBar: false,
            appBar: 
            AppBar(
              backgroundColor: const Color(0xff313c3f),
              toolbarHeight: 100,
              //remove back button
              automaticallyImplyLeading: false,
              title: Container(
                width: 200,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: const Text("Your Notes Preview", style: TextStyle(color: Colors.white,)),
              ) 
            ),

            //FutureBuilder - allows us render the widget based on how long it takes
            //to get data from a remote resource
            
            body: FutureBuilder<List<String>>(

              // This connect the FutureBuilder and the Future
        future: loadSavedNotes(), // Your async function

        //what the Future returns is referred to as the snapshot object
        builder: (context, snapshot) {

          //snapshot has a variety of methods and properties
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Display the data when available
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(30, 10, 0, 10),
                  child: Text("Sort Notes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(25, 0, 10, 0),
                      child: ElevatedButton(
                    onPressed: () => {
                      
                  }, child: Text("Favorites")),
                    ),
                     
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                    onPressed: () => {
                      
                  }, child: Text("Date")),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                    onPressed: () => {

                      //push widget on stack
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const CreateNotesPage())
                        ),
                  }, child: const Text("Add Note")),
                    )
                     
                  ],
                ),
                
                //Exapanded Widget - ???
                Expanded(
                  
                  
                  //ListView - acts as a for loop and builds mutliple instances of the same widget
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                    
                    ),
                  //use array length to dictate the number of loops to run
                  itemCount: storedNotes.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    //convert json string to map
                    var notesConvertedToMap = jsonDecode(storedNotes![index]);
                    print(notesConvertedToMap["id"]);

                    //this block of code runs multiple time
                    return
                    //GestureDetector - makes widget interactable
                    //
                    GestureDetector(
                      onTap: ()=>{
                        //push widget on stack
                        Navigator.of(context).push(
                          //pass note data to edit notes page, 
                          //storedNotes![index] - gives us the specific note that is selected
                          MaterialPageRoute(builder: (context) => EditNotesPage(note: storedNotes![index],title: notesConvertedToMap["title"], body: notesConvertedToMap["body"]))
                        ),
                      },
                      //pass object keys as arguments to the Notes Preview Card Widget
                      child: NotesPreviewCard(
                        title: notesConvertedToMap["title"], 
                        body: notesConvertedToMap["body"],
                        favorite: notesConvertedToMap["favorite"],
                        creationTime: notesConvertedToMap["creation-time"],
                        ),
                      );
                    
                  }),
                ),
                 
                
              ],
            );
          } else {
            // Handle the case where no data is returned
            return Center(child: Text('No data found'));
          }
        },
      ),
          );
    
  }
}