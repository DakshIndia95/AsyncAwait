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
    //MARK: call api with normal approach
    func fetchUsers<T: Decodable>(url:String,type: T.Type,completion: @escaping Handler<T>){
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data,err == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let userResponse = try JSONDecoder().decode(type, from: data)
                DispatchQueue.main.async {
                    completion(.success(userResponse))
                }
            }catch{
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    //MARK: Call api with async await appraoch
    func fetchUsersAsyncAwait<T:Decodable>(url:String) async throws -> T {
        guard let url = URL(string: url) else {
            throw ApiError.invalidUrl
        }
        let (data,response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
