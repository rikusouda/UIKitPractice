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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = TableSearchViewController.createItems()
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
            if self.items.count > indexPath.row {
                return self.items[indexPath.row]
            } else {
                return nil
            }
        default:
            return nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
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
