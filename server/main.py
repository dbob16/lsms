from fastapi import FastAPI, HTTPException
from db import db_session, db_create_schema

db_create_schema()

api_keys = {}

app = FastAPI(title="LSMS", description="Open Source Automotive Shop Management Software")

@app.get("/")
def index():
    return {"whoami": "LSMS Server"}

