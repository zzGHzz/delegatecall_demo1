const A = artifacts.require('A')
const B = artifacts.require('B')
const C = artifacts.require('C')

contract('DELEGATE_DEMO1', async accounts => {
    let a, b, c 
    let inst

    let rec

    before(async () => {
        a = await A.deployed()
        b = await B.deployed()
        c = await C.deployed()
    })
    
    it('Directly calling B\'s fallback', async () => {
        const val = 100

        inst = new web3.eth.Contract(C.abi, b.address)

        await inst.methods.set(val).send({from: accounts[0]})
        const _val = await inst.methods.get().call()
        assert.equal(val, _val)
    })

    it('Calling B\'s fallback from A', async () => {
        const val = 100
        const i = 0

        inst = new web3.eth.Contract(A.abi, a.address)
    
        // Create an instance of B and get the contract address
        await inst.methods.newB().send({from: accounts[0], gas: 500000})

        // Testing set/get
        await inst.methods.set(i, val).send({from: accounts[0]})
        const _val = await inst.methods.get(i).call()
        assert.equal(val, _val)
    })
})