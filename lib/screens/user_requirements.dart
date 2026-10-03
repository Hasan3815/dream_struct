

import 'package:dream_struct/models/customInput.dart';
import 'package:dream_struct/screens/Blueprint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

enum Shape { square, triangle, circle, rectangle, other }

class UserRequirements extends StatefulWidget {
  const UserRequirements({super.key});

  @override
  State<UserRequirements> createState() => _UserRequirementsState();
}

class _UserRequirementsState extends State<UserRequirements> {
  Shape _selectedShape = Shape.square;

  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController bathroomController = TextEditingController();
  final TextEditingController kitchenController = TextEditingController();
  final TextEditingController balconyController = TextEditingController();

  bool _isLoading = false;

  // 🔥 STABILITY AI API KEY (FREE from platform.stability.ai/account/keys)
  static const String _stabilityApiKey = 'sk-xsC9A08xq1CXoR2Hf6q6sqj4dPpUXwnIdlgybuE1ixZ5CykZ';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: const Color(0xFF1a237e),
          title: const Center(
            child: Text(
              '🏠 Property Blueprint',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Plot Size
                Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        labelText: "Length (m)",
                        hintText: "Total length",
                        controller: lengthController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CustomInputField(
                        labelText: "Width (m)",
                        hintText: "Total Width",
                        controller: widthController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
          
                // Shape
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Plot Shape",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1a237e)),
                      ),
                      DropdownButton<Shape>(
                        isExpanded: true,
                        value: _selectedShape,
                        items: Shape.values.map((shape) => DropdownMenuItem(
                          value: shape,
                          child: Text(shape.name.toUpperCase()),
                        )).toList(),
                        onChanged: (value) => setState(() => _selectedShape = value!),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
          
                // Rooms & Facilities
                Row(children: [
                  Expanded(child: CustomInputField(labelText: "Rooms", hintText: "No. of rooms", controller: roomController, keyboardType: TextInputType.number)),
                  const SizedBox(width: 15),
                  Expanded(child: CustomInputField(labelText: "Bathrooms", hintText: "No. of bathrooms", controller: bathroomController, keyboardType: TextInputType.number)),
                ]),
                const SizedBox(height: 30),
                Row(children: [
                  Expanded(child: CustomInputField(labelText: "Kitchens", hintText: "No. of kitchen", controller: kitchenController, keyboardType: TextInputType.number)),
                  const SizedBox(width: 15),
                  Expanded(child: CustomInputField(labelText: "Balconies", hintText: "No. of balconies", controller: balconyController, keyboardType: TextInputType.number)),
                ]),
                const SizedBox(height: 130),
          
                // Generate Button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _generateBlueprint,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1a237e),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: _isLoading
                        ? const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                              SizedBox(width: 15),
                              Text('AI Generating...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          )
                        : const Text(
                            '🎨 Generate AI Blueprint',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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

  Future<void> _generateBlueprint() async {
    if (_stabilityApiKey == 'sk-YOUR_STABILITY_API_KEY_HERE') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Get FREE Stability AI key: platform.stability.ai/account/keys'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    final imageBytes = await _generateWithStabilityAI();
    
    if (mounted && imageBytes != null) {
      final base64Image = base64Encode(imageBytes);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Blueprint(imageBytes: base64Image),
        ),
      );
    }
    
    if (mounted) setState(() => _isLoading = false);
  }

  Future<Uint8List?> _generateWithStabilityAI() async {
    try {
      final length = lengthController.text.isEmpty ? '20' : lengthController.text;
      final width = widthController.text.isEmpty ? '15' : widthController.text;
      final rooms = roomController.text.isEmpty ? '3' : roomController.text;
      final bathrooms = bathroomController.text.isEmpty ? '2' : bathroomController.text;
      final shape = _selectedShape.name;

//       final prompt = '''
// professional architectural floor plan blueprint, 
// plot ${length}m x ${width}m ${shape} shape,
// $rooms bedrooms, $bathrooms bathrooms, 1 kitchen, balcony,
// technical CAD drawing, white background, black thin lines,
// top-down view, precise dimensions labeled, modern house layout,
// clean lines, scale markings, professional architecture style
// ''';

final prompt = '''
Professional 2D architectural floor plan blueprint (top view),

Plot details:
- Size: ${length} meters (length) x ${width} meters (width)
- Shape: ${_selectedShape.name}

House requirements:
- ${roomController.text} bedrooms
- ${bathroomController.text} bathrooms
- ${kitchenController.text} kitchen(s)
- ${balconyController.text} balcony/balconies

Design instructions:
- Clearly labeled rooms (Bedroom, Bathroom, Kitchen, Living Room, Balcony)
- Proper wall boundaries with realistic thickness
- Include doors and windows placement
- Logical room arrangement (bedrooms private, kitchen near dining, bathrooms accessible)
- Balanced spacing and functional layout
- Include hallway/circulation space if needed

Style:
- Clean CAD architectural drawing
- Black thin lines on white background
- Top-down 2D blueprint view
- Accurate proportions and scale-like layout
- Minimal shading, no colors
- Professional engineering drawing style

Avoid:
- 3D perspective
- unrealistic shapes
- cluttered layout
- artistic or sketch style

Output:
Highly detailed, clean, professional floor plan blueprint
''';

      print('🤖 Stability AI Prompt: $prompt');

      final response = await http.post(
        Uri.parse('https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image'),
        headers: {
          'Authorization': 'Bearer $_stabilityApiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text_prompts': [
            {
              'text': prompt,
            }
          ],
          'cfg_scale': 7.0,
          'height': 1024,
          'width': 1024,
          'steps': 30,
          'samples': 1,
        }),
      ).timeout(const Duration(seconds: 60));

      print('Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final artifact = data['artifacts']?[0];
        if (artifact != null) {
          final imageUrl = artifact['base64'];
          final bytes = base64Decode(imageUrl);
          print('✅ Stability AI Image Generated: ${bytes.length} bytes');
          return bytes;
        }
      } else {
        print('❌ Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('❌ Stability AI Error: $e');
    }
    return null;
  }

  @override
  void dispose() {
    lengthController.dispose();
    widthController.dispose();
    roomController.dispose();
    bathroomController.dispose();
    kitchenController.dispose();
    balconyController.dispose();
    super.dispose();
  }
}