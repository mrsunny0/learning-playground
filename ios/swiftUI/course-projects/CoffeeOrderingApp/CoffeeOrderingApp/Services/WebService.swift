import Foundation

class WebService {
    
    let uri = "https://island-bramble.glitch.me/"
    
    func getAllOrders(completion: @escaping ([Order]?) -> ()) {
        
        if let url = URL(string: "uri" + "/orders") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, error == nil {
                    
                    if let orders = try? JSONDecoder().decode([Order].self, from: data) {
                        DispatchQueue.main.async {
                            completion(orders)
                            return
                        }
                    }
                    
                    
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                completion(nil)
            }
        }
        
    }
    
}
