﻿namespace Quantum.Bell {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Set (desired: Result, q1: Qubit ) : Unit {
        //checking the first qbit
        if (desired != M(q1)) {
            //apply Bitflip to it
            X(q1);
        }
    }                      //arguments                       //type of data that return
    operation TestBellState(count : Int, initial : Result) : (Int, Int, Int) {

    mutable numOnes = 0;
    mutable agree = 0;
    using ((q0,q1) = (Qubit(),Qubit())) {

        for (test in 1..count) {
            Set(initial, q0);
            Set(Zero, q1);
            H(q0);
            CNOT(q0, q1);
            let res = M(q0);

            //check if q1 = q0
            if (M(q1) == res) {
                set agree += 1;
            }
            //check if q0 = 1
            if (res == One) {
                set numOnes += 1;
            }
        }
        Set(Zero, q0);
        Set(Zero, q1);
    }

    // Return number of times we saw a |0> and number of times we saw a |1>
    return (count-numOnes, numOnes, agree);
    }


}