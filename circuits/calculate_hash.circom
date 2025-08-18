// This code prooves to someone they know value1, value2, value3, and value4 to that hash value without revealing the values
// Circom is a programming language that defines arithmetic circuits that can be used to generate zero-knowledge proofs
// Zero knowledge proofs are protocols used to prove something without proof
pragma circom 2.0.0;

// Poseidon is a hash function that can be used to generate a hash from multiple inputs
include "circomlib/circuits/poseidon.circom";

// A template is a mechanism to generate circuit objects
// Defines inputs of values 1 through 4. 
template CalculateHash() {
    signal input value1;
    signal input value2;
    signal input value3;
    signal input value4;

    // Outputs out which is the hash
    signal output out;

    // Poseidon computes the hash
    component poseidon = Poseidon(4);

    poseidon.inputs[0] <== value1;
    poseidon.inputs[1] <== value2;
    poseidon.inputs[2] <== value3;
    poseidon.inputs[3] <== value4;

    out <== poseidon.out;
}
template HashChecker() {
    signal input value1;
    signal input value2;
    signal input value3;
    signal input value4;
    signal input hash;

    // Instantiate CalculateHash as calculateSecret
    component calculateSecret = CalculateHash();
    calculateSecret.value1 <== value1;
    calculateSecret.value2 <== value2;
    calculateSecret.value3 <== value3;
    calculateSecret.value4 <== value4;

    // compute calculateHash
    signal calculatedHash;
    calculatedHash <== calculateSecret.out;

    // Ensures the provided hash matches the calculated hash
    assert(hash == calculatedHash);
    
}

component main {public [hash]} = HashChecker();
