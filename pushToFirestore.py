import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import pandas as pd
from datetime import datetime

# initializations firebase
cred = credentials.Certificate('firebase-sdk.json')
firebase_admin.initialize_app(cred)
db = firestore.client()
doc_ref = db.collection('testusers')
# import data
df = pd.read_excel("data.xlsx")
# get uids from firebase using extractuid script
uiddict={}
# replace nan with empty string 
df.fillna('', inplace=True)
# iterate through excel
print(df.shape[0] ,"rows in sheet")

c=0
k=df.keys()

for index, row in df.iterrows():
    d={}
    for j in k:
        d[j]=row[j]
    # done for firebase timestamp
    try:
        d["dateOfBirth"]=datetime.strptime(d["dateOfBirth"], '%d-%m-%Y')
    except:
        pass
    try:
        if (" +91"+str(int(d["phoneNumber"]))+" " in uiddict):
            d["uid"]=uiddict[" +91"+str(int(d["phoneNumber"]))+" "].replace(" ","")
            doc_ref.document(d["uid"]).set(d)
            c+=1
    except:
        pass

print(c,"rows pushed")
        





