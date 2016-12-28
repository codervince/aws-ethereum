#!/usr/bin/env python
from __future__ import print_function
import cgi
import cgitb
import json
import subprocess
import os
import re

os.environ['HOME'] = '/home/ubuntu'

cgitb.enable()

form = cgi.FieldStorage()

status_code = 200
status_text = 'OK'
response = {}

def geth_exec_expr(expr):
    output = subprocess.check_output(['/usr/bin/geth', '--exec', 'console.log(JSON.stringify(%s, null, 2))' % (expr), 'attach'])
    return json.loads(re.sub(r'undefined\n$', '', output))

def handle_transfer():
    amount = form['amount'].value
    address = form['address'].value
    response['transfer'] = json.loads(geth_exec_expr("eth.sendTransaction({from:'48d8b7b8cd25ce99c6db70e1e373e6bfb51d1fbf', to:'%s', value:web3.toWei(%s, 'ether')})" % (address, amount)))

def handle_balance():
    response['balance'] = geth_exec_expr("eth.getBalance('48d8b7b8cd25ce99c6db70e1e373e6bfb51d1fbf')")

def handle_peers():
    response['peers'] = geth_exec_expr('admin.peers')

def handle_nodeinfo():
    response['nodeinfo'] = geth_exec_expr('admin.nodeInfo')

def handle_unknown():
    global status_code, status_text
    status_code = 400
    status_text = 'Bad Request'
    response['error'] = 'Unknown operation'

op = form['op'].value if 'op' in form else ''
if op == 'transfer':
    handle_transfer()
elif op == 'balance':
    handle_balance()
elif op == 'peers':
    handle_peers()
elif op == 'nodeinfo':
    handle_nodeinfo()
else:
    handle_unknown()

print('Status: %s %s' % (status_code, status_text))
print('Content-Type: application/json')
print('')
print(json.dumps(response))
