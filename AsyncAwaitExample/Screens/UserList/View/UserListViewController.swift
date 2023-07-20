//
//  ViewController.swift
//  AsyncAwaitExample
//
//  Created by Neosoft on 20/07/23.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet weak var tblUser: UITableView!
    
    lazy var viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpTableView()
        initViewModel()
    }
    
    func setUpTableView(){
        tblUser.delegate = self
        tblUser.dataSource = self
    }
    func initViewModel(){
        viewModel.delegate = self
        viewModel.fetchUserListWithAsyncAwait()
    }
}

extension UserListViewController : UserServices {
    func reloadTable() {
        tblUser.reloadData()
    }
}

extension UserListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") else {
            return UITableViewCell()
        }
        var cellContent = cell.defaultContentConfiguration()
        cellContent.text = viewModel.userModel[indexPath.row].name
        cell.contentConfiguration = cellContent
        return cell
    }
}
