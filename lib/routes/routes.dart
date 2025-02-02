import 'package:flutter/material.dart';
import 'package:notes_and_goal/goals/goals_homepage.dart';
import 'package:notes_and_goal/home_screen.dart';


getRoutes() {
  return {
    // "/" - represents the first screen
    "/": (context) => HomeScreen(),
    HomeScreen.route: (context) => const HomeScreen(),
    GoalsHomePage.route: (context) => const GoalsHomePage(),
  };
}