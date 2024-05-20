import 'package:priee/PredictedCrop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'PredictedCrop.dart';

class CropsPage extends StatefulWidget {
  final  temperature;
  final  humidityStatus;
  final  precipitationStatus;
  final selectedSoil;

  CropsPage({
    super.key,
    required this.temperature,
    required this.humidityStatus,
    required this.precipitationStatus,
    this.selectedSoil,
  });

  @override
  State<CropsPage> createState() => CropsPageState(
    temperature: temperature,
    humidity: humidityStatus,
    precipitation: precipitationStatus,
    selectedSoil: selectedSoil,
  );
}

class CropsPageState extends State<CropsPage> {
  String? _selectedSoil;
  String? _predictedCrop;
  final temperature;
  final  humidity;
  final precipitation;

  CropsPageState({
    required this.temperature,
    required this.humidity,
    required this.precipitation, required selectedSoil,
  });

  final List<String> _soil = [
    'Alluvial Soil',
    'Black Soil',
    'Laterite Soil',
    'Red Soil',
    'Forest Soil'
  ];

  @override
  Widget build(BuildContext context) {
    final Color textHexColor = Color(0xffE0BBA1);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Select Your Soil Type'),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Soil Types',
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedSoil,
                    hint: Text(
                      'Select Soil Type',
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedSoil = value;
                      });
                    },
                    items: _soil.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_selectedSoil != null) {
                        // Navigate to the PredictedCrop widget and pass the required values
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PredictedCrop(
                              temperature: temperature,
                              humidity: humidity,
                              precipitation: precipitation,
                              selectedSoil:_selectedSoil,// Pass the predicted crop value
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20.0),
                    ),
                    child: Text(
                      'Next',
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}