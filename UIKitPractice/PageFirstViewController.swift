//
//  PageFirstViewController.swift
//  UIKitPractice
//
//  Created by yuki.yoshioka on 2019/06/28.
//  Copyright © 2019 rikusouda. All rights reserved.
//

import Foundation
import UIKit

class PageFirstViewController: UIViewController {
    unowned private var pageViewController: PageViewController!
    
    static func create(parent: PageViewController) -> PageFirstViewController {
        let vc = UIStoryboard(name: "PageViewController",
                              bundle: nil)
            .instantiateViewController(withIdentifier: "PageFirstViewController") as! PageFirstViewController
        vc.pageViewController = parent
        return vc
    }
    
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
    
    @IBAction @objc func toSpecialButtonTap(sender: UIButton) {
        let vc = UIStoryboard(name: "PageViewController",
                              bundle: nil)
            .instantiateViewController(withIdentifier: "PageSpecialViewController") as! PageGeneralViewController
        self.pageViewController.pushPage(vc, currentID: self.pageID)
    }
}

extension PageFirstViewController: Page {
    var pageID: Int { return 1 }
    
    var viewController: UIViewController {
        return self
    }
}
