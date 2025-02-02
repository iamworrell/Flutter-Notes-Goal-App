import 'package:flutter/material.dart';
import 'package:notes_and_goal/notes/notes_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditNotesPage extends StatefulWidget {
  const EditNotesPage({super.key, required this.title, required this.body, required this.note});
  final String title;
  final String body;
  final String note;
  @override
  State<EditNotesPage> createState() => _EditNotesPageState(title, body, note);
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


  _EditNotesPageState(this.title, this.body, this.note);
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
  }

  
  @override
  Widget build(BuildContext context) {
    

   

    //prefill notes
    _titleController.text = title;
    _bodyController.text = body;

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
                    onPressed: () => {
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