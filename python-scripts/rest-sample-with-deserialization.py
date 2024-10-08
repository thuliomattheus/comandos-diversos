import pandas as pd
import json
import requests

class Toy:
    def __init__(self, id):
        self.id = id

class RequestBody:
    def __init__(self):
        self.observation = "Removing from store"
        self.cardStatus = "OUTDATED"

archive = pd.read_csv(
    './outdatedToys.csv',
    dtype={
        'toy_id': 'int'
    }
)

rows = [
    Toy(r.toy_id) for r in archive.itertuples()
]

requestBody = RequestBody()

for row in rows:
    url = "https://api.teste.com:8080/v1/toys/"+str(row.id)+"/deprecate"
    headers = {
       'Content-Type': 'application/json',
    }
    jsonObject = json.dumps(requestBody, default=vars)
    response = requests.post(url, jsonObject, headers=headers)

    print(row.id)

    data = str(row.id) + ";" + str(response.status_code) + ";"

    with open('./outdatedToys.txt', 'a') as arquivo:
        arquivo.write(data)
        arquivo.write('\n')