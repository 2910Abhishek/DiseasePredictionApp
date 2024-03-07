import 'package:diseasepredictor/widgets/dropdownbuttonList.dart';
import 'package:flutter/material.dart';
import 'package:diseasepredictor/widgets/Label.dart';
import 'package:diseasepredictor/screens/diagonsis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define your enum outside of your widget class
enum Symptoms {
  itching,
  skin_rash,
  nodal_skin_eruptions,
  continuous_sneezing,
  shivering,
  chills,
  joint_pain,
  stomach_pain,
  acidity,
  ulcers_on_tongue,
  muscle_wasting,
  vomiting,
  burning_micturition,
  spotting_urination,
  fatigue,
  weight_gain,
  anxiety,
  cold_hands_and_feets,
  mood_swings,
  weight_loss,
  restlessness,
  lethargy,
  patches_in_throat,
  irregular_sugar_level,
  cough,
  high_fever,
  sunken_eyes,
  breathlessness,
  sweating,
  dehydration,
  indigestion,
  headache,
  yellowish_skin,
  dark_urine,
  nausea,
  loss_of_appetite,
  pain_behind_the_eyes,
  back_pain,
  constipation,
  abdominal_pain,
  diarrhoea,
  mild_fever,
  yellow_urine,
  yellowing_of_eyes,
  acute_liver_failure,
  swelling_of_stomach,
  swelled_lymph_nodes,
  malaise,
  blurred_and_distorted_vision,
  phlegm,
  throat_irritation,
  redness_of_eyes,
  sinus_pressure,
  runny_nose,
  congestion,
  chest_pain,
  weakness_in_limbs,
  fast_heart_rate,
  pain_during_bowel_movements,
  pain_in_anal_region,
  bloody_stool,
  irritation_in_anus,
  neck_pain,
  dizziness,
  cramps,
  bruising,
  obesity,
  swollen_legs,
  swollen_blood_vessels,
  puffy_face_and_eyes,
  enlarged_thyroid,
  brittle_nails,
  swollen_extremeties,
  excessive_hunger,
  extra_marital_contacts,
  drying_and_tingling_lips,
  slurred_speech,
  knee_pain,
  hip_joint_pain,
  muscle_weakness,
  stiff_neck,
  swelling_joints,
  movement_stiffness,
  spinning_movements,
  loss_of_balance,
  unsteadiness,
  weakness_of_one_body_side,
  loss_of_smell,
  bladder_discomfort,
  foul_smell_of_urine,
  continuous_feel_of_urine,
  passage_of_gases,
  internal_itching,
  toxic_look_,
  depression,
  irritability,
  muscle_pain,
  altered_sensorium,
  red_spots_over_body,
  belly_pain,
  abnormal_menstruation,
  dischromic_patches,
  watering_from_eyes,
  increased_appetite,
  polyuria,
  family_history,
  mucoid_sputum,
  rusty_sputum,
  lack_of_concentration,
  visual_disturbances,
  receiving_blood_transfusion,
  receiving_unsterile_injections,
  coma,
  stomach_bleeding,
  distention_of_abdomen,
  history_of_alcohol_consumption,
  fluid_overload,
  blood_in_sputum,
  prominent_veins_on_calf,
  palpitations,
  painful_walking,
  pus_filled_pimples,
  blackheads,
  scurring,
  skin_peeling,
  silver_like_dusting,
  small_dents_in_nails,
  inflammatory_nails,
  blister,
  red_sore_around_nose,
  yellow_crust_ooze;

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
  @override
  Widget build(BuildContext context) {
    // Checking if title is null or not

    if (widget.title == null) {
      return Material(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                LabelWidget(label: 'Symptom 1'),
                DropdownButtonList(savedSymptoms: selectedSymptoms),
                SizedBox(height: 40),
                LabelWidget(label: 'Symptom 2'),
                DropdownButtonList(savedSymptoms: selectedSymptoms),
                SizedBox(height: 40),
                LabelWidget(label: 'Symptom 3'),
                DropdownButtonList(savedSymptoms: selectedSymptoms),
                SizedBox(height: 40),
                LabelWidget(label: 'Symptom 4'),
                DropdownButtonList(savedSymptoms: selectedSymptoms),
                SizedBox(height: 40),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DiagonsisScreen(selectedSymptoms: selectedSymptoms),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            LabelWidget(label: 'Symptom 1'),
            DropdownButtonList(savedSymptoms: selectedSymptoms),
            SizedBox(height: 40),
            LabelWidget(label: 'Symptom 2'),
            DropdownButtonList(savedSymptoms: selectedSymptoms),
            SizedBox(height: 40),
            LabelWidget(label: 'Symptom 3'),
            DropdownButtonList(savedSymptoms: selectedSymptoms),
            SizedBox(height: 40),
            LabelWidget(label: 'Symptom 4'),
            DropdownButtonList(savedSymptoms: selectedSymptoms),
            SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            List<int> symptomVector =
                List.filled(131, 0); // Initialize with zeros
            selectedSymptoms.forEach((symptom) {
              print(symptom);
              symptomVector[symptom.index] =
                  1; // Set selected symptom positions to 1
            });
            print(symptomVector);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    DiagonsisScreen(selectedSymptoms: selectedSymptoms),
              ),
            );

            // final url = Uri.https(
            //     'diseaseprediction-c1e90-default-rtdb.firebaseio.com',
            //     'Symptoms.json');

            // final Map<String, dynamic> symptomsMap = {
            //   'symptoms': selectedSymptoms
            //       .map((symptom) => symptom.toString().split('.').last)
            //       .toList(),
            // };
            // Print the symptom vector
            // Send the symptom vector to the ML model
            // http.post(
            //   url,
            //   headers: {'Content-Type': 'application/json'},
            //   body: json.encode(symptomVector),
            // );
            // http.post(
            //   url,
            //   headers: {'Content-Type': 'application/json'},
            //   body: json.encode(selectedSymptoms
            //       .map((symptom) => symptom.toString().split('.').last)
            //       .toList()),
            // );
          },
          child: const Center(
            child: Text('Submit'),
          ),
        ),
      ),
    );
  }
}
