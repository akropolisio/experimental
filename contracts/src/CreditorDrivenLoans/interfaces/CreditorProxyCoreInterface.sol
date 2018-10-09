pragma solidity ^0.4.25;

import "../../shared/libraries/OrderLibrary.sol";


contract CreditorProxyCoreInterface {

    function fillDebtOffer(
        OrderLibrary.DebtOrder memory order
    ) public returns (bytes32 agreementId);

    function cancelDebtOffer(
        OrderLibrary.DebtOrder memory order
    ) public returns (bool success);

}
