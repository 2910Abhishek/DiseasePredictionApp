import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.neural_network import MLPClassifier

mdl_train = pd.read_csv("Training.csv")
mdl_test = pd.read_csv("Testing.csv")

mdl_train['prognosis'].unique()
#mdl_train.drop('Unnamed: 133', axis=1, inplace=True)

class_counts = mdl_train['prognosis'].value_counts()

# Plot the counts
plt.figure(figsize=(10, 8))
class_counts.plot(kind='barh', color='yellow')
plt.xlabel('Count')
plt.title('Distribution of Classes')
plt.grid(axis='x')
plt.show()


encoder = LabelEncoder()
mdl_train["diagnosis"] = encoder.fit_transform(mdl_train["prognosis"])

classification_models = {
    'Logistic Regression': LogisticRegression(),
#     'Decision Tree': DecisionTreeClassifier(),
#     'Random Forest': RandomForestClassifier(n_jobs=-1, random_state=667),
#     'Gradient Boosting': GradientBoostingClassifier(),
#     'SVM': SVC(),
#     'K-Nearest Neighbors': KNeighborsClassifier(),
#     'Naive Bayes': GaussianNB(),
#     'Neural Network': MLPClassifier()
}

y = mdl_train['diagnosis']
X = mdl_train.drop(['diagnosis', 'prognosis'], axis=1)

def train_models_and_evaluate(X, y, models):

    X_train, X_valid, y_train, y_valid = train_test_split(X, y, test_size=0.2, random_state=43)

    results_list = []

    for model_name, model in models.items():
     
        model.fit(X_train, y_train)

      
        y_train_pred = model.predict(X_train)
        y_valid_pred = model.predict(X_valid)


        train_accuracy = accuracy_score(y_train, y_train_pred)
        valid_accuracy = accuracy_score(y_valid, y_valid_pred)

     
        results_list.append({
            'Model': model_name,
            'Training Accuracy': train_accuracy,
            'Validation Accuracy': valid_accuracy
        })


    results_df = pd.DataFrame(results_list)
    
    return results_df



results_df = train_models_and_evaluate(X, y, classification_models)
results_df


encoder = LabelEncoder()
mdl_test["diagnosis"] = encoder.fit_transform(mdl_test["prognosis"])

y_test = mdl_test['diagnosis']
X_test = mdl_test.drop(['diagnosis', 'prognosis'], axis=1)

model = LogisticRegression()
model.fit(X, y) 
y_test_preds = model.predict(X_test)

acc_score = accuracy_score(y_test, y_test_preds)
print(f"The Accuracy for Test Data is: {acc_score * 100}%.")