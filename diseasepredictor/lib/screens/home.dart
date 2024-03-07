import 'package:flutter/material.dart';
import 'package:diseasepredictor/widgets/TextBox.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 12, 0, 12),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                TextBox(
                  label: 'Check symptoms',
                  subsidary_text: 'Get a prediction of most likely disease',
                  activeScreen: '1',
                ),
                SizedBox(
                  height: 10,
                ),
                TextBox(
                  label: 'Find Nearby Hospital',
                  subsidary_text: 'Nearest hospital with wait times',
                  activeScreen: '2',
                ),
                SizedBox(
                  height: 10,
                ),
                TextBox(
                  label: 'Health Resoucres',
                  subsidary_text: 'learn about health topics',
                  activeScreen: '3',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
