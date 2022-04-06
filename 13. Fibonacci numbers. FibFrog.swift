import Foundation
import Glibc

// Solution @ Sergey Leschev, Belarusian State University

// 13. Fibonacci numbers. FibFrog.

// The Fibonacci sequence is defined using the following recursive formula:
//     F(0) = 0
//     F(1) = 1
//     F(M) = F(M - 1) + F(M - 2) if M >= 2
// A small frog wants to get to the other side of a river. The frog is initially located at one bank of the river (position −1) and wants to get to the other bank (position N). The frog can jump over any distance F(K), where F(K) is the K-th Fibonacci number. Luckily, there are many leaves on the river, and the frog can jump between the leaves, but only in the direction of the bank at position N.

// The leaves on the river are represented in an array A consisting of N integers. Consecutive elements of array A represent consecutive positions from 0 to N − 1 on the river. Array A contains only 0s and/or 1s:
// 0 represents a position without a leaf;
// 1 represents a position containing a leaf.
// The goal is to count the minimum number of jumps in which the frog can get to the other side of the river (from position −1 to position N). The frog can jump between positions −1 and N (the banks of the river) and every position containing a leaf.

// For example, consider array A such that:
//     A[0] = 0
//     A[1] = 0
//     A[2] = 0
//     A[3] = 1
//     A[4] = 1
//     A[5] = 0
//     A[6] = 1
//     A[7] = 0
//     A[8] = 0
//     A[9] = 0
//     A[10] = 0
// The frog can make three jumps of length F(5) = 5, F(3) = 2 and F(5) = 5.

// Write a function:
// class Solution { public int solution(int[] A); }
// that, given an array A consisting of N integers, returns the minimum number of jumps by which the frog can get to the other side of the river. If the frog cannot reach the other side of the river, the function should return −1.

// For example, given:
//     A[0] = 0
//     A[1] = 0
//     A[2] = 0
//     A[3] = 1
//     A[4] = 1
//     A[5] = 0
//     A[6] = 1
//     A[7] = 0
//     A[8] = 0
//     A[9] = 0
//     A[10] = 0
// the function should return 3, as explained above.

// Write an efficient algorithm for the following assumptions:
// N is an integer within the range [0..100,000];
// each element of array A is an integer that can have one of the following values: 0, 1.

public func solution(_ A: inout [Int]) -> Int {
    var leafPositions = Set<Int>()
    for i in 0..<A.count where A[i] == 1 { leafPositions.insert(i) }
    let otherSideOfTheRiver = A.count
    leafPositions.insert(otherSideOfTheRiver)
    var fibNumbers = Set<Int>()
    var currentFibNumber = 1
    var n = 3
    var paths = [Int: Int]()
    
    let fibonacci: (_ n: Int) -> Int = { n in
        let n = Double(n)
        let dividend = pow(((1 + sqrt(5)) / 2), n) - pow(((1 - sqrt(5)) / 2), n)
        let divisor = sqrt(5)
        let quotient = dividend / divisor
        return Int(quotient)
    }

    let maxFibNumber = otherSideOfTheRiver + 1
    repeat {
        fibNumbers.insert(currentFibNumber)
        currentFibNumber = fibonacci(n)
        n += 1
    } while currentFibNumber <= maxFibNumber

    paths[-1] = 0
    
    repeat {
        for path in paths {
            let count = path.value
            let position = path.key

            for fibNumber in fibNumbers {
                let newPosition = fibNumber + position
                if leafPositions.contains(newPosition) {        
                    let newCount = count + 1
                    if newPosition == otherSideOfTheRiver { return newCount }

                    if let existedCount = paths[newPosition] {
                        if newCount < existedCount { paths[newPosition] = newCount }
                    } else { paths[newPosition] = newCount }
                }
            }
            paths[position] = nil
        }
    } while paths.count > 0    
    
    return -1
}