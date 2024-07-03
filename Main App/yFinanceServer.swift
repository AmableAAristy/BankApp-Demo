import Foundation

class ServerConnection: ObservableObject {
    @Published var openPrices: [Double] = []
    @Published var closePrices: [Double] = []
    @Published var bothPrices: [(open: Double, close: Double)] = []
    @Published var dates: [String] = []
    @Published var isLoading:Bool = true
    
    //right now we are only using the both. if we do not end up using any of the other ones we may remove them
    
    
    
    private var serverURL: String = ""
       
       init() {
           if let secret = loadSecret() {
               self.serverURL = secret.serverURL
           } else {
               fatalError("Failed to load server URL from configuration")
           }
       }
       
       struct Secret: Codable {
           let serverURL: String
       }

       func loadSecret() -> Secret? {
           guard let url = Bundle.main.url(forResource: "Secret", withExtension: "json"),
                 let data = try? Data(contentsOf: url) else {
               return nil
           }

           let decoder = JSONDecoder()
           return try? decoder.decode(Secret.self, from: data)
       }
       
    
    func fetchOpenPrices(ticker: String, length:String = "1mo") {
        let urlString = "\(serverURL)/open"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let requestData: [String: Any] = [
            "ticker": ticker,
            "length": length
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: []) else {
            print("Error creating JSON data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let openPrices = json["open_prices"] as? [Double] {
                    DispatchQueue.main.async {
                        self?.openPrices = openPrices
                    }
                } else {
                    print("Invalid response data")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
    
    func fetchClosePrices(ticker: String, length:String = "1mo") {
        let urlString = "\(serverURL)/close"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let requestData: [String: Any] = [
            "ticker": ticker,
            "length": length
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: []) else {
            print("Error creating JSON data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let closePrices = json["close_prices"] as? [Double] {
                    DispatchQueue.main.async {
                        self?.closePrices = closePrices
                    }
                } else {
                    print("Invalid response data")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
    func fetchBothPrices(ticker: String, length:String = "1mo") {
        let urlString = "\(serverURL)/both"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let requestData: [String: Any] = [
            "ticker": ticker,
            "length": length
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: []) else {
            print("Error creating JSON data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let dates = json["dates"] as? [String],
                   let openPrices = json["open_prices"] as? [Double],
                   let closePrices = json["close_prices"] as? [Double] {
                    DispatchQueue.main.async {
                        self?.bothPrices = zip(openPrices, closePrices).map { (open: $0, close: $1) }
                        self?.dates = dates
                        self?.isLoading = false
                    }
  
                } else {
                    print("Invalid response data")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
}
