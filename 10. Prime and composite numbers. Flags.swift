import Foundation
import Glibc

// Solution @ Sergey Leschev, Belarusian State University

// 10. Prime and composite numbers. Flags.

// A non-empty array A consisting of N integers is given.
// A peak is an array element which is larger than its neighbours. More precisely, it is an index P such that 0 < P < N − 1 and A[P − 1] < A[P] > A[P + 1].

// For example, the following array A:
//     A[0] = 1
//     A[1] = 5
//     A[2] = 3
//     A[3] = 4
//     A[4] = 3
//     A[5] = 4
//     A[6] = 1
//     A[7] = 2
//     A[8] = 3
//     A[9] = 4
//     A[10] = 6
//     A[11] = 2
// has exactly four peaks: elements 1, 3, 5 and 10.

// You are going on a trip to a range of mountains whose relative heights are represented by array A, as shown in a figure below. You have to choose how many flags you should take with you. The goal is to set the maximum number of flags on the peaks, according to certain rules.

// Flags can only be set on peaks. What's more, if you take K flags, then the distance between any two flags should be greater than or equal to K. The distance between indices P and Q is the absolute value |P − Q|.
// For example, given the mountain range represented by array A, above, with N = 12, if you take:
// two flags, you can set them on peaks 1 and 5;
// three flags, you can set them on peaks 1, 5 and 10;
// four flags, you can set only three flags, on peaks 1, 5 and 10.
// You can therefore set a maximum of three flags in this case.

// Write a function:
// class Solution { public int solution(int[] A); }
// that, given a non-empty array A of N integers, returns the maximum number of flags that can be set on the peaks of the array.

// For example, the following array A:
//     A[0] = 1
//     A[1] = 5
//     A[2] = 3
//     A[3] = 4
//     A[4] = 3
//     A[5] = 4
//     A[6] = 1
//     A[7] = 2
//     A[8] = 3
//     A[9] = 4
//     A[10] = 6
//     A[11] = 2
// the function should return 3, as explained above.

// Write an efficient algorithm for the following assumptions:
// N is an integer within the range [1..400,000];
// each element of array A is an integer within the range [0..1,000,000,000].

public func solution(_ A: inout [Int]) -> Int {
    var peakPositions = [Int]()   
    var left: Int?
    var possiblePeak = false

    for i in 0..<A.count {
        let value = A[i]
        guard let leftUnwrapped = left else { left = value; continue }

        if leftUnwrapped < value {
            possiblePeak = true
        } else if leftUnwrapped > value && possiblePeak {
            peakPositions.append(i - 1)
            possiblePeak = false
        } else {
            possiblePeak = false
        }
        left = value
    }
    
    let totalPeaksCount = peakPositions.count
    if totalPeaksCount <= 2 { return peakPositions.count }
        
    let firstPeakPosition = peakPositions.first!
    let lastPeakPosition = peakPositions.last!
    let totalDistance = lastPeakPosition - firstPeakPosition
    let maxPossibleNumberOfFlags = min(totalPeaksCount, Int(sqrt(Double(totalDistance))) + 1)
    let maxReasonableDistance = maxPossibleNumberOfFlags
        
    var distanceCandidat = maxReasonableDistance
    var allowedSkipsCount = totalPeaksCount - maxPossibleNumberOfFlags
    var skippedPeaksCount = 0
    var previousFlagPosition = firstPeakPosition
        
    for _ in 0..<maxPossibleNumberOfFlags {
        for peakIndex in 1..<totalPeaksCount {
            let peakPosition = peakPositions[peakIndex]    
            let currentDistance = peakPosition - previousFlagPosition   
            if currentDistance >= distanceCandidat {
                previousFlagPosition = peakPosition
            } else {
                skippedPeaksCount += 1
                if skippedPeaksCount > allowedSkipsCount { break }
            }
        }
        
        if skippedPeaksCount <= allowedSkipsCount { return distanceCandidat }

        distanceCandidat -= 1
        allowedSkipsCount = totalPeaksCount - distanceCandidat
        skippedPeaksCount = 0
        previousFlagPosition = firstPeakPosition
    }
    
    return 0
}