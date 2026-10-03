import 'package:flutter/material.dart';

class ArchitectDetailScreen extends StatelessWidget {
  final Map<String, dynamic> architect;

  const ArchitectDetailScreen({
    super.key,
    required this.architect,
  });

  @override
  Widget build(BuildContext context) {
    final List projects = architect["projects"] ?? [];

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 27, 76),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Architect Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            profileCard(),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: infoBox(
                    title: "Rating",
                    value: "${architect["rating"]}",
                    icon: Icons.star,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: infoBox(
                    title: "Projects",
                    value: "${projects.length}",
                    icon: Icons.work,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Completed Projects",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 21, 27, 76),
                ),
              ),
            ),

            const SizedBox(height: 15),

            ...projects.map((project) {
              return projectCard(project);
            }),
          ],
        ),
      ),
    );
  }

  Widget profileCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color.fromARGB(255, 21, 27, 76),
              child: Icon(
                Icons.architecture,
                size: 45,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              architect["name"],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              architect["specialization"],
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 8),

            Text(
              architect["experience"],
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone, size: 18),
                const SizedBox(width: 5),
                Text(architect["phone"]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget infoBox({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 21, 27, 76),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget projectCard(Map<String, dynamic> project) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 21, 27, 76),
          child: Icon(Icons.home_work, color: Colors.white),
        ),
        title: Text(
          project["title"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Location: ${project["location"]}\nYear: ${project["year"]}\nCost: ${project["cost"]}",
        ),
      ),
    );
  }
}