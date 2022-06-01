import 'package:flutter/material.dart';
import 'package:mobile_activites/presentation/screen/activities_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> widgets = [
    const Center(
      child: Text("Home"),
    ),
    ActivitiesScreen(),
    const Center(
      child: Text("Order"),
    ),
    const Center(
      child: Text("Profil"),
    ),
  ];

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 0, 21, 140),
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
              backgroundColor: Color.fromARGB(255, 0, 21, 140)),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "My Activity",
              backgroundColor: Color.fromARGB(255, 0, 21, 140)),
          BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner),
              label: "Orders",
              backgroundColor: Color.fromARGB(255, 0, 21, 140)),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "My Profile",
              backgroundColor: Color.fromARGB(255, 0, 21, 140)),
        ],
        currentIndex: currentIndex,
        onTap: (int i) {
          setState(() {
            currentIndex = i;
          });
        },
      ),
    );
  }
}
