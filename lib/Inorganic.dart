import 'package:flutter/material.dart';

class Inorganic extends StatelessWidget {
  @override
  final Color textHexColor = Color(0xffE0BBA1);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("In-Organic Fertilizers"),
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
                        imagePath: 'assets/inorg1.png',
                        title: 'Urea',
                        description:
                        'One of the most commonly used nitrogen fertilizers, urea is highly soluble and provides a quick nitrogen boost to plants',
                      ),
                      Divider(),
                      FertilizerInfo(
                        imagePath: 'assets/inorg2.png',
                        title: 'Ammonium Nitrate',
                        description:
                        'Another nitrogen fertilizer, it releases nitrogen quickly into the soil and is often used for crops requiring rapid growth',
                      ),
                      Divider(),
                      FertilizerInfo(
                        imagePath: 'assets/inorg3.png',
                        title: 'Triple Superphosphate (TSP)',
                        description:
                        'This fertilizer contains high levels of phosphorus and is suitable for plants with high phosphorus needs, such as flowering and fruiting crops',
                      ),
                      Divider(),
                      FertilizerInfo(
                        imagePath: 'assets/inorg4.png',
                        title: 'Potassium Chloride',
                        description:
                        'A common source of potassium, which is essential for plant growth and stress tolerance',
                      ),
                      Divider(),
                      FertilizerInfo(
                        imagePath: 'assets/irr5.png',
                        title: 'Monoammonium Phosphate (MAP)',
                        description:
                        'Provides a balanced supply of nitrogen and phosphorus, making it suitable for a wide range of crops',
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
