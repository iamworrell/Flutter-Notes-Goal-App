import 'package:flutter/material.dart';
import 'package:notes_and_goal/global_variables.dart';
import 'package:notes_and_goal/notes/notes_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNotesPage extends StatefulWidget {
  const CreateNotesPage({super.key});

  @override
  State<CreateNotesPage> createState() => _CreateNotesPageState();
}

class _CreateNotesPageState extends State<CreateNotesPage> {

  //keeps track of what user is typing
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();


  var favoriteIconColor = Color(0xffb9bcc3);
  String favoriteStatus = "removed";
  bool favoriteStatusConfirmed = false;
  DateTime? datetime_default_format;
  String? datetime_default_format_string = DateTime.now().toString();

  //keep track of created notes
  int noteIdentificationNumber = 0;

  @override
  Widget build(BuildContext context) {
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
                child: const Text("Add Note", style: TextStyle(color: Colors.white,)),
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
                const SizedBox(height: 30),
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
                  ElevatedButton(
                    onPressed: () => {
                      setState(() async {
                        //get access to the shared preference object
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        noteIdentificationNumber = prefs.getInt("notesId")!;
                        noteIdentificationNumber++;

                        //add string to array global variable localNotesArray
                        GlobalVariables.localNotesArray.add(
                        '{"id" : $noteIdentificationNumber, "title": "${_titleController.text}", "body": "${_bodyController.text}", "favorite":  $favoriteStatusConfirmed, "creation-time": "$datetime_default_format_string"}');
                        
                        //update local variable
                        prefs.setStringList("listOfNotes", GlobalVariables.localNotesArray);
                        prefs.setInt("notesId", noteIdentificationNumber);
                      //
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const NotesHomePage()),
                      );
                      }),
                    }, 
                    child: const Text("Save"))
              ],
            ),
          ],
        ),
      ));
  }
}