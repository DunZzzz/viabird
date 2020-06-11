#!/usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2020 emilien <emilien@emilien-pc>
#

from __future__ import print_function, unicode_literals

from PyInquirer import Token, prompt, Separator, Validator, ValidationError
import regex
from pprint import pprint
import requests
from art import *
import os

viabird_ascii=text2art('Viabird')

print(viabird_ascii)

print('Bienvenue dans le client d\'installation de Viabird!\n')
results = None

def url_ok(url):
    return r.status_code == 200

url = None
try:
    url = os.environ['GQL_ENDPOINT']
except:
    print('The environments variables are not set, please run install.sh')
    exit(1)

try:
    r = requests.head(url)
except:
    print('Impossible d\'atteindre l\'hote distant, vérifier votre connection internet.')
    exit(1)

def run_query(query):
    request = requests.post(url + '/graphql', json={'query': query})
    if request.status_code == 200:
        return request.json()
    else:
        raise Exception("Query failed to run by returning code of {}. {}".format(request.status_code, query))


class ZipCodeValidator(Validator):
    def validate(self, document):
        print(document.text)
        global results
        ok = regex.match('[0-9]{5}', document.text)
        if not ok:
            raise ValidationError(
                message='Format du code zip invalide.',
                cursor_position=len(document.text))

        results = run_query('query allCities { cities(zipCode: "%s") { id, name } }' % document.text)

        if len(results['data']['cities']) == 0:
            raise ValidationError(
                message='Aucune ville ne possèdent ce zip code réesayer.',
                cursor_position=len(document.text))

zip_code = prompt([{
            'type': 'input',
            'name': 'Code Zip',
            'message': 'Entrez le code ZIP de la ville d\'installation',
            'validate': ZipCodeValidator
        }])

if zip_code == {}:
    print('Le zip code est requis, installation annulée')
    exit(1)


city_dic = []

for it in results['data']['cities']:
    city_dic.append({ 'name': it['name'] })

city = prompt({
    'type': 'list',
    'message': 'Quelle ville?',
    'name': 'city',
    'choices': city_dic,
    'validate': lambda answer: 'Votre ville.' \
            if len(answer) == 0 else True
    })

if city == {}:
    print('La ville d\'installtion est requise, installation annulée')
    exit(1)


class ApiKeyValidator(Validator):
    def validate(self, document):
        res = run_query('query verifyToken { verifyApiKey(apiKey: "%s") }' % document.text)
        if res['data']['verifyApiKey'] == False:
            raise ValidationError(
                message='Clé d\'api invalide.',
                cursor_position=len(document.text))

api_key = prompt([{
            'type': 'input',
            'name': 'api_key',
            'message': 'Entrez votre clé d\'api (trouvez la sur la page settings de viabird.fr)',
            'validate': ApiKeyValidator
        }])

if api_key == {}:
    print('La clé d\'api est requise, installation annulée')
    exit(1)


def write_var(file, name, value):
    file.write("export %s=\"%s\"\n" % (name, value))

f = open("/tmp/viabird.temp.sh","w+")

write_var(f, "VIABIRD_ZIP_CODE", zip_code['Code Zip'])
write_var(f, "VIABIRD_CITY", city['city'])
write_var(f, "VIABIRD_API_KEY", api_key['api_key'])

f.close()
