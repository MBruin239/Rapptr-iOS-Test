//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
*/

class LoginClient {
    
    var session: URLSession?
    
    func login(email: String, password: String, completion: @escaping (String) -> Void, error errorHandler: @escaping (String?) -> Void) {

        let url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/login.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let params = ["email":email, "password":password]
        try! request.httpBody = JSONSerialization.data(withJSONObject: params)

        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            guard let data = data else { errorHandler("Data is empty"); return }
            
            if let dict = try? data.to(type: [String: String].self) {
                print(dict)
                guard let code = dict["code"] else { errorHandler("Code was empty"); return }
                guard let message = dict["message"] else { errorHandler("Message was empty"); return }
                if code == "Error" {
                    errorHandler(message)
                    return
                }
            
                completion(message)
            }
            errorHandler("Could not decode"); return
        })
        task.resume()
    }
}
