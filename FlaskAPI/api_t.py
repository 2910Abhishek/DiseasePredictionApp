import numpy as np
import pickle 
from flask import Flask, request, jsonify

model = pickle.load(open('D:\ML HeathCare App SGP - II\DiseasePredictionApp\FlaskAPI\TrainedModel', 'rb'))

app = Flask(__name__)


def model_fun(symptom_vector):
    output = model.predict(symptom_vector.reshape(1,-1))
    return output

@app.route('/prediction', methods=['POST'])
def prediction():
    symptom_vector = request.json.get('symptom_vector')
    print(symptom_vector)
    if symptom_vector is None or len(symptom_vector) != 131:
        return jsonify({'error': 'Invalid symptom vector'}), 400

    # Convert the elements of 'symptom_vector' to integers
    symptom_vector = list(map(int, symptom_vector))

    result = model_fun(np.array(symptom_vector))
    print(result.tolist())
    return jsonify({'prediction': result.tolist()})

    # return jsonify(0)

if __name__ == '__main__':
    app.run(debug=True)
