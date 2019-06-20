//
//  ServerManager.swift
//  SetGame
//
//  Created by Chris Aguilera on 6/19/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import Foundation

struct ServerManager {
    
    static let apiUrl = "http://192.168.0.18:5000/api/1.0"
    
    static func getAllUsers(completionHandler: @escaping (([User]?) -> Void)) {
        let urlString = apiUrl + "/users"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let users = try? JSONDecoder().decode([User].self, from: data)
            DispatchQueue.main.async {
                completionHandler(users)
            }
        }.resume()
    }
    
    static func postUser(_ user: User, completionHandler: @escaping ((User?)->Void)) {
        let urlString = apiUrl + "/newUser"
        guard let url = URL.init(string: urlString) else { return }
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(user)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("Task completion handler")
            guard let httpRespnse = response as? HTTPURLResponse else {
                print("No response code")
                return
            }
            print(httpRespnse.statusCode)
            if httpRespnse.statusCode == 200 {
                guard let data = data else { return }
                let user = try? JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(user)
                }
            } else if httpRespnse.statusCode == 404 {
                
            } else if httpRespnse.statusCode == 400 {
                
            }
        }
        task.resume()
    }
    
    static func attemptSignIn(user: User, completionHandler: @escaping ((User?)->Void)) {
        let urlString = apiUrl + "/signIn/" + user.username
        guard let url = URL.init(string: urlString) else { return }
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(user)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpRespnse = response as? HTTPURLResponse else { return }
            if httpRespnse.statusCode == 200 {
                guard let data = data else { return }
                let user = try? JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(user)
                }
            } else if httpRespnse.statusCode == 404 {
                
            }
        }
        task.resume()
    }
    
    static func getAllScores(completionHandler: @escaping (([Score]?)->Void)) {
        let urlString = apiUrl + "/scores"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let scores = try? JSONDecoder().decode([Score].self, from: data)
            DispatchQueue.main.async {
                completionHandler(scores)
            }
            }.resume()
    }
}
