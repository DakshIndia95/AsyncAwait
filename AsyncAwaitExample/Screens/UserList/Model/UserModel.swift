//
//  UserModel.swift
//  AsyncAwaitExample
//
//  Created by Neosoft on 20/07/23.
//

import Foundation

struct UserModel: Decodable {
    let id : Int
    let name, username, email : String
}
