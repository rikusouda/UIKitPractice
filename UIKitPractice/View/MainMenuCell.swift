//
//  MainMenuCell.swift
//  UIKitPractice
//
//  Created by Yuki Yoshioka on 2017/08/20.
//  Copyright © 2017年 rikusouda. All rights reserved.
//

import UIKit

class MainMenuCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
