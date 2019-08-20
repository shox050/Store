//
//  ListViewController.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit


class ListViewController: UIViewController {
    
    let listViewModel = ListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listViewModel.getItems()
    }
}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell") else {
            return UITableViewCell()
        }

        cell.textLabel?.text = listViewModel.items[indexPath.row].name

        return cell
    }
}


// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "showDetailViewController", sender: self)
    }
}
