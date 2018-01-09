var Remittance = artifacts.require("./Remittance.sol");
var Owned = artifacts.require("./Owned.sol");
var Mortal = artifacts.require("./Mortal.sol");


module.exports = function(deployer) {
  deployer.deploy(Remittance);
  deployer.deploy(Owned);
  deployer.deploy(Mortal);
};
