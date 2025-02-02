import 'package:shared_preferences/shared_preferences.dart';


//all files have access to this class and its properties
class GlobalVariables{
  static int notesId = 0;
  static int goalsId = 0;

  //list of strings to store maps of notes in string format
  static List<String> localNotesArray = ['{"id" : "000", "title": " batman", "body": "Fight Crime" , "favorite": false, "creation-time": "2025-01-05 06:06:50.088928"}'];

  static List<String> localGoalsArray = ['{"id": "000", "title": "Go To Gym", "deadline": "2025-02-26 00:00:00.000", "creation-time": "2025-02-26 00:00:00.000"}'];

  // ignore: non_constant_identifier_names
  //this array stores notes
  static List notes_array = [
    {
      "id" : "001",
      "title": " batman",
      "body": "Fight Crime" ,
      "favorite": false,
      "creation-time": "2025-01-05 06:06:50.088928",
    },
    {
      "id" : "002",
      "title": " naruto",
      "body": "Hokage",
      "favorite": true,
      "creation-time": "2025-01-05 06:06:50.088928",
    },
    {
      "id" : "003",
      "title": " sasuke",
      "body": "Avenge",
      "favorite": false,
      "creation-time": "2025-01-05 06:06:50.088928",
    },
  ];

  //method that saves persistent variables to device storage
  //called at start-up
  static void use_local_storage() async {
    //get access to the shared preference object
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //set local variables stored in device
    prefs.setStringList("listOfNotes", localNotesArray);
    prefs.setStringList("listOfGoals", localGoalsArray);
    prefs.setString("test", "Local Storage is Working");
    prefs.setInt("notesId", 0);
    prefs.setInt("GoalsId", 0);

    //check if user has created
  }
  
}