from flask import Flask, request, jsonify
import numpy as np
import pickle 

model = pickle.load(open('D:\SGP-2\TrainedModel', 'rb'))
app = Flask(__name__)

def your_ml_model_function(symptom_vector):
    output = model.predict(symptom_vector.reshape(1,-1))
    return output

@app.route('/prediction', methods=['POST'])
def prediction():
    selected_symptoms = request.json.get('selected_symptoms')
    print(selected_symptoms)
    symptom_vector = np.zeros(131) 
    i = 0
    for symptom in selected_symptoms:
        if(selected_symptoms == 1):
            symptom_vector[i] = 1
        i = i + 1

    result = your_ml_model_function(symptom_vector)
    print(result)
    return jsonify({'prediction': result.tolist()}) 
    # return jsonify(0)

if __name__ == '__main__':
    app.run(debug=True)