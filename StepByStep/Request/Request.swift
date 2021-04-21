//
//  Request.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import Foundation

class Request {
    
    static let shared = Request()
    
    private let baseURL = "https://thebigachallenge.appspot.com/_ah/api/myApi/v1/goals"
    private var goals: Goals?
    
    func getRequest(completion: @escaping(Goals) -> Void) {
        
        let url = baseURL
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let  response = response as? HTTPURLResponse
            else {
                print("An error has occurred")
                return
            }
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    self.goals = try decoder.decode(Goals.self, from: data)
                    completion(self.goals!)
                } catch {
                    print("Error. \(error)")
                }
            } else {
                print("Error in Server \(response.statusCode)")
            }
        }.resume()
    }
    
}
