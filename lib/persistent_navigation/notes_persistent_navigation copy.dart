import 'package:flutter/material.dart';
import 'package:notes_and_goal/goals/goals_homepage.dart';
import 'package:notes_and_goal/notes/notes_homepage.dart';

//This class is responsible for the persistent nav bar on the productivity tab
class NotesPersistentNavigation extends StatefulWidget {
  const NotesPersistentNavigation({super.key});

  @override
  State<NotesPersistentNavigation> createState() => _NotesPersistentNavigationState();
}

class _NotesPersistentNavigationState extends State<NotesPersistentNavigation> {
  GlobalKey<NavigatorState> NotesPersistentNavigationKey = GlobalKey<NavigatorState>();
  
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: NotesPersistentNavigationKey,
      onGenerateRoute: (RouteSettings settings)
      {
        return MaterialPageRoute(

          builder: (BuildContext context)
          {
            //as long as we are on the ProductivtySplashPage() page, anything that uses a named route that matches the setting.name value
            //will send us to the corresponding page with the nav bar still on the screen
            if(settings.name == '/editnotes')
            {
              return const NotesHomePage();
            }

            //This returns the splash page on default, so we can use the arent class as an element in the navigation bar
            return const NotesHomePage();
          });
      },
    );
  }
}