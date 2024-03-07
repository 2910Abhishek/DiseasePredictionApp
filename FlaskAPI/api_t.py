import numpy as np
import pickle 
from flask import Flask, request, jsonify

model = pickle.load(open('D:\SGP-2\TrainedModel', 'rb'))

app = Flask(__name__)


def key_from_value(dictionary, target_value):

    for key, value in dictionary.items():

        if value == target_value:
            return key

    return None


def model_fun(symptom_vector):
    output = model.predict(symptom_vector.reshape(1,-1))
    disease = {
    "Fungal_infection": 13,
    "Allergy": 3,
    "GERD": 14,
    "Chronic_cholestasis": 8,
    "Drug_Reaction": 12,
    "Peptic_ulcer_diseae": 30,
    "AIDS": 0,
    "Diabetes": 11,
    "Gastroenteritis": 15,
    "Bronchial_Asthma": 5,
    "Hypertension": 21,
    "Migraine": 28,
    "Cervical_spondylosis": 6,
    "brain_hemorrhage": 38,
    "Jaundice": 26,
    "Malaria": 27,
    "Chicken pox": 7,
    "Dengue": 10,
    "Typhoid": 34,
    "hepatitis_A": 39,
    "Hepatitis_B": 17,
    "Hepatitis_C": 18,
    "Hepatitis_D": 19,
    "Hepatitis_E": 20,
    "Alcoholic_hepatitis": 2,
    "Tuberculosis": 33,
    "Common_Cold": 9,
    "Pneumonia": 31,
    "piles": 40,
    "Heart_attack": 16,
    "Varicose_veins": 36,
    "Hypothyroidism": 24,
    "Hyperthyroidism": 22,
    "Hypoglycemia": 23,
    "Osteoarthristis": 29,
    "Arthritis": 4,
    "Vertigo": 37,
    "Acne": 1,
    "Urinary_tract_infection": 35,
    "Psoriasis": 32,
    "Impetigo": 25
                }
    
    return key_from_value(disease,output)

@app.route('/prediction', methods=['GET'])
def prediction():
    selected_symptoms = request.json.get('selected_symptoms')
    print(selected_symptoms)
    symptom_vector = np.zeros(131) 
    i = 0
    for symptom in selected_symptoms:
        if(symptom == 1):
            symptom_vector[i] = 1
        i = i + 1

    result = model_fun(symptom_vector)
    print(result)
    return jsonify({'prediction': result}) 


if __name__ == '__main__':
    app.run(debug=True)