// import 'package:dream_struct/login/create_account.dart';
// import 'package:dream_struct/login/forget_password.dart';
// import 'package:dream_struct/screens/project_type.dart';
// import 'package:flutter/material.dart';

// class FirstSlide extends StatefulWidget {
//   final String userName;
//   final void Function()? Login;

//   const FirstSlide({
//     super.key,
//     this.Login,
//     required this.userName,
//   });

//   @override
//   State<FirstSlide> createState() => _FirstSlideState();
// }

// class _FirstSlideState extends State<FirstSlide> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.blue[100],
//         width: double.infinity,
//         height: double.infinity,
//         child: Center(
//           child: SingleChildScrollView(
//             child: Card(
//               elevation: 5,
//               child: SizedBox(
//                 width: 300,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         "Welcome!",
//                         style: TextStyle(
//                           fontSize: 30,
//                           color: Color.fromARGB(255, 16, 30, 110),
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),

//                       const SizedBox(height: 20),

//                       const TextField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                           labelText: 'Email or Phone',
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       const TextField(
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                           labelText: 'Password',
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ProjectType(),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.indigo[900],
//                           ),
//                           child: const Text(
//                             'Login',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),

//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ForgetPassword(),
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           "Forget password?",
//                           style: TextStyle(
//                             color: Color.fromARGB(255, 124, 133, 231),
//                           ),
//                         ),
//                       ),

//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => CreateAccount(),
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           "Create account",
//                           style: TextStyle(
//                             color: Color.fromARGB(255, 124, 133, 231),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:dream_struct/login/create_account.dart';
import 'package:dream_struct/login/forget_password.dart';
import 'package:dream_struct/screens/project_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstSlide extends StatefulWidget {
  final String userName;
   final String userType;
  final void Function()? Login;

  const FirstSlide({
    super.key,
    this.Login,
    required this.userName,
     required this.userType,
  });

  @override
  State<FirstSlide> createState() => _FirstSlideState();
}

class _FirstSlideState extends State<FirstSlide> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage("Please enter email and password");
      return;
    }

    try {
      setState(() => isLoading = true);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectType(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showMessage(e.message ?? "Login failed");
    } catch (e) {
      showMessage("Something went wrong");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
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
              elevation: 5,
              child: SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Welcome!",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 16, 30, 110),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: 'Email',
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: 'Password',
                        ),
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : loginUser,
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
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgetPassword(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forget password?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 124, 133, 231),
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                             builder: (context) => CreateAccount(
  userType: widget.userType,
),
                            ),
                          );
                        },
                        child: const Text(
                          "Create account",
                          style: TextStyle(
                            color: Color.fromARGB(255, 124, 133, 231),
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