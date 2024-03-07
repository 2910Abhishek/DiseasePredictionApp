import numpy as np
import pickle 

model = pickle.load(open('D:\SGP-2\TrainedModel', 'rb'))


def model_fun(symptom_vector):
    output = model.predict(symptom_vector.reshape(1,-1))
    return output


v = [0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

symptom_vector = np.zeros(131) 
i = 0
for symptom in v:
        if(symptom == 1):
            symptom_vector[i] = 1
        i = i + 1
print(model_fun(symptom_vector))