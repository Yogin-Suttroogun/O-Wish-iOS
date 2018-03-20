//
//  AdminVC.swift
//  O'Wish
//
//  Created by SUTTROOGUN Yogin Kumar on 11/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit

class AdminVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var product = Product()
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        product.downloadProductItem { (product) in
            self.products = product
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemCell{
            let product = products[indexPath.row]
            cell.configureCell(product: product)
            return cell
        }else{
            return ItemCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  products.count > 0 {
            let item = products[indexPath.row]
            performSegue(withIdentifier: "editItemDetails", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editItemDetails"{
            if let destination = segue.destination as? ItemDetailsVC{
                if let item = sender as? Product{
                    destination.itemToEdit = item
                }
            }
        }
    }
}

