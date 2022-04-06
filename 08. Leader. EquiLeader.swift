import Foundation
import Glibc

// Solution @ Sergey Leschev, Belarusian State University

// 08. Leader. EquiLeader.

// A non-empty array A consisting of N integers is given.
// The leader of this array is the value that occurs in more than half of the elements of A.
// An equi leader is an index S such that 0 ≤ S < N − 1 and two sequences A[0], A[1], ..., A[S] and A[S + 1], A[S + 2], ..., A[N − 1] have leaders of the same value.

// For example, given array A such that:
//     A[0] = 4
//     A[1] = 3
//     A[2] = 4
//     A[3] = 4
//     A[4] = 4
//     A[5] = 2
// we can find two equi leaders:
// 0, because sequences: (4) and (3, 4, 4, 4, 2) have the same leader, whose value is 4.
// 2, because sequences: (4, 3, 4) and (4, 4, 2) have the same leader, whose value is 4.
// The goal is to count the number of equi leaders.

// Write a function:
// class Solution { public int solution(int[] A); }
// that, given a non-empty array A consisting of N integers, returns the number of equi leaders.

// For example, given:
//     A[0] = 4
//     A[1] = 3
//     A[2] = 4
//     A[3] = 4
//     A[4] = 4
//     A[5] = 2
// the function should return 2, as explained above.

// Write an efficient algorithm for the following assumptions:
// N is an integer within the range [1..100,000];
// each element of array A is an integer within the range [−1,000,000,000..1,000,000,000].

public func solution(_ A: inout [Int]) -> Int {
    let count = A.count
    if count <= 1 { return 0 }
    var leftEquiLeaders = [Int: Int](minimumCapacity: count)
    var leftCounts = [Int: Int](minimumCapacity: count)
    var maxLeft = (value: Int.min, count: 0)
    var leadersCount = 0        
    var maxRight = (value: Int.min, count: 0)

    for s in 0..<count {
        let l = A[s]
        var newCount = 1
        if let currentCount = leftCounts[l] { newCount += currentCount }
        
        leftCounts[l] = newCount    
        if maxLeft.count < newCount { maxLeft = (l, newCount) }
        
        if maxLeft.count >= (s + 1) / 2 + 1 { leftEquiLeaders[s] = maxLeft.value }
    }
    
    var rightCounts = [Int: Int](minimumCapacity: count)
    
    for s in 0..<count {
        let rightIndex = count - 1 - s
        let r = A[rightIndex]
        var newCount = 1
        if let currentCount = rightCounts[r] { newCount += currentCount }
        
        rightCounts[r] = newCount
            
        if maxRight.count < newCount { maxRight = (r, newCount) }
        let rs = rightIndex - 1

        if maxRight.count >= (count - rightIndex) / 2 + 1 {
            if let leftLeader = leftEquiLeaders[rs], leftLeader == maxRight.value { leadersCount += 1 }
        }
    }
    return leadersCount
}
