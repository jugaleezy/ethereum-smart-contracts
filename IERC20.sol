// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    // erc20 token standard interface
    
    // shows tokens total supply
    function totalSupply() external view returns (uint256);
    
    // shows token balance of specified ethereum account address
    function balanceOf(address _account) external view returns (uint256);
    
    // transfers tokens to provided ethereum account address
    function transfer(address _to, uint256 _value) external returns (bool);
    
    // transfers tokens from one ethereum address to another address
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool);
    
    // checks spender token allowance
    function allowance(address _owner, address _spender) external view returns (uint256);
    
    // token owner approves spender address to spend tokens
    function approve(address _spender, uint256 _value) external returns (bool);

    // event Transfer emitted when transfer and transferFrom function is called
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    
    // event Approval emitted when approve function is called
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
