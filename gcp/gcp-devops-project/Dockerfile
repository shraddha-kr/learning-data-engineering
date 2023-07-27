# Reference - 
# https://blog.logrocket.com/build-deploy-flask-app-using-docker/
# https://tecadmin.net/how-to-create-and-run-a-flask-application-using-docker/

FROM python:3.8-alpine

# Create app directory
WORKDIR /app

# Install app dependencies
COPY requirements.txt  ./

RUN pip3 install -r requirements.txt

# Bundle app source
COPY . .

CMD ["flask", "run","--host","0.0.0.0","--port","5000"]  