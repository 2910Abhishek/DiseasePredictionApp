import numpy as np
import pickle 
from flask import Flask, request, jsonify

model = pickle.load(open('D:\ML HeathCare App SGP - II\DiseasePredictionApp\final_api', 'rb'))

app = Flask(__name__)


def model_fun(symptom_vector):
    output = model.predict(symptom_vector.reshape(1,-1))
    return output

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
    return jsonify({'prediction': result.tolist()}) 
    # return jsonify(0)

if __name__ == '__main__':
    app.run(debug=True)
# selected_symptoms = request.json.get('selected_symptoms')
# print(selected_symptoms)
# v = [0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0]

# symptom_vector = np.zeros(131) 
# i = 0
# for symptom in v:
#         if(symptom == 1):
#             symptom_vector[i] = 1
#         i = i + 1
# print(model_fun(symptom_vector))