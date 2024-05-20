import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'CropsPage.dart';

final Color textHexColor = Color(0xFFF9D9AA);

class PredictedCrop extends StatefulWidget {
  final temperature;
  final humidity;
  final precipitation;
  final selectedSoil;

  PredictedCrop({
    Key? key,
    required this.temperature,
    required this.humidity,
    required this.precipitation,
    required this.selectedSoil,
  }) : super(key: key);

  @override
  State<PredictedCrop> createState() => _PredictedCropState();
}

class _PredictedCropState extends State<PredictedCrop> {
  String? predictedCrop;

  @override
  void initState() {
    super.initState();
    _fetchPredictCrop();
  }

  Future<void> _fetchPredictCrop() async {
    try {
      final crop = await predictCrop(
        widget.selectedSoil == 'Alluvial Soil' ? 70 : // n
        widget.selectedSoil == 'Black Soil' ? 60 :
        widget.selectedSoil == 'Laterite Soil' ? 25 :
        widget.selectedSoil == 'Red Soil' ? 40 :
        widget.selectedSoil == 'Forest Soil' ? 50 : 0,

        widget.selectedSoil == 'Alluvial Soil' ? 15 : // p
        widget.selectedSoil == 'Black Soil' ? 25 :
        widget.selectedSoil == 'Laterite Soil' ? 5 :
        widget.selectedSoil == 'Red Soil' ? 10 :
        widget.selectedSoil == 'Forest Soil' ? 15 : 0,

        widget.selectedSoil == 'Alluvial Soil' ? 300 : // k
        widget.selectedSoil == 'Black Soil' ? 400 :
        widget.selectedSoil == 'Laterite Soil' ? 150 :
        widget.selectedSoil == 'Red Soil' ? 250 :
        widget.selectedSoil == 'Forest Soil' ? 200 : 0,

        widget.temperature,
        widget.humidity,

        widget.selectedSoil == 'Alluvial Soil' ? 7.5 : // ph
        widget.selectedSoil == 'Black Soil' ? 7.0 :
        widget.selectedSoil == 'Laterite Soil' ? 6.5 :
        widget.selectedSoil == 'Red Soil' ? 6.8 :
        widget.selectedSoil == 'Forest Soil' ? 6.0 : 0,

        widget.precipitation,
      );
      setState(() {
        predictedCrop = crop.toUpperCase();
      });
    } catch (e) {
      print('Error predicting crop: $e');
      setState(() {
        predictedCrop = null;
      });
    }
  }

  Future<String> predictCrop(n, p, k, temperature, humidity, ph, precipitation) async {
    Map<String, dynamic> data = {
      'n': n,
      'p': p,
      'k': k,
      'temperature': temperature,
      'humidity': humidity,
      'ph': ph,
      'rainfall': 140,
    };

    final url = Uri.parse('http://192.168.1.5:3000/predict');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['crop'];
    } else {
      throw Exception('Failed to predict crop');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Recommendation'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: textHexColor,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/pred3.jpg', width: 500, height: 500), // Adjust the width and height as needed
                SizedBox(height: 20),
                if (predictedCrop != null)
                  Text(
                    'Predicted Crop: $predictedCrop',
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
                else
                  CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
