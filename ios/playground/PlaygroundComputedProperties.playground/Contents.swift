import Foundation

var pizzaInInches: Int = 10 {
    willSet {
        print("\(pizzaInInches)")
        print("\(newValue)")
    }
    didSet {
        print("\(oldValue)")
        print("\(pizzaInInches)")
    }
}

var numberOfSlices: Int {
    get {
        return pizzaInInches - 4
    } set {
        print("\(newValue)")
    }
}

pizzaInInches = 100
numberOfSlices = 22
print(numberOfSlices)

var width: Float = 1.5 {
    didSet {
        if width < 0 {
            width = oldValue
        }
    }
}
var height: Float = 2.3

var bucketsOfPaint: Int {
    get {
        return Int(ceilf((width * height) / 1.5))
    }
    set {
        let printStatement = String(format: "%.0f", Double(newValue) * 1.5)
        print(printStatement)
    }
}

print(bucketsOfPaint)
print(width)
width = -1
print(width)

bucketsOfPaint = 100
