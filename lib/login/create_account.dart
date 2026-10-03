// import 'package:flutter/material.dart';

// enum Age { male, female, other }

// class CreateAccount extends StatefulWidget {
//   const CreateAccount({super.key});

//   @override
//   State<CreateAccount> createState() => _CreateAccountState();
// }

// class _CreateAccountState extends State<CreateAccount> {
// Age _selectedAge = Age.male;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.blue[100],
//         child: Center(
//           child: Card(
//             child:Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SizedBox(
//                 height:500,
//                 width:300,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Create Account",
//                       style: TextStyle(
//                         fontSize: 30,
//                         color: const Color.fromARGB(255, 16, 30, 110),
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          
              
//                         ),
//                         labelText: 'Full Name',
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         ),
//                         labelText: 'Mobile Number',
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         ),
//                         labelText: 'Email Address',
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         ),
//                         labelText: 'Age',
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     DropdownButton<Age>(
              
//                           value: _selectedAge,
              
//                           items: Age.values.map((age) {
//                             return DropdownMenuItem<Age>(
//                               value: age,
//                               child: Text(age.name.toUpperCase()),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             if (value == null) {
//                               return;
//                             }
//                             setState(() {
//                               _selectedAge = value;
//                             });
//                           },
//                         ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.indigo[900],
//                         padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          
                          
              
//                         ),
//                       ),
//                       onPressed: () {}, 
//                       child:
//                       Text("Create Account",style: TextStyle(color: Colors.white),),
//                       )
              
//                   ],
              
//                 ),
                
              
//               ),
//             )
//           ),
//         ),
//       )
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream_struct/screens/architect_create_profile.dart';
import 'package:dream_struct/screens/project_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Gender { male, female, other }

class CreateAccount extends StatefulWidget {
  final String userType;
  const CreateAccount({super.key,required this.userType,});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  Gender selectedGender = Gender.male;

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  // Future<void> signupUser() async {
  //   final name = nameController.text.trim();
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();

  //   if (name.isEmpty || email.isEmpty || password.isEmpty) {
  //     showMessage("Please fill name, email and password");
  //     return;
  //   }

  //   if (password.length < 6) {
  //     showMessage("Password must be at least 6 characters");
  //     return;
  //   }

  //   try {
  //     setState(() => isLoading = true);

  //     final credential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     await credential.user?.updateDisplayName(name);

  //     if (!mounted) return;

  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => ProjectType()),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     showMessage(e.message ?? "Signup failed");
  //   } finally {
  //     if (mounted) {
  //       setState(() => isLoading = false);
  //     }
  //   }
  // }

Future<void> signupUser() async {
  final email = emailController.text.trim();
  final password = passwordController.text.trim();
  final name = nameController.text.trim();

  try {
    // final credential =
    //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );

    // final user = credential.user;

    // // 🔥 YAHI PAR FIRESTORE ME SAVE KARNA HAI
    // await FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(user!.uid)
    //     .set({
    //   "uid": user.uid,
    //   "name": name,
    //   "email": email,
    //   "role": widget.userType, // "user" ya "architect"
    //   "isProfileCompleted": widget.userType == "user" ? true : false,
    //   "createdAt": FieldValue.serverTimestamp(),
    // });

    final credential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
);



await FirebaseFirestore.instance
    .collection("users")
    .doc(credential.user!.uid)
    .set({
  "uid": credential.user!.uid,
  "name": name,
  "email": email,
  "role": widget.userType,
  "isProfileCompleted": widget.userType == "user" ? true : false,
  "createdAt": FieldValue.serverTimestamp(),
});

    // Navigation
    if (widget.userType == "architect") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ArchitectCreateProfileScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ProjectType(),
        ),
      );
    }
  } catch (e) {
    print("Error: $e");
  }
}
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    ageController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[100],
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 16, 30, 110),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Full Name',
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mobile Number',
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email Address',
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Age',
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),

                      const SizedBox(height: 10),

                      DropdownButton<Gender>(
                        value: selectedGender,
                        isExpanded: true,
                        items: Gender.values.map((gender) {
                          return DropdownMenuItem<Gender>(
                            value: gender,
                            child: Text(gender.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => selectedGender = value);
                        },
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : signupUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo[900],
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Create Account",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}