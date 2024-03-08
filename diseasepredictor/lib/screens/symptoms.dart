import 'package:diseasepredictor/widgets/dropdownbuttonList.dart';
import 'package:flutter/material.dart';
import 'package:diseasepredictor/widgets/Label.dart';
import 'package:diseasepredictor/screens/diagonsis.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define your enum outside of your widget class
enum Symptoms {
  itching, // 0
  skin_rash, // 1
  nodal_skin_eruptions, // 2
  continuous_sneezing, // 3
  shivering, // 4
  chills, // 5
  joint_pain, // 6
  stomach_pain, // 7
  acidity, // 8
  ulcers_on_tongue, // 9
  muscle_wasting, // 10
  vomiting, // 11
  burning_micturition, // 12
  spotting_urination, // 13
  fatigue, // 14
  weight_gain, // 15
  anxiety, // 16
  cold_hands_and_feets, // 17
  mood_swings, // 18
  weight_loss, // 19
  restlessness, // 20
  lethargy, // 21
  patches_in_throat, // 22
  irregular_sugar_level, // 23
  cough, // 24
  high_fever, // 25
  sunken_eyes, // 26
  breathlessness, // 27
  sweating, // 28
  dehydration, // 29
  indigestion, // 30
  headache, // 31
  yellowish_skin, // 32
  dark_urine, // 33
  nausea, // 34
  loss_of_appetite, // 35
  pain_behind_the_eyes, // 36
  back_pain, // 37
  constipation, // 38
  abdominal_pain, // 39
  diarrhoea, // 40
  mild_fever, // 41
  yellow_urine, // 42
  yellowing_of_eyes, // 43
  acute_liver_failure, // 44
  swelling_of_stomach, // 45
  swelled_lymph_nodes, // 46
  malaise, // 47
  blurred_and_distorted_vision, // 48
  phlegm, // 49
  throat_irritation, // 50
  redness_of_eyes, // 51
  sinus_pressure, // 52
  runny_nose, // 53
  congestion, // 54
  chest_pain, // 55
  weakness_in_limbs, // 56
  fast_heart_rate, // 57
  pain_during_bowel_movements, // 58
  pain_in_anal_region, // 59
  bloody_stool, // 60
  irritation_in_anus, // 61
  neck_pain, // 62
  dizziness, // 63
  cramps, // 64
  bruising, // 65
  obesity, // 66
  swollen_legs, // 67
  swollen_blood_vessels, // 68
  puffy_face_and_eyes, // 69
  enlarged_thyroid, // 70
  brittle_nails, // 71
  swollen_extremities, // 72
  excessive_hunger, // 73
  extra_marital_contacts, // 74
  drying_and_tingling_lips, // 75
  slurred_speech, // 76
  knee_pain, // 77
  hip_joint_pain, // 78
  muscle_weakness, // 79
  stiff_neck, // 80
  swelling_joints, // 81
  movement_stiffness, // 82
  spinning_movements, // 83
  loss_of_balance, // 84
  unsteadiness, // 85
  weakness_of_one_body_side, // 86
  loss_of_smell, // 87
  bladder_discomfort, // 88
  foul_smell_of_urine, // 89
  continuous_feel_of_urine, // 90
  passage_of_gases, // 91
  internal_itching, // 92
  toxic_look_, // 93
  depression, // 94
  irritability, // 95
  muscle_pain, // 96
  altered_sensorium, // 97
  red_spots_over_body, // 98
  belly_pain, // 99
  abnormal_menstruation, // 100
  dischromic_patches, // 101
  watering_from_eyes, // 102
  increased_appetite, // 103
  polyuria, // 104
  family_history, // 105
  mucoid_sputum, // 106
  rusty_sputum, // 107
  lack_of_concentration, // 108
  visual_disturbances, // 109
  receiving_blood_transfusion, // 110
  receiving_unsterile_injections, // 111
  coma, // 112
  stomach_bleeding, // 113
  distention_of_abdomen, // 114
  history_of_alcohol_consumption, // 115
  fluid_overload, // 116
  blood_in_sputum, // 117
  prominent_veins_on_calf, // 118
  palpitations, // 119
  painful_walking, // 120
  pus_filled_pimples, // 121
  blackheads, // 122
  scurring, // 123
  skin_peeling, // 124
  silver_like_dusting, // 125
  small_dents_in_nails, // 126
  inflammatory_nails, // 127
  blister, // 128
  red_sore_around_nose, // 129
  yellow_crust_ooze; // 130

  List<String> toListOfStrings() {
    return this.toString().split('.').map((e) => e.toUpperCase()).toList();
  }
}

