#!/usr/bin/env python
from __future__ import print_function
import cgi
import cgitb
import json

cgitb.enable()

form = cgi.FieldStorage()

status_code = 200
status_text = 'OK'
response = {}

def handle_transfer():
    response['op'] = 'transfer'
    response['amount'] = form['amount'].value
    response['address'] = form['address'].value

def handle_unknown():
    global status_code, status_text
    status_code = 400
    status_text = 'Bad Request'
    response['error'] = 'Unknown operation'

op = form['op'].value
if op == 'transfer':
    handle_transfer()
else:
    handle_unknown()

print('Status: %s %s' % (status_code, status_text))
print('Content-Type: application/json')
print('')
print(json.dumps(response))
