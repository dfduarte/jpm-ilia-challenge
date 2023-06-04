from fastapi import FastAPI
from dotenv import dotenv_values
from pymongo import MongoClient
import urllib

config = dotenv_values(".env")

app = FastAPI()

@app.on_event("startup")
@app.get("/")
def startup_db_client():
    app.mongodb_client = MongoClient("mongodb+srv://" + config["DB_LOGIN"] + ":" + urllib.parse.quote(config["DB_PASS"]) + "@ilia.afwegos.mongodb.net/?retryWrites=true&w=majority")
    app.database = app.mongodb_client[config["DB_NAME"]]
    print("Connected to the MongoDB database!")
    return {"message": "If you can see this, everything is running right"}


@app.on_event("shutdown")
def shutdown_db_client():
    app.mongodb_client.close()