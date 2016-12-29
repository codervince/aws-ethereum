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
    expr = "eth.sendTransaction({from:'e986f163e65361be0f08aa48dcc3a7b12a57baf0', to:'%s', value:web3.toWei(%s, 'ether')})" % (address, amount)
    #response['expr'] = expr
    response['output'] = geth_exec_expr(expr)

def handle_balance():
    response['balance'] = float(geth_exec_expr("eth.getBalance('e986f163e65361be0f08aa48dcc3a7b12a57baf0')")) / 1000000000000000000

def handle_peers():
    response['peers'] = geth_exec_expr('admin.peers')

def handle_nodeinfo():
    response['nodeinfo'] = geth_exec_expr('admin.nodeInfo')

def handle_bootnode():
    nodeinfo = geth_exec_expr('admin.nodeInfo')
    with open '/var/www/html/ip.json' as f:
        d = json.loads(f)
        ip = d['ip']
    response = '--bootnodes enode://%s@%s:%s' % (nodeinfo['id'], ip, nodeinfo['ports']['listener'])

def handle_logs():
    output = subprocess.check_output(['/usr/bin/tail', '-n', '20', '/home/ubuntu/ethereum.log'])
    response['output'] = output

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
elif op == 'bootnode':
    handle_bootnode()
elif op == 'logs':
    handle_logs()
else:
    handle_unknown()

print('Status: %s %s' % (status_code, status_text))
print('Content-Type: application/json')
print('')
print(response if isinstance(response, basestring) else json.dumps(response))
