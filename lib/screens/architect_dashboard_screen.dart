import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream_struct/screens/role_selection_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ArchitectDashboardScreen extends StatelessWidget {
  const ArchitectDashboardScreen({super.key});

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const RoleSelectionScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 27, 76),
        title: const Text(
          "Architect Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => logout(context),
          ),
        ],
      ),

      body: user == null
          ? const Center(child: Text("Please login again"))
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("architect_profiles")
                  .doc(user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(
                    child: Text("Architect profile not found"),
                  );
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;

                final name = data["name"] ?? "";
                final email = data["email"] ?? "";
                final phone = data["phone"] ?? "";
                final license = data["licenseNumber"] ?? "";
                final experience = data["experience"] ?? "";
                final specialization = data["specialization"] ?? "";
                final city = data["city"] ?? "";
                final availability = data["availability"] ?? "";
                final bio = data["bio"] ?? "";

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profileHeader(name, specialization, city),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          achievementCard(
                            title: "Projects",
                            value: "0",
                            icon: Icons.home_work,
                          ),
                          const SizedBox(width: 12),
                          achievementCard(
                            title: "Experience",
                            value: "$experience yrs",
                            icon: Icons.work,
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          achievementCard(
                            title: "Rating",
                            value: "0.0",
                            icon: Icons.star,
                          ),
                          const SizedBox(width: 12),
                          achievementCard(
                            title: "Status",
                            value: availability,
                            icon: Icons.verified,
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      sectionTitle("Personal Details"),

                      infoCard("Email", email, Icons.email),
                      infoCard("Phone", phone, Icons.phone),
                      infoCard("License No.", license, Icons.badge),
                      infoCard("City", city, Icons.location_city),

                      const SizedBox(height: 20),

                      sectionTitle("About"),

                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            bio.isEmpty ? "No bio added" : bio,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget profileHeader(String name, String specialization, String city) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 21, 27, 76),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 42,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.architecture,
                size: 45,
                color: Color.fromARGB(255, 21, 27, 76),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              specialization,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              city,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget achievementCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: const Color.fromARGB(255, 21, 27, 76),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color.fromARGB(255, 21, 27, 76),
        ),
        title: Text(title),
        subtitle: Text(value.isEmpty ? "Not added" : value),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 21, 27, 76),
        ),
      ),
    );
  }
}