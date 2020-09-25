const Management = artifacts.require('Management')
const Operation = artifacts.require('Operation')

module.exports = function (deployer) {
    deployer.deploy(Operation)
    .then(() => Operation.deployed())
    .then(() => deployer.deploy(Management, Operation.address))
};