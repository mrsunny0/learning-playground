import UIKit

extension Double {
    func round(to places: Int) -> Double {
        let precision = pow(10, Double(places))
        var n = self * precision
        n.round()
        n = n / precision
        return n
    }
}

var myDouble = 3.14159
print(myDouble.round(to: 3))

// extending a button
extension UIButton {
    func makeCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}

let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
button.backgroundColor = .red
button.makeCircular()
