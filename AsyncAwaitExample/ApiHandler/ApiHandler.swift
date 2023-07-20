//
//  ApiHandler.swift
//  AsyncAwaitExample
//
//  Created by Neosoft on 20/07/23.
//

import Foundation

enum ApiError : Error{
    case invalidUrl
    case invalidData
    case invalidResponse
    case network(Error?)
}

typealias Handler<T> = (Result<T,ApiError>) -> Void

class ApiHandler {
    func fetchUsers<T: Decodable>(url:String,type: T.Type,completion: @escaping Handler<T>){
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, err in
            guard err == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let userResponse = try JSONDecoder().decode(type, from: data)
                print("User Response: \(userResponse)")
                DispatchQueue.main.async {
                    completion(.success(userResponse))
                }
            }catch{
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
