import asyncio
import uvicorn
from typing import Annotated
from fastapi import FastAPI, Depends, HTTPException, status, Path
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware


import joblib

# Load the pre-trained model
model =joblib.load("/summative/API/winequality_model.joblib")

# create app instance 
app = FastAPI()

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow requests from any origin
    allow_credentials=True,
    allow_methods=["GET", "POST"],  # Allow GET and POST requests
    allow_headers=["*"],  # Allow any headers
)

# create a pedantic class for the request
class WineQRequest(BaseModel):
    fixed_acidity: float = Field(gt=0, lt=10000)
    volatile_acidity: float = Field(gt=0, lt=10000)
    citric_acid: float = Field(gt=0, lt=10000) 
    residual_sugar: float = Field(gt=0, lt=10000)
    chlorides: float = Field(gt=0, lt=10000)
    total_SO2: float = Field(gt=0, lt=10000)
    density: float = Field(gt=0, lt=10000)
    pH: float = Field(gt=0, lt=10000)
    sulphates: float = Field(gt=0, lt=10000)
    alcohol: float = Field(gt=0, lt=10000)        
    goodquality: int = Field(gt=0, lt=500)
    
# class testing 
@app.get("/class")
async def get_greet():
    return {"Message": "Hello API"}


@app.get("/", status_code=status.HTTP_200_OK)
async def get_hello():
    return {"hello": "summative yeey"}

@app.post('/predict', status_code=status.HTTP_200_OK)
async def make_prediction(wineq_request: WineQRequest):
    try:
        single_row = [[wineq_request.fixed_acidity, wineq_request.volatile_acidity, wineq_request.citric_acid, wineq_request.residual_sugar, wineq_request.chlorides, wineq_request.total_SO2, wineq_request.density, wineq_request.pH, wineq_request.sulphates, wineq_request.alcohol, wineq_request.goodquality]]
        new_data_scaled = scaler.transform(single_row)
        new_value = model.predict(new_data_scaled)
        return {"predicted Quality ": new_value[0]}
    except:
        raise HTTPException(status_code=500, detail="Something went wrong.")

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)