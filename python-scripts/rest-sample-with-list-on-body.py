import string
import pandas
import json
import requests
from datetime import date

class Customer:
    def __init__(self, id: string, name: string):
        self.id = id
        self.name = name.split(':')[1]

excelData = pandas.read_excel(
    '~/planilha.xlsx',
    dtype={
        'identifier': 'string',
        'customerName': 'string'
    }
)

allCustomers = [
    Customer(row.identifier, row.customerName)
    for row in excelData.itertuples()
]
removedIds = list(map(lambda customer: customer.identifier, allCustomers))

requests.delete(
    'https://api.teste.com:8080/v1/customers',
    json.dumps(removedIds),
    headers = { 'Content-Type': 'application/json' }
)

with open('response.txt', 'a') as arquivo:
    arquivo.write("### " + str(date.today()) + " ###\n")
    arquivo.write(str(removedIds))
    arquivo.write('\n\n')
