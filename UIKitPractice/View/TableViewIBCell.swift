//
//  TableViewIBCell.swift
//  UIKitPractice
//
//  Created by Yuki Yoshioka on 2017/09/03.
//  Copyright © 2017年 rikusouda. All rights reserved.
//

import UIKit

class TableViewIBCell: UITableViewCell {    
    @IBOutlet weak var itemLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(item: String) {
        itemLabel.text = item
    }
}
