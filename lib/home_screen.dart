import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_and_goal/persistent_navigation/goals_persistent_navigation.dart';
import 'package:notes_and_goal/persistent_navigation/notes_persistent_navigation%20copy.dart';


//Home Screen is first screen, it initiates the navigation bar logic
class HomeScreen extends StatefulWidget {
  //Variable for the routing
  static String route = "/home";
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //index for nav bar
  int currentIndex = 0;
  

  @override
  Widget build(BuildContext context) {

    //This is the array used to store the nav bar items (icons),
    //depending on what the user selected
    List<NavigationDestination> navBarItems = [];
    
    List<Widget> screens = [];
    //The subsequent set of if statments dictates
    //Nav bar output, which depends on what is stored in the choiceInStringFormat, this is based on user selection

      //Array of navBar Icons
      navBarItems = [
          const NavigationDestination(
            selectedIcon: (Icon(Icons.home)),
            icon: Icon(Icons.home_outlined),
            label: "Home"
          ),
          const NavigationDestination(
            selectedIcon: (Icon(Icons.auto_graph)),
            icon: Icon(Icons.star_border_purple500_outlined),
            label: "Goals"
          ),
          const NavigationDestination(
            selectedIcon: (Icon(Icons.settings)),
            icon: Icon(Icons.create_rounded),
            label: "Notes"
          ),
        ];
      //This Array represents the order of the screens in the nav bar
      //element at index 0 is the screen for the left most icon in the nav bar
      screens = [
        const Center(child: Text('Home')),
        const Center(child: GoalsPersistentNavigation()),
        const Center(child: NotesPersistentNavigation()),
    ];
    

    
    
    
    
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
        //curves of navbar
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
        //color of the container the navbar is in
        //color: Color(0xff161d1d),
        //Gradient Color
        // gradient: LinearGradient(
        // colors: [Color.fromARGB(255, 31, 29, 29), Color.fromARGB(255, 59, 57, 57)],
        // begin: Alignment.topCenter,
        // end: Alignment.bottomCenter,
        // stops: [0.0, 1]
        // ),
        ),

      child: Theme(
        data: ThemeData(
          //Remove default ripple and circle effect of anything
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent

        ),
        child: NavigationBarTheme(
        data: NavigationBarThemeData(
          //background color of icon on select
          indicatorColor: Colors.transparent,
          
          

          //text style of icon label
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              // fontSize: 10,
              // fontFamily: "",
              color: Colors.white
            ),
          )
        ),
        child: //Navigation Bar
        NavigationBar(
        //color of navbar
        backgroundColor: Color(0xff161d1d),
        overlayColor: null,
        shadowColor: null,
        //animation
        animationDuration: const Duration(milliseconds: 500),
        //labels
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,

        //
        selectedIndex: currentIndex,

        //When a user taps an icon, the newIndex value changes based on what they tap
        //since each icon has a value
        onDestinationSelected: (int newIndex){
          setState(() {
            //assign newindex value to currentIndex
            //on tap of navbar icon the value of currentIndex changes
            //the currentIndex is then used to select a Widget in the screens Array
            currentIndex = newIndex;
          });
        },

        //The destinationd property take an array of NavigationDestination Widgets that generate the icons
        //navBarItems is an array created based on user selection
        destinations: navBarItems,
        ),
      ),
      ),
      
      
      
    
      ),

      //
      body: Center(
        //screens is an array and the item selected is changed based on user 
        //Output to body is based on
        child: screens[currentIndex],
      )
    );
  }
}