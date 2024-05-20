import 'package:flutter/material.dart';

class IrrigatorPage extends StatelessWidget {
  @override
  final Color textHexColor = Color(0xffE0BBA1);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Irrigation Methods"),
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
            child: Center(
              child: Card(
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IrrigationInfo(
                        imagePath: 'assets/irr1.png',
                        title: 'Drip Irrigation',
                        description:
                        'Water is directly delivered to plant roots through tubes or emitters, minimizing waste and promoting efficient water usage',
                      ),
                      Divider(),
                      IrrigationInfo(
                        imagePath: 'assets/irr2.png',
                        title: 'Sprinkler Irrigation',
                        description:
                        'Water is distributed over plants like rainfall via overhead pipes or hoses, suitable for large areas and various crops',
                      ),
                      Divider(),
                      IrrigationInfo(
                        imagePath: 'assets/irr3.png',
                        title: 'Surface Irrigation',
                        description:
                        'Water is flooded or channeled across soil surfaces, allowing it to infiltrate and reach plant roots, but can lead to runoff and uneven distribution',
                      ),
                      Divider(),
                      IrrigationInfo(
                        imagePath: 'assets/irr4.png',
                        title: 'Furrow Irrigation',
                        description:
                        'Water is directed down shallow trenches between crop rows, infiltrating soil and reaching roots, commonly used for row crops',
                      ),
                      Divider(),
                      IrrigationInfo(
                        imagePath: 'assets/irr5.png',
                        title: 'Center Pivot Irrigation',
                        description:
                        'Sprinklers mounted on a rotating arm supported by towers cover circular fields with water, efficiently irrigating large agricultural areas',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IrrigationInfo extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const IrrigationInfo({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imagePath, width: 28.0, height: 28.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(description),
            ],
          ),
        ),
      ],
    );
  }
}
