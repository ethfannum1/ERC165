
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-165.md

pragma solidity ^0.5.0;


/// @notice Query if a contract implements an interface
/// @dev Interface identification is specified in ERC-165. This function uses less than 30,000 gas.
///  
/// @param interfaceID The interface identifier, as specified in ERC-165
/// @return `true` if the contract implements `interfaceID` and `interfaceID` is not 0xffffffff, `false` otherwise
///  
interface ERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}


// Contrato de ejemplo
contract ERC165Mapping is ERC165 {

    /*  Lista de los selectores de interfaz que soporta este smart contract.
        Indica las interfaces que soporta/implementa este smart contract. 
    */
    mapping(bytes4 => bool) internal supportedInterfaces;


    constructor() public {
        /*  Registra en el mapping, que este contrato soporta/implementa la interfaz ERC165.
            El selector que registra en el mapping, es el de la función ( 1 ), que es la implementación de la función de la interfaz ERC165. 
        */
        supportedInterfaces[this.supportsInterface.selector] = true;
    }


    // ( 1 )
    /*  Retorna true/false, según si el selector que se le pase "interfaceID" está registrado en el mapping o no, es decir:
        si este contrato ERC165Mapping soporta/implementa o no la interfaz de la que se le pase el selector. 
    */
    function supportsInterface(bytes4 interfaceID) external view returns (bool) {
        return (supportedInterfaces[interfaceID]);
    }
}


// -------------------------------------------------------------------------------------------------------


interface Numbers {
    function setNumber(uint256 _num) external; // ( 3 )
    function getNumber() external view returns(uint256); // ( 4 )
}


contract NumbersRooms is ERC165Mapping, Numbers {

    uint256 num;

    /*  Registra en el mapping del contrato ERC165Mapping, que este contrato soporta/implementa la interfaz Numbers.
        El selector que registra en el mapping, es el XOR de todas las funciones de la interfaz ( 3 ) y ( 4 ), 
        que son las implementadas aquí en este contrato.
    */
    constructor() public {
        supportedInterfaces[this.setNumber.selector ^ this.getNumber.selector] = true;  
    }


    // ( 3 )
    function setNumber(uint256 _num) external {
        num = _num;
    }


    // ( 4 )
    function getNumber() external view returns(uint256) {
        return (num);
    }
}