class SymptomsScreen extends StatefulWidget {
  SymptomsScreen({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _SymptomsScreenState createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  Symptoms _selectedSymptoms = Symptoms.acidity;
  List<Symptoms> selectedSymptoms = [];
  String result = '';

  @override
  Widget build(BuildContext context) {
    // Checking if title is null or not

    if (widget.title == null) {
      return Material(
        child: Stack(
          children: [
            SizedBox(
              height: 500,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    LabelWidget(label: 'Symptom 1'),
                    DropdownButtonList(savedSymptoms: selectedSymptoms),
                    SizedBox(height: 30),
                    LabelWidget(label: 'Symptom 2'),
                    DropdownButtonList(savedSymptoms: selectedSymptoms),
                    SizedBox(height: 30),
                    LabelWidget(label: 'Symptom 3'),
                    DropdownButtonList(savedSymptoms: selectedSymptoms),
                    SizedBox(height: 30),
                    LabelWidget(label: 'Symptom 4'),
                    DropdownButtonList(savedSymptoms: selectedSymptoms),
                    SizedBox(height: 30),
                    LabelWidget(label: 'Symptom 5'),
                    DropdownButtonList(savedSymptoms: selectedSymptoms),
                    SizedBox(height: 30),
                    LabelWidget(label: 'Symptom 6'),
                    DropdownButtonList(savedSymptoms: selectedSymptoms),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    List<int> symptomVector =
                        List.filled(131, 0); // Initialize with zeros

                    selectedSymptoms.forEach((symptom) {
                      print(symptom);
                      symptomVector[symptom.index] =
                          1; // Set selected symptom positions to 1
                    });
                    print('Symptom Vector: $symptomVector');
                    try {
                      final url = Uri.parse('http://192.168.46.109/prediction');

                      final response = await http.post(
                        url,
                        headers: {'Content-Type': 'application/json'},
                        body: json.encode({'symptom_vector': symptomVector}),
                      );

                      print('Response Status Code: ${response.statusCode}');
                      print('Response Body: ${response.body}');

                      if (response.statusCode == 200) {
                        final Map<String, dynamic> responseData =
                            json.decode(response.body);
                        print('Response Data: $responseData');
                        final predictionList = responseData['prediction'];

                        if (predictionList is List<dynamic>) {
                          final predictionString = predictionList
                              .join(', '); // Convert list to string
                          setState(() {
                            result = predictionString;
                          });
                        } else if (predictionList is String) {
                          setState(() {
                            result =
                                predictionList; // No need to join, it's already a string
                          });
                        } else {
                          print(
                              'Unexpected data type for predictionList: ${predictionList.runtimeType}');
                        }
                      } else {
                        print('Error: ${response.reasonPhrase}');
                      }
                    } catch (e) {
                      print('Error: $e');
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiagonsisScreen(
                          selectedSymptoms: selectedSymptoms,
                          result: result,
                        ),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text('Submit'),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // If title is not null, return a Scaffold with an AppBar
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Material(
        child: SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                LabelWidget(label: 'Symptom 1'),
                DropdownButtonList(savedSymptoms: selectedSymptoms),
                SizedBox(height: 30),
                LabelWidget(label: 'Symptom 2'),
                DropdownButtonList(savedSymptoms: selectedSymptoms),
                SizedBox(height: 30),
                LabelWidget(label: 'Symptom 3'),
                DropdownButtonList(savedSymptoms: selectedSymptoms),
                SizedBox(height: 30),
                LabelWidget(label: 'Symptom 4'),
                DropdownButtonList(savedSymptoms: selectedSymptoms),
                SizedBox(height: 30),
                LabelWidget(label: 'Symptom 5'),
                DropdownButtonList(savedSymptoms: selectedSymptoms),
                SizedBox(height: 30),
                LabelWidget(label: 'Symptom 6'),
                DropdownButtonList(savedSymptoms: selectedSymptoms),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () async {
            List<int> symptomVector =
                List.filled(131, 0); // Initialize with zeros

            selectedSymptoms.forEach((symptom) {
              print(symptom);
              symptomVector[symptom.index] =
                  1; // Set selected symptom positions to 1
            });
            print('Symptom Vector: $symptomVector');
            try {
              final url = Uri.parse('http://192.168.46.109/prediction');

              final response = await http.post(
                url,
                headers: {'Content-Type': 'application/json'},
                body: json.encode({'symptom_vector': symptomVector}),
              );

              print('Response Status Code: ${response.statusCode}');
              print('Response Body: ${response.body}');

              if (response.statusCode == 200) {
                final Map<String, dynamic> responseData =
                    json.decode(response.body);
                print('Response Data: $responseData');
                final predictionList = responseData['prediction'];

                if (predictionList is List<dynamic>) {
                  final predictionString =
                      predictionList.join(', '); // Convert list to string
                  setState(() {
                    result = predictionString;
                  });
                } else if (predictionList is String) {
                  setState(() {
                    result =
                        predictionList; // No need to join, it's already a string
                  });
                } else {
                  print(
                      'Unexpected data type for predictionList: ${predictionList.runtimeType}');
                }
              } else {
                print('Error: ${response.reasonPhrase}');
              }
            } catch (e) {
              print('Error: $e');
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiagonsisScreen(
                  selectedSymptoms: selectedSymptoms,
                  result: result,
                ),
              ),
            );
          },
          child: const Center(
            child: Text('Submit'),
          ),
        ),
      ),
    );
  }
}
