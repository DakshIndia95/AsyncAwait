//
//  UserViewModel.swift
//  AsyncAwaitExample
//
//  Created by Neosoft on 20/07/23.
//

import Foundation

protocol UserServices : AnyObject{
    func reloadTable() // View and ViewModel communication
}

class UserViewModel {
    var userModel : [UserModel] = []{
        didSet{
            delegate?.reloadTable()
        }
    }
    weak var delegate : UserServices?
    private var apiManager = ApiHandler()
    
    func fetchUserList(){
        apiManager.fetchUsers(url: userUrl, type: [UserModel].self) { result in
            switch result {
            case .success(let userResponseArray):
                self.userModel = userResponseArray
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
