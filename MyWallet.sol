
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract MyWallet {


    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    // modifier: verification of the owner and readiness for payment
    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}

    // Send without commission payment at your own expense
    function sendTransactionCommisionMsg(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {
        uint16 flag = 0;
        dest.transfer(value, bounce, flag);
    }

    // Send with commission payment at your own expense
    function sendTransactionCommisionYourExpence(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {
        uint16 flag = 0 + 1;
        dest.transfer(value, bounce, flag);
    }

    // Send all the money and destroy the wallet
    function sendEverythingDestroyWallet(address dest, bool bounce) public pure checkOwnerAndAccept {
        uint16 flag = 128 + 32;
        dest.transfer(0, bounce, flag);
    }
}

