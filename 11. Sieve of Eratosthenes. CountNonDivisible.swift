import Foundation
import Glibc

// Solution @ Sergey Leschev, Belarusian State University

// 11. Sieve of Eratosthenes. CountNonDivisible.

// You are given an array A consisting of N integers.
// For each number A[i] such that 0 ≤ i < N, we want to count the number of elements of the array that are not the divisors of A[i]. We say that these elements are non-divisors.

// For example, consider integer N = 5 and array A such that:
//     A[0] = 3
//     A[1] = 1
//     A[2] = 2
//     A[3] = 3
//     A[4] = 6
// For the following elements:
// A[0] = 3, the non-divisors are: 2, 6,
// A[1] = 1, the non-divisors are: 3, 2, 3, 6,
// A[2] = 2, the non-divisors are: 3, 3, 6,
// A[3] = 3, the non-divisors are: 2, 6,
// A[4] = 6, there aren't any non-divisors.

// Write a function:
// class Solution { public int[] solution(int[] A); }
// that, given an array A consisting of N integers, returns a sequence of integers representing the amount of non-divisors.

// Result array should be returned as an array of integers.

// For example, given:
//     A[0] = 3
//     A[1] = 1
//     A[2] = 2
//     A[3] = 3
//     A[4] = 6
// the function should return [2, 4, 3, 2, 0], as explained above.

// Write an efficient algorithm for the following assumptions:
// N is an integer within the range [1..50,000];
// each element of array A is an integer within the range [1..2 * N].

public func solution(_ A: inout [Int]) -> [Int] {
    let maxNumber = 2 * 50_000
    let totalCount = A.count
    var allNumbersDict = [Int: Int]()
    var resultsDict = [Int: Int]()
    var results = [Int]()
    
    for i in 0..<totalCount {
        let number = A[i]
        if let count = allNumbersDict[number] {
            allNumbersDict[number] = count + 1
        } else {
            allNumbersDict[number] = 1
        }
    }    
    
    for entry in allNumbersDict {
        let number = entry.key
        var k = number * 2

        while k <= maxNumber {
            if allNumbersDict[k] != nil {
                let duplicates = allNumbersDict[number]!
                if let count = resultsDict[k] {
                    resultsDict[k] = count + duplicates
                } else {
                    resultsDict[k] = duplicates
                }
            }
            k += number
        }
    }

    for i in 0..<totalCount {
        let number = A[i]
        let duplicates = allNumbersDict[number]!
        
        if let count = resultsDict[number] {
            results.append(totalCount - count - duplicates)
        } else {
            results.append(totalCount - duplicates)
        }
    }    
    
    return results
}