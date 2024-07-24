# linear_regression_model

## Introduction
This linear regression assignment is a summative assignment aimed at understanding the use of linear regression in predictive analysis using 3 tasks.

### Task 1: Linear Regression
* Creating and Optimizing a linear regression model using gradient descent.
* You have been provided a data set that will create a model that predicts TV sales.
* Please find all resources associated with this [data](https://www.google.com/url?q=https://drive.google.com/drive/folders/1mnPsCLrCZU3JSpeI9tDLq4Rn8719i1MZ?usp%3Dsharing&sa=D&source=editors&ust=1721797828725531&usg=AOvVaw0n9OYYg34Q7xtCsbqlUksp) - Please make a copy first.
* Inside, you will find a notebook with instructions.
* Make sure to note down all cells that require you to complete the code snippets. The notebook has unit tests that you will have to pass.
* The Notebook has 5 Exercises
* Create decision trees and random Forests models, compare the Root Mean Squared Errors to the Linear regression model, and rank the models accordingly
* Here is a cheat sheet - [cheat sheet](https://www.google.com/url?q=https://drive.google.com/file/d/1HMsREo8DSK1wzyUqJNf6F4pLpbh5AHpB/view?usp%3Dsharing&sa=D&source=editors&ust=1721797828726309&usg=AOvVaw0HmLCuWnfR5nzuk9G_Se3F).

### Task 2: Create an API
Create a function to make a prediction using a linear regression model, which is a Python function as follows. Use ***Fast API*** to create an API endpoint and upload source code files to a free hosting platform (or paid where possible)
* TextFields for inputting values needed for the prediction.
* A Button with the text "Predict".
* A display area for showing the predicted value or an error message if the values are out of range or if one or more expected values are missing.

````
#import things. . . …..
app = FastAPI(‘insert something here)
@app.post(‘/predict’)
def predict(*args, **kwargs):
 #insert your code here
return prediction
#replace *args and **kwargs where you deem necessary

````

The data I used is meant for predicting wine quality based on parameters:
- fixed_acidity:
- volatile_acidity:
- residual_sugar:
- chlorides:
- free_SO2:
- sulphates:
- alcohol:
- colour:

### API Documentation
Link = [render fastapi hosted endpoint](https://linear-regression-model-11.onrender.com)
The fastapi swagger shows the following:
Use the API endpoint created in task 2,that is, url + path_to_predict on your flutter app.

This is how the API works:

```
    GET/ class
    Content type
    application/json
    null

```

````
   GET /
   Content type
   application/json
   null

````

````
   POST /predict
   Content type
   application/json
   {
  "fixed_acidity": 999,
  "volatile_acidity": 999,
  "residual_sugar": 999,
  "chlorides": 999,
  "free_SO2": 999,
  "sulphates": 999,
  "alcohol": 999,
  "colour": 1
   }
   null

````

## Submission Details
* A GitHub link containing the notebook, API code files, and Flutter app with directories well labeled ** Empty cell outputs on the notebook will be considered failed run outputs**
* On the README :
* Provide a publicly available API endpoint that returns predictions given input values. Tests will be assessed using Postman; alternatively, you can provide steps to access the API.

## Task 3: Flutter App
Make sure you reload the endpoint server before opening the Flutter app. The test the 8 inputs in the test fields. Press predict to get the quality of the wine.

## Contributing
Make a pull request before contributing
