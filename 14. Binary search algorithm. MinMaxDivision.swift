import Foundation
import Glibc

// Solution @ Sergey Leschev, Belarusian State University

// 14. Binary search algorithm. MinMaxDivision.

// You are given integers K, M and a non-empty array A consisting of N integers. Every element of the array is not greater than M.
// You should divide this array into K blocks of consecutive elements. The size of the block is any integer between 0 and N. Every element of the array should belong to some block.
// The sum of the block from X to Y equals A[X] + A[X + 1] + ... + A[Y]. The sum of empty block equals 0.
// The large sum is the maximal sum of any block.

// For example, you are given integers K = 3, M = 5 and array A such that:
//   A[0] = 2
//   A[1] = 1
//   A[2] = 5
//   A[3] = 1
//   A[4] = 2
//   A[5] = 2
//   A[6] = 2
// The array can be divided, for example, into the following blocks:
// [2, 1, 5, 1, 2, 2, 2], [], [] with a large sum of 15;
// [2], [1, 5, 1, 2], [2, 2] with a large sum of 9;
// [2, 1, 5], [], [1, 2, 2, 2] with a large sum of 8;
// [2, 1], [5, 1], [2, 2, 2] with a large sum of 6.
// The goal is to minimize the large sum. In the above example, 6 is the minimal large sum.

// Write a function:
// class Solution { public int solution(int K, int M, int[] A); }
// that, given integers K, M and a non-empty array A consisting of N integers, returns the minimal large sum.

// For example, given K = 3, M = 5 and array A such that:
//   A[0] = 2
//   A[1] = 1
//   A[2] = 5
//   A[3] = 1
//   A[4] = 2
//   A[5] = 2
//   A[6] = 2
// the function should return 6, as explained above.

// Write an efficient algorithm for the following assumptions:
// N and K are integers within the range [1..100,000];
// M is an integer within the range [0..10,000];
// each element of array A is an integer within the range [0..M].

public func solution(_ K: Int, _ M: Int, _ A: inout [Int]) -> Int {
    var maxElement = A.first!
    var prefixSums = [A.first!]
    var result = 0
    var handledLeftIndex = 0
    var handledLeftSum = 0    
    var blocksCount = 0
    var maxCurrentBlockSum = 0
    
    for i in 1..<A.count {
        let element = A[i]
        prefixSums.append(prefixSums.last! + element)
        maxElement = max(element, maxElement)
    }
       
    let totalSum = prefixSums.last!

    var minTargetBlockSum = Int((Double(totalSum) / Double(K)).rounded(.up))
    minTargetBlockSum = max(minTargetBlockSum, maxElement)
    var maxTargetBlockSum = totalSum
    var targetBlockSum = (maxTargetBlockSum + minTargetBlockSum) / 2

    while blocksCount != K && minTargetBlockSum <= maxTargetBlockSum {        
        var leftIndex = handledLeftIndex
        var rightIndex = prefixSums.count - 1
        var position: Int?

        while leftIndex <= rightIndex {
            let mid = (leftIndex + rightIndex) / 2
            let totalLeftSum = prefixSums[mid]
            let currentBlockSum = totalLeftSum - handledLeftSum
            
            if currentBlockSum > targetBlockSum {
                rightIndex = mid - 1
            } else {
                leftIndex = mid + 1
                position = mid
                maxCurrentBlockSum = max(maxCurrentBlockSum, currentBlockSum)
            }
        }         
        
        handledLeftIndex = position!
        handledLeftSum = prefixSums[position!]
        blocksCount += 1

        let tooSmallBlockSize = (totalSum - handledLeftSum) > (K - blocksCount) * targetBlockSum

        if blocksCount == K || tooSmallBlockSize {
            let delta = totalSum - handledLeftSum
            if delta > 0 {
                minTargetBlockSum = targetBlockSum + 1
            } else {
                maxTargetBlockSum = targetBlockSum - 1
                result = maxCurrentBlockSum
            }
            targetBlockSum = (maxTargetBlockSum + minTargetBlockSum) / 2

            handledLeftIndex = 0
            handledLeftSum = 0
            blocksCount = 0
            maxCurrentBlockSum = 0
        }
    }    
    
    return result
}