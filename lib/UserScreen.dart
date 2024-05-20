import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CropsPage.dart';
import 'FertilizerPage.dart';
import 'IrrigatorPage.dart';
import 'ChatBot.dart';

late final double temperature;
late final double humidityStatus;
late final String weatherDescription;
late final double precipitationStatus;

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
  final String cityName;
  UserScreen({required this.cityName});
}

class _UserScreenState extends State<UserScreen> {
  Map<String, dynamic>? weatherData;
  final Color textHexColor = Color(0xffE0BBA1);
  String? _cityName;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _cityName = widget.cityName;
    fetchWeatherData(_cityName!);
  }

  Future<void> fetchWeatherData(String city) async {
    final apiKey = '535db676af05eab5fd4756df2e63f9b8'; // Replace with your actual API key
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to fetch weather data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching weather data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Welcome to Farm Friend"),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage))
                      : WeatherCard(weatherData: weatherData),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(16.0),
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CropsPage(
                                temperature: temperature,
                                humidityStatus: humidityStatus,
                                precipitationStatus: precipitationStatus,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/crop.png', width: 78.0, height: 78.0),
                              const SizedBox(height: 8.0),
                              const Text('Crops'),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FertilizerPage()),
                          );
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/fertilizer.png', width: 78.0, height: 78.0),
                              SizedBox(height: 8.0),
                              Text('Fertilizer'),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => IrrigatorPage()),
                          );
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/irrigation-system.png', width: 78.0, height: 78.0),
                              SizedBox(height: 8.0),
                              Text('Irrigator'),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatBot()),
                          );
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/chatbot.png', width: 78.0, height: 78.0),
                              SizedBox(height: 8.0),
                              Text('Farm Guru'),
                            ],
                          ),
                        ),
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

class WeatherCard extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  WeatherCard({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return Container(
        height: 150,
        child: Center(
          child: Text('Failed to fetch weather data'),
        ),
      );
    }

    temperature = weatherData!['main']['temp'].toDouble();
    weatherDescription = weatherData!['weather'][0]['description'];
    humidityStatus = weatherData!['main']['humidity'].toDouble();
    final soilMoistureStatus = 'Good';
    precipitationStatus = (weatherData!['rain'] != null ? weatherData!['rain']['1h']?.toDouble() ?? 0 : 0);

    return Container(
      width: double.infinity,
      height: 130,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/sun.png', width: 38.0, height: 38.0),
              Text(
                '${temperature.toInt()}°C',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                weatherDescription,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusItem(label: 'Humidity', status: humidityStatus.toString()),
              StatusItem(label: 'Soil Moisture', status: soilMoistureStatus),
              StatusItem(label: 'Precipitation', status: precipitationStatus.toString()),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusItem extends StatelessWidget {
  final String label;
  final String status;

  StatusItem({required this.label, required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
