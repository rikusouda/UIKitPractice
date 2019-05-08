//
//  TabBarController.swift
//  UIKitPractice
//
//  Created by yuki.yoshioka on 2019/05/08.
//  Copyright © 2019 rikusouda. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClose(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
