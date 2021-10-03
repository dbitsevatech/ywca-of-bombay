from flask import Flask, request, jsonify
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import requests
from flask import Response
app = Flask(__name__)
cred = credentials.Certificate('firebase-sdk.json')
firebase_admin.initialize_app(cred)
db = firestore.client()
def sendNotification(usertoken, title, body):
    
    userdata = {
        "to": usertoken,
        "notification": {
            "body": str(body),
            "title": str(title),
            "content_available": True,
            "priority": "high"
        }

    }
    t="server key"
    headers = {
        "Authorization": "key="+t,
        "Content-Type": "application/json"

    }
    r = requests.post(
        'https://fcm.googleapis.com/fcm/send',  json=userdata, headers=headers)
    print(r.status_code,r.json())


@app.route('/post/', methods=['POST'])
def post_something():
    title = request.form.get('title',"YWCA App")
    body = request.form.get('body',"Intresting events await you")
    password=request.form.get('password',"")

    if password=="12345678":

        doc_ref = db.collection('mobileToken').stream()

        for doc in doc_ref:
            sendNotification(doc.to_dict()["token"],title,body)

        return Response("{'message':'successfull'}", status=201, mimetype='application/json')

    else:
        return Response("{'message':'Check your password'}", status=401, mimetype='application/json')



@app.route('/')
def index():
    return "<h1>Welcome to our server !!</h1>"

if __name__ == '__main__':
    app.run(threaded=True, port=5000)