import 'package:dream_struct/screens/user_requirements.dart';
import 'package:flutter/material.dart';

class SelectQuality extends StatefulWidget {
  const SelectQuality({super.key});

  @override
  State<SelectQuality> createState() => _SelectQualityState();
}

class _SelectQualityState extends State<SelectQuality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Select Quality', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              // Add more widgets here if needed
              SizedBox(height: 40),
              Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  
                    
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: () {setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  UserRequirements()),
                    );
                  });
                  },
                  child: Container(
                    height: 200,
                    width: 300,
                    color:  Color.fromARGB(255, 21, 27, 76),
                    child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("Standard Quality", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                Text("Basic amenities and essential features for a comfortable stay", style: TextStyle(fontSize: 16, color: Colors.white),textAlign: TextAlign.center,),
                              ],
                            ),
                            SizedBox(height: 5),
                          ],
                        )
                    
                        
                      
                            
                    )
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  
                    
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: () {setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  UserRequirements()),
                    );
                  });
                  },
                  child: Container(
                    height: 200,
                    width: 300,
                    color:  Color.fromARGB(255, 21, 27, 76),
                    child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("Premium Quality", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                Text("High-end amenities and luxury features for an exceptional experience", style: TextStyle(fontSize: 16, color: Colors.white),textAlign: TextAlign.center,),
                              ],
                            ),
                            SizedBox(height: 5),
                             
                          ],
                        )
                    
                        
                      
                            
                    )
                  ),
                ),
                

            ],
          ),
        ),
      ),
    );
  }
}