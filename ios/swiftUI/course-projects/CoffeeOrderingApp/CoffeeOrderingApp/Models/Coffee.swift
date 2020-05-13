import Foundation

struct Coffee {
    let name: String
    let imageURL: String
    let price: Double
}

extension Coffee {
    static func all() -> [Coffee] {
        return [
            Coffee(name: "Hello", imageURL: "", price: 1.0),
            Coffee(name: "Hello", imageURL: "", price: 1.0),
            Coffee(name: "Hello", imageURL: "", price: 1.0)
        ]
    }
}
