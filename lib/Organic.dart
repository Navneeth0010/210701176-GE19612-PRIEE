import 'package:flutter/material.dart';

class Organic extends StatelessWidget {
  @override
  final Color textHexColor = Color(0xffE0BBA1);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Organic Fertilizers"),
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
                      FertilizerInfo(
                        imagePath: 'assets/org1.png',
                        title: 'Compost',
                        description:
                        'Made from decomposed organic matter such as kitchen scraps, yard waste, and manure',
                      ),
                      Divider(),
                      FertilizerInfo(
                        imagePath: 'assets/org2.png',
                        title: 'Manure',
                        description:
                        'Animal manure, such as cow, horse, or chicken manure, is an excellent source of nitrogen, phosphorus, and potassium',
                      ),
                      Divider(),
                      FertilizerInfo(
                        imagePath: 'assets/org3.png',
                        title: 'Bone Meal',
                        description:
                        'Ground animal bones provide phosphorus and calcium, which are essential for root development and overall plant health',
                      ),
                      Divider(),
                      FertilizerInfo(
                        imagePath: 'assets/org4.png',
                        title: 'Fish Emulsion',
                        description:
                        'Made from fermented fish, it is high in nitrogen and provides a quick nutrient boost to plants',
                      ),
                      Divider(),
                      FertilizerInfo(
                        imagePath: 'assets/org5.png',
                        title: 'Sea Weed',
                        description:
                        'Derived from seaweed, it contains various micronutrients, growth hormones, and beneficial enzymes',
                      ),
                      Divider(),
                      FertilizerInfo(
                        imagePath: 'assets/org3.png',
                        title: 'Green Manure',
                        description:
                        'Cover crops like clover or alfalfa are grown and then plowed back into the soil to improve fertility and add organic matter',
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

class FertilizerInfo extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const FertilizerInfo({
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
