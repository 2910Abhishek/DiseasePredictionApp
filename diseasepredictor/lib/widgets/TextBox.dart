import 'package:diseasepredictor/screens/Hospital.dart';
import 'package:diseasepredictor/screens/symptoms.dart';
import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  TextBox({
    Key? key,
    required this.label,
    required this.subsidary_text,
    required this.activeScreen,
  }) : super(key: key);

  final String label;
  final String subsidary_text;
  String activeScreen = '0';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('Card tapped.');
        if (activeScreen == '1') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SymptomsScreen(title: 'Symptoms'),
            ),
          );
        }

        if (activeScreen == '2') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HospitalScreen(),
            ),
          );
        }

        if (activeScreen == '3') {}
      },
      child: Row(
        children: [
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.arrow_right_alt_sharp),
                ],
              ),
              SizedBox(height: 6),
              Text(
                subsidary_text,
                style: const TextStyle(
                  color: Color.fromARGB(151, 255, 255, 255),
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 36),
            ],
          ),
        ],
      ),
    );
  }
}
