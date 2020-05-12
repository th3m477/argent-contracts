pragma solidity ^0.5.4;

import "../contracts/modules/maker/MakerV2Manager.sol";

/**
 * @title TestUpgradedMakerV2Manager
 * @dev Test upgraded MakerV2 module.
 * @author Olivier VDB - <olivier@argent.xyz>
 */
contract TestUpgradedMakerV2Manager is MakerV2Manager {
    MakerV2Manager private previousMakerV2Manager;

    constructor(
        ModuleRegistry _registry,
        GuardianStorage _guardianStorage,
        ScdMcdMigrationLike _scdMcdMigration,
        PotLike _pot,
        JugLike _jug,
        MakerRegistry _makerRegistry,
        IUniswapFactory _uniswapFactory,
        MakerV2Manager _previousMakerV2Manager
    )

        MakerV2Manager(
            _registry,
            _guardianStorage,
            _scdMcdMigration,
            _pot,
            _jug,
            _makerRegistry,
            _uniswapFactory
        )
        public

    {
        previousMakerV2Manager = _previousMakerV2Manager;
    }

    function init(BaseWallet _wallet) public onlyWallet(_wallet) {
        address[] memory tokens = makerRegistry.getCollateralTokens();
        for (uint256 i = 0; i < tokens.length; i++) {
            bytes32 loanId = previousMakerV2Manager.loanIds(address(_wallet), makerRegistry.getIlk(tokens[i]));
            if (loanId != 0) {
                previousMakerV2Manager.giveVault(_wallet, loanId);
                assignLoanToWallet(_wallet, loanId);
            }
        }
    }

}