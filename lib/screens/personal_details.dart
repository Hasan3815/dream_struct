import 'package:flutter/material.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.blue[100], // 🔥 move color here
  body: SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 55,
            backgroundColor: Color.fromARGB(255, 21, 27, 76),
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),

          const SizedBox(height: 20),

          personalCard(
            title: "Name",
            value: "Sarah",
            icon: Icons.person,
          ),

          personalCard(
            title: "Email",
            value: "sarah@gmail.com",
            icon: Icons.email,
          ),

          personalCard(
            title: "Phone",
            value: "+91 9876543210",
            icon: Icons.phone,
          ),

          personalCard(
            title: "Address",
            value: "Lucknow, Uttar Pradesh",
            icon: Icons.location_on,
          ),
        ],
      ),
    ),
  ),
);
  }

  Widget personalCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color.fromARGB(255, 21, 27, 76),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      ),
    );
  }
}