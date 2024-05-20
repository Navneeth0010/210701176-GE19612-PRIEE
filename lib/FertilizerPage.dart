import 'package:priee/CropsPage.dart';
import 'package:flutter/material.dart';
import 'package:priee/Organic.dart';
import 'package:priee/Inorganic.dart';
class FertilizerPage extends StatelessWidget {
  @override
  final Color textHexColor = Color(0xffE0BBA1);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Find the fertilizers"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Stack(
        children: [
          Container(
            color: textHexColor,
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(16.0),
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to the Crops page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Organic(),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  'assets/organic.png', width: 48.0, height: 48.0),
                              const SizedBox(height: 8.0),
                              const Text('Organic'),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the Crops page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Inorganic()),
                          );
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/inorganic.png', width: 48.0,
                                  height: 48.0),
                              SizedBox(height: 8.0),
                              Text('Inorganic'),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the Crops page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Inorganic(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}