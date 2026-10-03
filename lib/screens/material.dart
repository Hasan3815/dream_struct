import 'package:flutter/material.dart';

class MaterialEstimationScreen extends StatefulWidget {
  const MaterialEstimationScreen({super.key});

  @override
  State<MaterialEstimationScreen> createState() =>
      _MaterialEstimationScreenState();
}

class _MaterialEstimationScreenState extends State<MaterialEstimationScreen> {
  final TextEditingController areaController = TextEditingController();
  final TextEditingController floorsController = TextEditingController();

  String selectedQuality = "Standard";

  double totalCost = 0;
  double cementBags = 0;
  double sandCft = 0;
  double steelKg = 0;
  double bricks = 0;
  double paintSqft = 0;

  void calculateEstimate() {
    final double area = double.tryParse(areaController.text) ?? 0;
    final int floors = int.tryParse(floorsController.text) ?? 1;

    if (area <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid area")),
      );
      return;
    }

    final double totalArea = area * floors;

    double ratePerSqft;

    if (selectedQuality == "Basic") {
      ratePerSqft = 1500;
    } else if (selectedQuality == "Standard") {
      ratePerSqft = 1800;
    } else {
      ratePerSqft = 2300;
    }

    setState(() {
      totalCost = totalArea * ratePerSqft;

      cementBags = totalArea * 0.4;
      sandCft = totalArea * 1.8;
      steelKg = totalArea * 4;
      bricks = totalArea * 8;
      paintSqft = totalArea * 2.5;
    });
  }

  @override
  void dispose() {
    areaController.dispose();
    floorsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a237e),
        title: const Text(
          "Material Cost Estimation",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            estimationInputCard(),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: calculateEstimate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1a237e),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Calculate Estimate",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            if (totalCost > 0) resultCard(),
          ],
        ),
      ),
    );
  }

  Widget estimationInputCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              controller: areaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Built-up Area (sq.ft)",
                hintText: "Example: 1200",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: floorsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Number of Floors",
                hintText: "Example: 1",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedQuality,
              decoration: const InputDecoration(
                labelText: "Construction Quality",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "Basic", child: Text("Basic")),
                DropdownMenuItem(value: "Standard", child: Text("Standard")),
                DropdownMenuItem(value: "Premium", child: Text("Premium")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedQuality = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget resultCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Estimated Materials",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1a237e),
              ),
            ),

            const Divider(height: 25),

            resultRow("Cement", "${cementBags.toStringAsFixed(0)} bags"),
            resultRow("Sand", "${sandCft.toStringAsFixed(0)} cft"),
            resultRow("Steel", "${steelKg.toStringAsFixed(0)} kg"),
            resultRow("Bricks", "${bricks.toStringAsFixed(0)} pcs"),
            resultRow("Paint Area", "${paintSqft.toStringAsFixed(0)} sq.ft"),

            const Divider(height: 30),

            resultRow(
              "Total Estimated Cost",
              "₹${totalCost.toStringAsFixed(0)}",
              isTotal: true,
            ),

            const SizedBox(height: 10),

            const Text(
              "Note: This is an approximate estimate. Actual cost may vary based on city, labor, design, material quality, and market rates.",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              fontWeight: FontWeight.bold,
              color: isTotal ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}