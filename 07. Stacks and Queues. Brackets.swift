import Foundation
import Glibc

// Solution @ Sergey Leschev, Belarusian State University

// 07. Stacks and Queues. Brackets.

// A string S consisting of N characters is considered to be properly nested if any of the following conditions is true:
// S is empty;
// S has the form "(U)" or "[U]" or "{U}" where U is a properly nested string;
// S has the form "VW" where V and W are properly nested strings.
// For example, the string "{[()()]}" is properly nested but "([)()]" is not.

// Write a function:
// class Solution { public int solution(String S); }
// that, given a string S consisting of N characters, returns 1 if S is properly nested and 0 otherwise.

// For example, given S = "{[()()]}", the function should return 1 and given S = "([)()]", the function should return 0, as explained above.

// Write an efficient algorithm for the following assumptions:
// N is an integer within the range [0..200,000];
// string S consists only of the following characters: "(", "{", "[", "]", "}" and/or ")".

public func solution(_ S: inout String) -> Int {
    let count = S.count
    if count == 0 { return 1 }
    let dict: [Character: Character] = ["{": "}", "[": "]", "(": ")"]
    var stack = Stack<Character>(capacity: count)
    
    for c in S {
        if c == "{" || c == "[" || c == "(" {
            stack.push(c)
        } else if let last = stack.front(), dict[last] == c {
            stack.pop()
        } else { return 0 }
    }
    return stack.count() == 0 ? 1 : 0
}
    
struct Stack<T> {
    private var array: Array<T?>
    private var cursor = 0
        
    init(capacity: Int) {
        array = Array<T?>(repeatElement(nil, count: capacity))
    }
    
    public func count() -> Int { return cursor }

    public mutating func push(_ element: T) {
        array[cursor] = element
        cursor += 1
    }

    public mutating func pop() {
        if cursor != 0 { cursor -= 1 }
    }
    
    public func front() -> T? {
        if cursor == 0 { return nil }
        return array[cursor - 1]
    }
}
