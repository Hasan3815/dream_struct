// import 'package:flutter/material.dart';

// class CustomInputField extends StatelessWidget {
//   final String labelText;
//   final String hintText;
//   final TextEditingController? controller;
//   final TextInputType keyboardType;

//   const CustomInputField({
//     super.key,
//     required this.labelText,
//     required this.hintText,
//     this.controller,
//     this.keyboardType = TextInputType.number,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           labelText,
//           style: const TextStyle(
//             fontSize: 18,
//             color: Color.fromARGB(255, 21, 27, 76),
//           ),
//         ),
//         const SizedBox(height: 3),
//         TextField(  
//           controller: controller,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10))),
          
//             filled: true,
//             fillColor: Colors.white,
            
//             hintText: hintText,
            
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const CustomInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 21, 27, 76),
          ),
        ),
        const SizedBox(height: 3),
        TextField(  
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          
            filled: true,
            fillColor: Colors.white,
            
            hintText: hintText,
            
          ),
        ),
      ],
    );
  }
}

