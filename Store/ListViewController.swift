//
//  ListViewController.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit


class ListViewController: UIViewController {
    
    @IBOutlet private weak var tvList: UITableView!
    
    
    private let listViewModel = ListViewModel()
    
    private var selectedItem: Item?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listViewModel.getItems { [weak self] in
            
            self?.tvList.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVc = segue.destination as? DetailViewController, let item = selectedItem {
            destinationVc.configure(with: DetailConfiguration(item: item))
        }
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
        
        selectedItem = listViewModel.items[indexPath.row]
        
        performSegue(withIdentifier: "showDetailViewController", sender: self)
    }
}

extension ListViewController: AddItemDelegate {
    func didAdd(new item: Item) {
        listViewModel.items.append(item)
        
        let indexPath = IndexPath(row: listViewModel.items.count, section: 0)
        
        DispatchQueue.main.sync {
            tvList.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
