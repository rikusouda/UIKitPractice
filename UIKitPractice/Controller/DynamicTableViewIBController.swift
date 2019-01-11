//
//  DynamicTableViewIBController.swift
//  UIKitPractice
//
//  Created by Yuki Yoshioka on 2017/09/03.
//  Copyright © 2017年 rikusouda. All rights reserved.
//

import UIKit

class DynamicTableViewIBController: UIViewController {
    var items: [String] = []

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for _ in 0...3 {
            appendItem(with: .none, autoScroll: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        self.appendItem(with: .automatic, autoScroll: true)
    }
    
    @IBAction func didTapDeleteButton(_ sender: UIBarButtonItem) {
        self.deleteItem(with: .automatic, autoScroll: true)
    }
}

extension DynamicTableViewIBController {
    
    
    func appendItem(with animation: UITableView.RowAnimation, autoScroll: Bool) {
        let item = "Cell \(items.count)"
        items.append(item)
        let indexPath = IndexPath(row: items.count-1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: animation)
        if autoScroll {
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func deleteItem(with animation: UITableView.RowAnimation, autoScroll: Bool) {
        if items.count > 0 {
            items.removeLast(1)
            self.tableView.deleteRows(at: [IndexPath(row: items.count, section: 0)],
                                      with: animation)
            if autoScroll && items.count > 0 {
                self.tableView.scrollToRow(at: IndexPath(row: items.count-1, section: 0),
                                           at: .bottom,
                                           animated: true)
            }
        }
    }
    
    func item(for indexPath: IndexPath) -> String? {
        if items.count > indexPath.row {
            return items[indexPath.row]
        }
        return nil
    }
}

extension DynamicTableViewIBController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = item(for: indexPath) {
            let alert = UIAlertController(title: item, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil)
            )
            self.present(alert, animated: true, completion: nil)
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension DynamicTableViewIBController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewIBCell") as! TableViewIBCell
        if let item = item(for: indexPath) {
            cell.configure(item: item)
        } else {
            cell.configure(item: "[unknown error]")
        }
        return cell
    }
}
