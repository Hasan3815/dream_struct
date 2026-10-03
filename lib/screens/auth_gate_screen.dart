import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream_struct/screens/architect_create_profile.dart';
import 'package:dream_struct/screens/architect_dashboard_screen.dart';
import 'package:dream_struct/screens/project_type.dart';
import 'package:dream_struct/screens/role_selection_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGateScreen extends StatelessWidget {
  const AuthGateScreen({super.key});

  // Future<Widget> getStartScreen() async {
  //   final user = FirebaseAuth.instance.currentUser;

  //   if (user == null) {
  //     return const RoleSelectionScreen();
  //   }

  //   final doc = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user.uid)
  //       .get();

  //   if (!doc.exists) {
  //     await FirebaseAuth.instance.signOut();
  //     return const RoleSelectionScreen();
  //   }

  //   final data = doc.data()!;
  //   final role = data["role"];
  //   final isProfileCompleted = data["isProfileCompleted"] ?? false;

  //   if (role == "user") {
  //     return const ProjectType();
  //   }

  //   if (role == "architect") {
  //     if (isProfileCompleted == true) {
  //       return const ArchitectDashboardScreen();
  //     } else {
  //       return const ArchitectCreateProfileScreen();
  //     }
  //   }

  //   return const RoleSelectionScreen();
  // }

  Future<Widget> getStartScreen() async {
  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const RoleSelectionScreen();
    }

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    if (!doc.exists) {
      await FirebaseAuth.instance.signOut();
      return const RoleSelectionScreen();
    }

    final data = doc.data()!;
    final role = data["role"];
    final isProfileCompleted = data["isProfileCompleted"] ?? false;

    if (role == "user") {
      return const ProjectType();
    }

    if (role == "architect") {
      if (isProfileCompleted == true) {
        return const ArchitectDashboardScreen();
      } else {
        return const ArchitectCreateProfileScreen();
      }
    }

    return const RoleSelectionScreen();
  } catch (e) {
    print("🔥 ERROR in AuthGate: $e");
    return const RoleSelectionScreen();
  }
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getStartScreen(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.blue[100],
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
  return const RoleSelectionScreen();
}

return snapshot.data ?? const RoleSelectionScreen();

        // return snapshot.data!;
      },
    );
  }
}