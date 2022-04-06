import Foundation
import Glibc

// Solution @ Sergey Leschev, Belarusian State University

// 12. Euclidean algorithm. CommonPrimeDivisors.

// A prime is a positive integer X that has exactly two distinct divisors: 1 and X. The first few prime integers are 2, 3, 5, 7, 11 and 13.
// A prime D is called a prime divisor of a positive integer P if there exists a positive integer K such that D * K = P. For example, 2 and 5 are prime divisors of 20.
// You are given two positive integers N and M. The goal is to check whether the sets of prime divisors of integers N and M are exactly the same.

// For example, given:
// N = 15 and M = 75, the prime divisors are the same: {3, 5};
// N = 10 and M = 30, the prime divisors aren't the same: {2, 5} is not equal to {2, 3, 5};
// N = 9 and M = 5, the prime divisors aren't the same: {3} is not equal to {5}.

// Write a function:
// class Solution { public int solution(int[] A, int[] B); }
// that, given two non-empty arrays A and B of Z integers, returns the number of positions K for which the prime divisors of A[K] and B[K] are exactly the same.

// For example, given:
//     A[0] = 15   B[0] = 75
//     A[1] = 10   B[1] = 30
//     A[2] = 3    B[2] = 5
// the function should return 1, because only one pair (15, 75) has the same set of prime divisors.

// Write an efficient algorithm for the following assumptions:
// Z is an integer within the range [1..6,000];
// each element of arrays A and B is an integer within the range [1..2,147,483,647].

public func solution(_ A: inout [Int], _ B: inout [Int]) -> Int {
    var numberOfPositions = 0


    func greatestCommonDivisor(_ a: Int, _ b: Int) -> Int {
        if (a % b) == 0 { return b }
        return greatestCommonDivisor(b, a % b)
    }
        
    for i in 0..<A.count {
        let a = A[i]
        let b = B[i]
        if a == b { continue }
        let gcd = greatestCommonDivisor(a, b)    
        if gcd == 1 { numberOfPositions += 1; continue }

        var x = (a / gcd) * (b / gcd)
        while x != 1 {
            let tempGCD = greatestCommonDivisor(gcd, x)
            if tempGCD == 1 { numberOfPositions += 1; break }
            x = x / tempGCD
        }
    }
    return A.count - numberOfPositions
}