import 'package:flutter/material.dart';

class MaterialRequired extends StatefulWidget {
  const MaterialRequired({super.key});

  @override
  State<MaterialRequired> createState() => _MaterialRequiredState();
}

class _MaterialRequiredState extends State<MaterialRequired> {
final TextEditingController _materialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Material Required  and Cost Estimation",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 20, 33, 98),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text("Material"), Text("Quantity"), Text("unit")],
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.blue[50],
                elevation: 4,
                
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  height: 70,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  
                        children: [
                          Expanded(child: TextField(
                            controller: _materialController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'material name',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                          )),
                          SizedBox(width: 30),
                          Text("50",style:TextStyle(fontSize: 20)),
                          SizedBox(width: 30),
                          Text("bags",style:TextStyle(fontSize: 20))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          
        ),
    );
  }
}
