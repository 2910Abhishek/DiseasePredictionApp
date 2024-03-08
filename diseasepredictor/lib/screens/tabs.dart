import 'package:diseasepredictor/screens/Hospital.dart';
import 'package:diseasepredictor/screens/auth.dart';
import 'package:diseasepredictor/screens/home.dart';
import 'package:diseasepredictor/screens/maps.dart';
import 'package:diseasepredictor/screens/profile.dart';
import 'package:diseasepredictor/screens/symptoms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    // TODO: implement createState
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = HomeScreen();
    var activePageTitle = 'Health DashBoard';
    if (_selectedPageIndex == 1) {
      activePage = SymptomsScreen();
      activePageTitle = 'Symptoms';
    }
    if (_selectedPageIndex == 2) {
      activePage = Maps();
      activePageTitle = 'Nearest Hospital';
    }
    if (_selectedPageIndex == 3) {
      activePage = ProfileScreen();
      activePageTitle = 'Profile';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AuthScreen()), // Navigate to your authentication screen
                );
                // Navigate to login screen or perform any other actions after sign out.
              } catch (e) {
                print("Error signing out: $e");
              }
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: activePage,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home Screen'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Diseases'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: 'Hospitals'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:meals/screens/categories.dart';
// import 'package:meals/screens/meals.dart';

// class TabScreen extends StatefulWidget{

//   const TabScreen({super.key});

// @override
//   State<TabScreen> createState() {
//     // TODO: implement createState
//     return _TabsScreenState();
//   }
// }

// class _TabsScreenState extends State<TabScreen>{

//   int _selectedPageIndex = 0;

//   void _selectPage(int index)
//   {
//     setState(() {
//       _selectedPageIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     Widget activePage = CategoriesScreen();
//     var activePageTitle = 'Categories';
//     if(_selectedPageIndex == 1)
//     {
//       activePage = MealsScreen(meals: []);
//       activePageTitle = 'Your favorites';
//     }

//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(activePageTitle),
//       ),
//       body: activePage,
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: _selectPage,
//         currentIndex: _selectedPageIndex,
//         items:const  [
//           BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Categories'),
//           BottomNavigationBarItem(icon: Icon(Icons.star) , label: 'Favorites')

//         ],
//       ),
//     );
//   }
// }