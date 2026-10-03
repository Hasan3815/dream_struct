import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream_struct/screens/architect_dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ArchitectCreateProfileScreen extends StatefulWidget {
  const ArchitectCreateProfileScreen({super.key});

  @override
  State<ArchitectCreateProfileScreen> createState() =>
      _ArchitectCreateProfileScreenState();
}

class _ArchitectCreateProfileScreenState
    extends State<ArchitectCreateProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final licenseController = TextEditingController();
  final experienceController = TextEditingController();
  final specializationController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final bioController = TextEditingController();

  String selectedAvailability = "Available";

  // void saveProfile() {
  //   if (nameController.text.trim().isEmpty ||
  //       phoneController.text.trim().isEmpty ||
  //       emailController.text.trim().isEmpty ||
  //       licenseController.text.trim().isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Please fill required fields")),
  //     );
  //     return;
  //   }

  //   final architectProfile = {
  //     "name": nameController.text.trim(),
  //     "phone": phoneController.text.trim(),
  //     "email": emailController.text.trim(),
  //     "licenseNumber": licenseController.text.trim(),
  //     "experience": experienceController.text.trim(),
  //     "specialization": specializationController.text.trim(),
  //     "city": cityController.text.trim(),
  //     "address": addressController.text.trim(),
  //     "bio": bioController.text.trim(),
  //     "availability": selectedAvailability,
  //   };

  //   debugPrint("ARCHITECT PROFILE: $architectProfile");

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Profile created successfully")),
  //   );

  //   Navigator.pop(context);
  // }

  Future<void> saveProfile() async {
  if (nameController.text.trim().isEmpty ||
      phoneController.text.trim().isEmpty ||
      emailController.text.trim().isEmpty ||
      licenseController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill required fields")),
    );
    return;
  }

  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please login first")),
    );
    return;
  }

  try {
    await FirebaseFirestore.instance
        .collection("architect_profiles")
        .doc(user.uid)
        .set({
      "uid": user.uid,
      "name": nameController.text.trim(),
      "phone": phoneController.text.trim(),
      "email": emailController.text.trim(),
      "licenseNumber": licenseController.text.trim(),
      "experience": experienceController.text.trim(),
      "specialization": specializationController.text.trim(),
      "city": cityController.text.trim(),
      "address": addressController.text.trim(),
      "bio": bioController.text.trim(),
      "availability": selectedAvailability,
      "createdAt": FieldValue.serverTimestamp(),
    });

    await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
      "isProfileCompleted": true,
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile created successfully")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ArchitectDashboardScreen(),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    licenseController.dispose();
    experienceController.dispose();
    specializationController.dispose();
    cityController.dispose();
    addressController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 27, 76),
        title: const Text(
          "Create Architect Profile",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                inputField(
                  controller: nameController,
                  label: "Full Name *",
                  icon: Icons.person,
                ),

                const SizedBox(height: 12),

                inputField(
                  controller: phoneController,
                  label: "Phone Number *",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 12),

                inputField(
                  controller: emailController,
                  label: "Email Address *",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 12),

                inputField(
                  controller: licenseController,
                  label: "Architecture License Number *",
                  icon: Icons.badge,
                ),

                const SizedBox(height: 12),

                inputField(
                  controller: experienceController,
                  label: "Experience (Years)",
                  icon: Icons.work,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 12),

                inputField(
                  controller: specializationController,
                  label: "Specialization",
                  icon: Icons.architecture,
                  hint: "Residential, Commercial, Interior",
                ),

                const SizedBox(height: 12),

                inputField(
                  controller: cityController,
                  label: "City",
                  icon: Icons.location_city,
                ),

                const SizedBox(height: 12),

                inputField(
                  controller: addressController,
                  label: "Office Address",
                  icon: Icons.location_on,
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: bioController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Bio / About",
                    hintText: "Write about your experience and services",
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: selectedAvailability,
                  decoration: InputDecoration(
                    labelText: "Availability",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Available",
                      child: Text("Available"),
                    ),
                    DropdownMenuItem(
                      value: "Busy",
                      child: Text("Busy"),
                    ),
                    DropdownMenuItem(
                      value: "Not Available",
                      child: Text("Not Available"),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      selectedAvailability = value;
                    });
                  },
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 21, 27, 76),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Create Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}