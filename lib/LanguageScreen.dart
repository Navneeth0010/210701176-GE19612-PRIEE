import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'LoginScreen.dart'; // Import the LoginScreen page
import 'LoginTamil.dart'; // Import the LoginTamil page
import 'CityPage.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => LanguageScreenState();
}

class LanguageScreenState extends State<LanguageScreen> {
  String? _selectedLanguage;

  final List<String> _languages = [
    'English',
    'தமிழ்'
  ];

  @override
  Widget build(BuildContext context) {
    final Color textHexColor = Color(0xffE0BBA1);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Select Language'),
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
                    'Language',
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
                    value: _selectedLanguage,
                    hint: Text(
                      'Select Language',
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                    },
                    items: _languages.map<DropdownMenuItem<String>>((String value) {
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
                    onPressed: () {
                      if (_selectedLanguage != null) {
                        if (_selectedLanguage == 'தமிழ்') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginTamil(), // Use the imported LoginTamil page
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CityPage(), // Use the imported LoginScreen page
                            ),
                          );
                        }
                      } else {
                        // Handle case where no language is selected
                        // For example, show a snackbar or toast message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select a language.'),
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

