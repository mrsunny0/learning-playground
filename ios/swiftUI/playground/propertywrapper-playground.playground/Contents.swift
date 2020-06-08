import UIKit

//MARK: - uppercase
@propertyWrapper
class UpperCase {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set {
            value = newValue.uppercased()
        }
    }
}

struct Driver {
    @UpperCase
    var license: String
}

extension Driver {
    init(license: String) {
        self.license = license
    }
}

var driver = Driver(license: "sofihaoweifho aieh")
print(driver.license)

//MARK: - URL encode
@propertyWrapper
class UrlEncode {
    private(set) var value: String = ""
    var wrappedValue: String {
        get { value }
        set {
            if let url = newValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                self.value = url
            }
        }
    }
    
}

struct Resource {
    @UrlEncode
    var city: String
    var url: String {
        "HELLO \(self.city)"
    }
    
}

extension Resource {
    init(city: String) {
        self.city = city
    }
}

var resource = Resource(city: "foaehfoaiwe oiahfeo iaweofi h")
print(resource.url)
