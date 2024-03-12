import numpy as np
import pickle
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

model = pickle.load(open('TrainedModel', 'rb'))

class SymptomInput(BaseModel):
    symptom_vector: list

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
        # Add other diseases here
    }
    return key_from_value(disease, output)

@app.post("/prediction")
async def prediction(symptom_input: SymptomInput):
    symptom_vector = symptom_input.symptom_vector
    if symptom_vector is None or len(symptom_vector) != 131:
        raise HTTPException(status_code=400, detail="Invalid symptom vector")

    result = model_fun(np.array(symptom_vector))
    return {"prediction": result}
