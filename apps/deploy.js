personal.unlockAccount(eth.accounts[0], 'pallo')
loadScript('mortal.abi')
loadScript('mortal.bin')
loadScript('greeter.abi')
loadScript('greeter.bin')
console.log('Mortal:', mortalAbi)
console.log('Mortal:', mortalBin)
console.log('Greeter:', greeterAbi)
console.log('Greeter:', greeterBin)
var mortalContractDef = web3.eth.contract(mortalAbi)
var greeterContractDef = web3.eth.contract(greeterAbi)
var mortal = mortalContractDef.new('mortal', {from:web3.eth.accounts[0], data:mortalBin, gas:500000}, function(err, contract) {
  mortalContract = contract
  console.log('Mortal contract:', err, contract, contract && contract.address)
})
var greeter = greeterContractDef.new('greeter', {from:web3.eth.accounts[0], data:greeterBin, gas:500000}, function(err, contract) {
  greeterContract = contract
  console.log('Greeter contract:', err, contract, contract && contract.address)
})
