import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes_and_goal/global_variables.dart';
import 'package:notes_and_goal/notes/notes_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditNotesPage extends StatefulWidget {
  const EditNotesPage({super.key, required this.title, required this.body, required this.note, required this.favoriteStatusConfirmed});
  final String title;
  final String body;
  final String note;
  final bool favoriteStatusConfirmed;
  @override
  State<EditNotesPage> createState() => _EditNotesPageState(title, body, note, favoriteStatusConfirmed);
}

class _EditNotesPageState extends State<EditNotesPage> {
  //this method runs at start of app
  @override
  void initState()
  {
    loadSavedNotes();
    super.initState();
  }
  
  final String title;
  final String body;
  final String note;
  bool favoriteStatusConfirmed;


  _EditNotesPageState(this.title, this.body, this.note, this.favoriteStatusConfirmed);
  //keeps track of what user is typing
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  List<String>? storedNotes = [];

  //load notes currently in device storage
  void loadSavedNotes() async {
    //get access to the shared preference object
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //store list of strings in list variable
    storedNotes = prefs.getStringList("listOfNotes");
  }

  //this method swicthes the list of notes in phone storage with the 
  //new storedNotes List
  void deleteNote() async {
    //get access to the shared preference object
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    //set local variables stored in device
    prefs.setStringList("listOfNotes", storedNotes!);

    //we must also update the global variables becuase it is used when adding 
    //notes to screen
    GlobalVariables.localNotesArray = storedNotes!;
  }

  
  

  String favoriteStatus = "";
  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;

   

    //prefill notes
    _titleController.text = title;
    _bodyController.text = body;

    int indexOfNote;
    var noteConvertedToMap;
    var noteConvertedToString;
    var favoriteIconColor = Color(0xffb9bcc3);

    if(favoriteStatusConfirmed ==  true)
    {
      favoriteStatus = "added";
    }else{
      favoriteStatus = "removed";
    }

    if(favoriteStatusConfirmed ==  false)
    {
      favoriteIconColor = Colors.grey;
    }
    if(favoriteStatusConfirmed ==  true)
    {
      favoriteIconColor = const Color(0xfffb7aa6);
    }
  
    
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
                child: const Text("Edit Notes", style: TextStyle(color: Colors.white,)),
              ) 
            ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
        ),
        margin: const EdgeInsets.all(0),
        child: //Stack - place note lines on top of text
        Stack(
          //alignment direction of placing items on top
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                //Title
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
                    controller: _titleController,
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
                      hintText: "Title",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        tooltip: "Added",
                        icon: Icon(
                        Icons.favorite,
                        color: favoriteIconColor,
                        size: 30.0,
                        ), 
                        onPressed: () => { 
                          if(favoriteStatus == "added")
                        {
                          
                          setState(() {
                            favoriteStatus = "removed";
                            favoriteStatusConfirmed = false;
                            favoriteIconColor = Colors.grey;
                            
                            print(favoriteStatus);
                          })
                        }else
                        {
                          setState(() {
                            favoriteStatus = "added";
                            favoriteStatusConfirmed = true;
                            favoriteIconColor = const Color(0xfffb7aa6);
                            print(favoriteStatus);
                          })
                        }
                         },

                      ),
                      
                    ),
                ),),
                
                const SizedBox(height: 50),

                //Body
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                    height: 300,
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextField(
                        //link this textfield to a variable to store user data
                        controller: _bodyController,
                        scrollPadding: const EdgeInsets.all(10),
                        decoration: const InputDecoration(
                          border: InputBorder.none
                        ),
                        style: const TextStyle(
                        fontSize: 20.0,
                        height: 2.5,
                        leadingDistribution: TextLeadingDistribution.even,
                        overflow: TextOverflow.visible,
                        letterSpacing: 2.0,
                        wordSpacing: 1.0,
                        fontFamily: "Sans Serif",
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none 
                        ),
                        maxLines: 5,
                        textInputAction: TextInputAction.done,
                    
                    )
                  ),
                  const SizedBox(height: 20),

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
                    onPressed: () async => {
                      //get access to the shared preference object
                      prefs = await SharedPreferences.getInstance(),
                      //locate index of goal we are giving deadline to
                      indexOfNote = storedNotes!.indexOf(note),
                      
                      //convert json string to map
                      noteConvertedToMap = jsonDecode(storedNotes![indexOfNote]),

                      //update note
                      noteConvertedToMap["body"] = _bodyController.text,
                      noteConvertedToMap["title"] = _titleController.text,
                      noteConvertedToMap["favorite"] = favoriteStatusConfirmed,
                      


                      
                      //update the current local storage of goals with the new array
                      //remove old element
                      storedNotes?.remove(storedNotes![indexOfNote]),

                      //convert goal object to string
                      noteConvertedToString = jsonEncode(noteConvertedToMap),

                      //insert object into original index position
                      storedNotes?.insert(indexOfNote, noteConvertedToString),

                      //update local storage
                      prefs.setStringList("listOfNotes", storedNotes!),


                      //update global array as well, because its still pulling from it
                      GlobalVariables.localNotesArray.remove(note),

                      //insert object into original index position
                      GlobalVariables.localNotesArray.insert(indexOfNote, noteConvertedToString),
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const NotesHomePage()),
                      )
                    }, 
                    child: const Text("Save")),
            
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
                backgroundColor: Colors.red[500], 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
                      
                    onPressed: () => {

                      //since storedNotes List is based on data in storage
                      //the note received from the notes_homepage should be within the List
                      //remove the note from the List
                      storedNotes?.remove(note),
                      
                      //this method then swicthes the list of notes in phone storage with the 
                      //new storedNotes List
                      deleteNote(),
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const NotesHomePage()),
                      )
                    }, 
                    child: const Text("Delete")),
                    ),
                    
                  ],)
                  
              ],
            ),
          ],
        ),
      ));
  }
}