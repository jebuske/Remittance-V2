var Remittance = artifacts.require("./Remittance");




contract('Remittance', function(accounts) {
  var creatorAddress = accounts[0];
  var beneficiaryAddress = accounts[1];

  it("should revert the transaction of setWithdrawal when the 0 address is used", ()=> {
    return Remittance.deployed()
    .then(instance => {
      return instance.setWithdrawal("ezef", "0", 10, true, {from: creatorAddress});
    }).then(result => {
      assert.fail();
    }).catch(error => {
      assert.notEqual(error.message, "assert.fail()", "setWithdrawal was not run with valid address");
    });
  });

  it("should assert true", function(done) {
    var remittance = Remittance.deployed();
    remittance.then(instance => {
      return instance.setWithdrawal.call("ezaf","0x1", 10, true);
    }).then(success => {
      assert.isTrue(success,"it is possible to set a withdrawal");
      done();
    });
  });
});
