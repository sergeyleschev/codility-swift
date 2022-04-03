import Foundation
import Glibc

// Solution @ Sergey Leschev, Belarusian State University

// 2017 Contest. DiamondsCount.

// A diamond is a quadrilateral whose four sides all have the same length and whose diagonals are parallel to the coordinate axes.
// You are given N distinct points on a plane. Count the number of different diamonds that can be constructed using these points as vertices (two diamonds are different if their sets of vertices are different). Do not count diamonds whose area is empty.

// Write a function:
// class Solution { public int solution(int[] X, int[] Y); }
// that, given two arrays X and Y, each containing N integers, representing N points (where X[K], Y[K] are the coordinates of the K-th point), returns the number of diamonds on the plane.

// For example, for N = 7 points whose coordinates are specified in arrays X = [1, 1, 2, 2, 2, 3, 3] and Y = [3, 4, 1, 3, 5, 3, 4], the function should return 2, since we can find two diamonds as shown in the picture below:

// Given arrays: X = [1, 2, 3, 3, 2, 1], Y = [1, 1, 1, 2, 2, 2], the function should return 0, since there are no diamonds on the plane:

// Write an efficient algorithm for the following assumptions:
// N is an integer within the range [4..1,500];
// each element of arrays X and Y is an integer within the range [0..N-1];
// given N points are pairwise distinct.

public func solution(_ X : inout [Int], _ Y : inout [Int]) -> Int {
    typealias XPosition = Int
    typealias YPosition = Int
    var verticalCache = [YPosition: Set<XPosition>]()
    var horizontalCache = [XPosition: Set<YPosition>]()
    var result = 0
        
    for i in 0..<X.count {
        let x = X[i]
        let y = Y[i]
            
        if verticalCache[y] != nil {
            verticalCache[y]!.insert(x)
        } else {
            verticalCache[y] = [x]
        }
            
        if horizontalCache[x] != nil {
            horizontalCache[x]!.insert(y)
        } else {
            horizontalCache[x] = [y]
        }
    }

    for (centerX, yPoints) in horizontalCache {
        guard yPoints.count >= 2 else { continue }
        let yPointsArray = Array(yPoints)
            
        for i in 0..<yPointsArray.count - 1 {
            for j in (i + 1)..<yPointsArray.count {
                let pointA = yPointsArray[i]
                let pointB = yPointsArray[j]
                let distanceY = abs(pointA - pointB)
                guard distanceY % 2 == 0 else { continue }
                let centerY = min(pointA, pointB) + distanceY / 2
                guard let xPoints = verticalCache[centerY] else { continue }
                    
                for xPoint in xPoints {
                    guard xPoint < centerX else { continue }
                    let diamondRightPointEstimatedPosition = centerX - xPoint + centerX
                        
                    if xPoints.contains(diamondRightPointEstimatedPosition) { result += 1 }
                }
            }
        }
    }
        
    return result
}