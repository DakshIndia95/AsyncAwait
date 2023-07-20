//
//  JsonHelper.swift
//  AsyncAwaitExample
//
//  Created by Neosoft on 20/07/23.
//

import Foundation

struct JSONHelper {
    func loadJsonDataFromFile() -> ([UserModel]?) {
        guard let url = Bundle.main.url(forResource: "UserData", withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        if let mainData = decodeData(data: data) {
            return mainData
        }
        return nil
    }
    
    private func decodeData( data: Data) -> [UserModel]? {
        guard let jsonData = try? JSONDecoder().decode([UserModel].self, from: data) else { return nil }
        return jsonData
    }
}
