import 'package:dream_struct/screens/architect_personal_details.dart';
import 'package:flutter/material.dart';

class ArchitectPanelScreen extends StatelessWidget {
  const ArchitectPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> architects = [
      {
        "name": "Ar. Rahul Sharma",
        "experience": "8 Years Experience",
        "specialization": "Residential Architecture",
        "phone": "+91 9988776655",
        "rating": 4.8,
        "projects": [
          {
            "title": "Modern Duplex House",
            "location": "Lucknow",
            "year": "2024",
            "cost": "₹45,00,000",
          },
          {
            "title": "Luxury Villa",
            "location": "Kanpur",
            "year": "2023",
            "cost": "₹80,00,000",
          },
        ],
      },
      {
        "name": "Ar. Priya Verma",
        "experience": "6 Years Experience",
        "specialization": "Interior & House Planning",
        "phone": "+91 8877665544",
        "rating": 4.6,
        "projects": [
          {
            "title": "3BHK Residential Plan",
            "location": "Delhi",
            "year": "2024",
            "cost": "₹38,00,000",
          },
          {
            "title": "Farm House Design",
            "location": "Noida",
            "year": "2022",
            "cost": "₹65,00,000",
          },
        ],
      },
    ];

    return Container(
      color: Colors.blue[100],
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: architects.length,
        itemBuilder: (context, index) {
          final architect = architects[index];

          return Card(
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(
                radius: 32,
                backgroundColor: Color.fromARGB(255, 21, 27, 76),
                child: Icon(
                  Icons.architecture,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              title: Text(
                architect["name"],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${architect["experience"]}\n${architect["specialization"]}",
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.orange),
                  Text("${architect["rating"]}"),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArchitectDetailScreen(
                      architect: architect,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}