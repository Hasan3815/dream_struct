// import 'package:dream_struct/screens/select_quality.dart';
// import 'package:flutter/material.dart';

// class ProjectType extends StatefulWidget {
//   const ProjectType({super.key});

//   @override
//   State<ProjectType> createState() => ProjectTypeState();
// }

// class ProjectTypeState extends State<ProjectType> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Icon(Icons.ac_unit_rounded, color: Colors.white),
//         ],
//         backgroundColor: Color.fromARGB(255, 21, 27, 76),
//         title: Row(
//           children: [
//             Text(
//               'Hi,sarah ',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             // Icon(Icons.ac_unit_rounded, color: Colors.white),
//           ],
//         ),
//       ),

//       body: Container(
//         color: Colors.blue[100],
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),

//           child: Center(
//             child: Column(
//               // child: Text('Select Project Type', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
//               children: [
//                 SizedBox(height: 30),
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   clipBehavior: Clip.antiAlias,    // This is IMPORTANT — clips child to the rounded border

//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(12.0),
//                     onTap: () {
//                       setState(() {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SelectQuality(),
//                           ),
//                         );
//                       });
//                     },
//                     child: Container(
//                       height: 200,
//                       width: 300,
//                       color: Color.fromARGB(255, 21, 27, 76),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.home, size: 50, color: Colors.white),
//                             ],
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "New Project",
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               SizedBox(height: 5),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30),

//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(12.0),
//                     onTap: () {
//                       setState(() {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SelectQuality(),
//                           ),
//                         );
//                       });
//                     },
//                     child: Container(
//                       height: 200,
//                       width: 300,
//                       color: Color.fromARGB(255, 21, 27, 76),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.file_copy_sharp,
//                                 size: 50,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Previous Project",
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:dream_struct/login/login.dart';
import 'package:dream_struct/screens/architect_panel.dart';
import 'package:dream_struct/screens/personal_details.dart';
import 'package:dream_struct/screens/select_quality.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ProjectType extends StatefulWidget {
  const ProjectType({super.key});

  @override
  State<ProjectType> createState() => ProjectTypeState();
}

class ProjectTypeState extends State<ProjectType> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    DashboardScreen(),
    PersonalDetailsScreen(),
    ArchitectPanelScreen(),
  ];

  final List<String> titles = const [
    "Hi, Sarah",
    "Personal Details",
    "Architect Panel",
  ];

Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const FirstSlide(
  userName: "",
  userType: "user",
)
      ),
      (route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 27, 76),
        title: Text(
          titles[selectedIndex],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        actions: [
  const Padding(
    padding: EdgeInsets.only(right: 10),
    child: Icon(Icons.notifications, color: Colors.white),
  ),

  IconButton(
    icon: const Icon(Icons.logout, color: Colors.white),
    onPressed: () {
      logout(context);
    },
  ),
],
      ),

      body: screens[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 21, 27, 76),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Personal",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.architecture),
            label: "Architect",
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            projectCard(
              context: context,
              icon: Icons.home,
              title: "New Project",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectQuality(),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            projectCard(
              context: context,
              icon: Icons.file_copy_sharp,
              title: "Previous Project",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectQuality(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget projectCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 200,
          width: 300,
          color: const Color.fromARGB(255, 21, 27, 76),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(icon, size: 55, color: Colors.white),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}