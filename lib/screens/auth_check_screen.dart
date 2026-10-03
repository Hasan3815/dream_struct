// import 'package:dream_struct/login/login.dart';
// import 'package:dream_struct/screens/project_type.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthCheckScreen extends StatelessWidget {
//   const AuthCheckScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       return ProjectType();
//     } else {
//       return FirstSlide(
//   userName: "",
//   userType: "user",
// );
//     }
//   }
// }

import 'package:dream_struct/architect_detail.dart';
import 'package:dream_struct/login/login.dart';
import 'package:dream_struct/screens/architect_create_profile.dart';
import 'package:dream_struct/screens/project_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheckScreen extends StatelessWidget {
  final String userType;

  const AuthCheckScreen({
    super.key,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return const ArchitectCreateProfileScreen();
    }

    return FirstSlide(
      userName: "",
      userType: userType,
    );
  }
}