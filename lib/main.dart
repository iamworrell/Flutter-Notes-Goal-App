import 'package:flutter/material.dart';
import 'package:notes_and_goal/global_variables.dart';
import 'package:notes_and_goal/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  //run at start of app
  @override
  void initState()
  {
    super.initState();

    //call the method to set data in local storage
    GlobalVariables.use_local_storage();
    loadData();
  }


  void loadData() async
  {
    //get access to the shared preference object
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //test if local storage is working
    print(prefs.getString("test"));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Productivity",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black26),
      //since we are using routing we need to set first route
      //initialRoute: HelpLaunchPage.route,

      //Register routes in the MaterialApp
      //getRoutes function comes from the routes.dart file
      routes: getRoutes()
    );
  }
}