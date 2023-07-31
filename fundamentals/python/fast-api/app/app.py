from fastapi import FastAPI, Depends

app = FastAPI()

@app.get('/')
async def root():
    return {'message': 'Hello World!'} 