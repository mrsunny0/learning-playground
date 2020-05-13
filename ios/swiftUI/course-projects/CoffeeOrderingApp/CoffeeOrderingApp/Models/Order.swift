import Foundation

struct Order: Codable {
    let name: String
    let coffeeName: String
    let size: String
    let total: Double
}
