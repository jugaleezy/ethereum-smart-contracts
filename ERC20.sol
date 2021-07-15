// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol";

contract ERC20 is IERC20 {
  string private _name;
  string private _symbol;
  uint8 private _decimal;

  uint256 private _totalSupply;

  mapping(address => uint256) private _balances;

  mapping(address => mapping(address => uint256)) private _allowance;

  constructor(string memory name_, string memory symbol_, uint8 decimal_) {
    _name = name_;
    _symbol = symbol_;
    _decimal = decimal_;
  }

  function name() public view returns (string memory) {
    return _name;
  }

  function symbol() public view returns (string memory) {
    return _symbol;
  }

  // check where to declare _decimal variable
  function decimal() public view returns (uint8) {
    return _decimal;
  }

  function totalSupply() public view virtual override returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address _account) public view virtual override returns (uint256) {
    require(_account != address(0), "ERC20: zero address provided");
    return _balances[_account];
  }

  function transfer(address _to, uint256 _value) public virtual override returns (bool) {
    require(_to != address(0), "ERC20: transfer to the zero address");
    require(_balances[msg.sender] >= _value, "ERC20: transfer amount exceeds balance");
    require(_value > 0, "ERC20: zero amount value");
    _balances[msg.sender] -= _value;
    _balances[_to] += _value;
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  function transferFrom(address _from, address _to, uint256 _value) public virtual override returns (bool) {
    require(_from != address(0), "ERC20: transfer from the zero address");
    require(_to != address(0), "ERC20: transfer to the zero address");
    require(_value > 0, "ERC20: zero amount value");

    uint256 currentAllowance = _allowance[_from][msg.sender];
    require(_balances[_from] >= _value, "ERC20: transfer amount exceeds balance");
    require(currentAllowance >= _value, "ERC20: transfer amount exceeds allowance");

    _balances[_from] -= _value;
    _balances[_to] += _value;
    _allowance[_from][msg.sender] -= _value;

    emit Transfer(_from, _to, _value);
    return true;
  }

  function allowance(address _owner, address _spender) public view virtual override returns (uint256) {
    return _allowance[_owner][_spender];
  }

  function approve(address _spender, uint256 _value) public virtual override returns (bool) {
    require(_spender != address(0), "ERC20: approve to the zero address");
    require(_value > 0, "ERC20: zero amount value");
    _allowance[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  function _mint(address _account, uint256 _value) public virtual {
    require(_account != address(0), "ERC20: mint to the zero address");
    require(_value != 0, "ERC20: mint token with zero amount");
    _totalSupply += _value;
    _balances[_account] += _value;
    emit Transfer(address(0), _account, _value);
  }

  function _burn(address _account, uint256 _value) public virtual {
    require(_account != address(0), "ERC20: burn from the zero address");
    require(_balances[_account] >= _value, "ERC20: burn amount exceeds balance");
    require(_value != 0, "ERC20: burn token with zero amount");
    _balances[_account] -= _value;
    _totalSupply -= _value;
    emit Transfer(_account, address(0), _value);
  }
}
