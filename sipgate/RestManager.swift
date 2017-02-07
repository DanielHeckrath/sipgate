//
//  RestManager.swift
//  sipgate
//
//  Created by Daniel Heckrath on 07/02/2017.
//  Copyright © 2017 Daniel Heckrath. All rights reserved.
//

import Foundation

typealias TokenAuthCompletionHandler = (TokenAuthResponse?) -> Void
typealias GetBalanceCompletionHandler = (GetBalanceResponse?) -> Void

class RestManager {
    static let shared = RestManager()
    
    let baseURL = "https://api.sipgate.com/v1"
    
    func authenticate(username: String, password: String, onComplete: @escaping TokenAuthCompletionHandler) {
        let endpoint: String = "\(baseURL)/authorization/token"
        
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            onComplete(nil)
            return
        }
        
        let request = TokenAuthRequest(username: username, password: password)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        guard let json = request.toJSON() else {
            print("Error: cannot create URL")
            onComplete(nil)
            return
        }
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } catch {
            print(error.localizedDescription)
            onComplete(nil)
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("error calling GET on /authorization/token")
                print(error!)
                onComplete(nil)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                onComplete(nil)
                return
            }
            
            let tokenResponse = TokenAuthResponse(data: responseData)
            onComplete(tokenResponse)
        }
        
        task.resume()
    }
    
    func getBalance(token: String, onComplete: @escaping GetBalanceCompletionHandler) {
        let endpoint: String = "\(baseURL)/balance"
        
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            onComplete(nil)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("error calling GET on /authorization/token")
                print(error!)
                onComplete(nil)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                onComplete(nil)
                return
            }
            
            let balanceResponse = GetBalanceResponse(data: responseData)
            onComplete(balanceResponse)
        }
        
        task.resume()
    }
}
