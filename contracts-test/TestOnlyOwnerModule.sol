pragma solidity ^0.5.4;
import "../contracts/wallet/BaseWallet.sol";
import "../contracts/modules/common/OnlyOwnerModule.sol";

/**
 * @title TestOnlyOwnerModule
 * @dev Basic test onlyowner module.
 * @author Julien Niset - <julien@argent.im>
 */
contract TestOnlyOwnerModule is OnlyOwnerModule {

    bytes32 constant NAME = "TestOnlyOwnerModule";
    constructor(ModuleRegistry _registry) BaseModule(_registry, GuardianStorage(0), NAME) public {}
}