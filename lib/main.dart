import 'package:assignment/routines.dart';
import 'package:assignment/streaks.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'firebase_options.dart';



void main() async{
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFfcf7fa)),
        useMaterial3: true,

      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = [
    Routines(),
    Streaks(),
  ];

  int badge = 0;
  double gap = 10;

  int _counter = 0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Routines",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.groups_2_outlined),
                label: "Streaks",
            ),

          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff8f4c61),
          unselectedItemColor: Colors.grey,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}
