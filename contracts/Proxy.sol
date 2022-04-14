// SPDX-License-Identifier: MIT
pragma solidity >= 0.6.0 < 0.8.0;

import "./Beacon.sol";


contract Proxy {
    // bytes32(uint256(keccak256("eip1967.proxy.beacon")) - 1))
    bytes32 private constant _BEACON_SLOT = 0xa3f0ad74e5423aebfd80d3ef4346578335a9a72aeaee59ff6cb3582b35133d50;

    // TODO: This proxy could be minimalized, since the beacon address is not intended to change.
    // Instead of keeping the beacon address in storage, it can be hardcoded into the code of a minimal proxy,
    // assembled in construction time.
    constructor() {
        // TODO: require beacon to be a contract.
        address beacon = msg.sender;

        // Store beacon address at a custom slot
        assembly {
            sstore(_BEACON_SLOT, beacon)
        }
    }

}

fallback() external payable {
        // Retrieve beacon address from custom slot
        address beacon;