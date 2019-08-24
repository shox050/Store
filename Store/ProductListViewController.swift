//
//  ListViewController.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit


class ProductListViewController: UIViewController {
    
    @IBOutlet private weak var tvProductList: UITableView!
    
    private let productListViewModel = ProductListViewModel()
    private var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productListViewModel.getProducts { [weak self] in
            self?.tvProductList.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVc = segue.destination as? ProductDetailViewController, let product = selectedProduct {
            destinationVc.configure(with: ProductDetailConfiguration(product: product))
        } else if let destinationVc = segue.destination as? AddProductViewController {
            destinationVc.delegate = self
        }
    }
}


// MARK: - UITableViewDataSource
extension ProductListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListViewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell") else {
            return UITableViewCell()
        }

        cell.textLabel?.text = productListViewModel.products[indexPath.row].name

        return cell
    }
}


// MARK: - UITableViewDelegate
extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedProduct = productListViewModel.products[indexPath.row]
        
        performSegue(withIdentifier: "showProductDetailViewController", sender: self)
    }
}

extension ProductListViewController: AddProductDelegate {
    func didAdd(new product: Product) {
        productListViewModel.products.append(product)
        
        let indexPath = IndexPath(row: productListViewModel.products.count - 1, section: 0)
        
        tvProductList.beginUpdates()
        tvProductList.insertRows(at: [indexPath], with: .automatic)
        tvProductList.endUpdates()
    }
}
