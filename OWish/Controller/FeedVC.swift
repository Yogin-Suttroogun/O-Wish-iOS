//
//  FeedVC.swift
//  O'Wish
//
//  Created by SUTTROOGUN Yogin Kumar on 11/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var product = Product()
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        product.downloadProductItem { (product) in
            self.products = product
            self.tableView.reloadData()
        }
        
        self.tableView.addSubview(self.refreshControl)
    }
    
    lazy var refreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FeedVC.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    func handleRefresh(_ refreshControl: UIRefreshControl){
        product.downloadProductItem { (product) in
            self.products = product
            self.tableView.reloadData()
        }
        
        refreshControl.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "newsFeedCell", for: indexPath) as? NewsFeedCell{
            let product = products[indexPath.row]
            cell.configureCell(product: product)
            return cell
        }else{
            return NewsFeedCell()
        }
    }
    
}

