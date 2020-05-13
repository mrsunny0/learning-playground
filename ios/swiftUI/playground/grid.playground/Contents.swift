import UIKit

var str = "Hello, playground"

let numbers = [2,3,4,5,6,7,8, 10]

extension Array {
    func chunked(int size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

var a = numbers.chunked(int: 2)
print("\(a)")

