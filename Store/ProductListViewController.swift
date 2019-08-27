//
//  ListViewController.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit


class ProductListViewController: UIViewController {
    
    private let productListViewModel = ProductListViewModel()
    private var selectedProduct: Product?
    
    @IBOutlet private weak var tvProductList: UITableView!
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.cellIdentifier) else {
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
        performSegue(withIdentifier: Constants.Identifier.segueIdentifierDetailVC, sender: self)
    }
}

// MARK: - AddProductDelegate
extension ProductListViewController: AddProductDelegate {
    
    func didAdd(new product: Product) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) { [weak self] in
            guard let this = self else { return }
            this.productListViewModel.products.append(product)
            let indexPath = IndexPath(row: this.productListViewModel.products.count - 1, section: 0)
            
            DispatchQueue.main.sync {
                this.tvProductList.beginUpdates()
                this.tvProductList.insertRows(at: [indexPath], with: .automatic)
                this.tvProductList.endUpdates()
            }
        }
    }
}
