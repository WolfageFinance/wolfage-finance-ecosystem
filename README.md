# Wolfage Finance Monorepo

## Packages

The monorepo has below packages:

### Solidity

The solidity smart-contracts of the whole Wolfage Finance Ecosystem.

#### Libraries

1. EnhancedAddress: An enhanced address library extended on [OpenZeppelin address](https://github.com/OpenZeppelin/openzeppelin-contracts-ethereum-package/blob/master/contracts/utils/Address.sol) library

#### Smart-Contracts

1. ContractRegistry: A registry for centralized management of smart-contract addresses.

2. GatewayV1: The first implementation of WolfHub Gateway to unify the whole DeFi ecosystem and remove the end-user experience barriers.

## Available Scripts

In the project directory, you can run:

### Solidity

#### `yarn solidity:compile`

Compiles the smart-contracts using [OpenZeppelin CLI](https://docs.openzeppelin.com/cli/2.8/).
