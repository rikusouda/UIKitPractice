//
//  PageGeneralViewController.swift
//  UIKitPractice
//
//  Created by yuki.yoshioka on 2019/06/28.
//  Copyright © 2019 rikusouda. All rights reserved.
//

import UIKit

class PageGeneralViewController: UIViewController {
    unowned private var pageViewController: PageViewController!
    var pageID: Int = 0
    
    static func create(pageID: Int, parent: PageViewController, name: String) -> PageGeneralViewController {
        let vc = UIStoryboard(name: "PageViewController",
                                      bundle: nil)
            .instantiateViewController(withIdentifier: name) as! PageGeneralViewController
        vc.pageViewController = parent
        vc.pageID = pageID
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
}

extension PageGeneralViewController: Page {
    var viewController: UIViewController {
        return self
    }
}
