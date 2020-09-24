const A = artifacts.require('A')
const B = artifacts.require('B')
const C = artifacts.require('C')

module.exports = function (deployer) {
    deployer.deploy(C)
    .then(() => C.deployed())
    .then(() => deployer.deploy(B, C.address))
    .then(() => deployer.deploy(A, C.address))
};