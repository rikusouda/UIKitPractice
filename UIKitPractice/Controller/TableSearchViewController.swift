//
//  TableSearchViewController.swift
//  UIKitPractice
//
//  Created by Yuki Yoshioka on 2017/10/18.
//  Copyright © 2017年 rikusouda. All rights reserved.
//

import UIKit

class TableSearchViewController: UITableViewController {
    var items = [String]()
    var searchedItems: [String]?
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = TableSearchViewController.createItems()
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.sizeToFit()
        
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
        } else {
            self.tableView.tableHeaderView = searchController.searchBar
        }
        
        self.searchController = searchController
    }
}

// DataSource
extension TableSearchViewController {
    static func createItems() -> [String] {
        return [Int](0..<100).map { "Item \($0)" }
    }
    
    func item(for indexPath: IndexPath) -> String? {
        switch indexPath.section {
        case 0:
            if self.searchController?.isActive ?? false {
                if let searchedItems = self.searchedItems,
                    searchedItems.count > indexPath.row {
                    return searchedItems[indexPath.row]
                } else {
                    return nil
                }
            } else {
                if self.items.count > indexPath.row {
                    return self.items[indexPath.row]
                } else {
                    return nil
                }
            }
        default:
            return nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController?.isActive ?? false {
            if let searchedItems = self.searchedItems {
                return searchedItems.count
            } else {
                return 0
            }
        } else {
            return items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell")!
        if let item = item(for: indexPath) {
            cell.textLabel?.text = item
        } else {
            cell.textLabel?.text = "[unknown error]"
        }
        return cell
    }
}

extension TableSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else { return }
        
        if let searchText = searchController.searchBar.text,
            searchText.characters.count > 0 {
            self.searchedItems = self.items.filter { $0.contains(searchText) }
        } else {
            self.searchedItems = self.items
        }
        self.tableView.reloadData()
    }
}
