//
//  PageViewController.swift
//  UIKitPractice
//
//  Created by yuki.yoshioka on 2019/06/28.
//  Copyright © 2019 rikusouda. All rights reserved.
//

import Foundation
import UIKit

protocol Page {
    var pageID: Int { get }
    var viewController: UIViewController { get }
}

class PageViewController: UIPageViewController {
    var pages: [Page] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let firstPage = PageFirstViewController.create(parent: self)
        let secondPage = PageGeneralViewController.create(pageID: 2, parent: self, name: "PageSecondViewController")
        let thirdPage = PageGeneralViewController.create(pageID: 3, parent: self, name: "PageThirdViewController")
        let fourthPage = PageGeneralViewController.create(pageID: 4, parent: self, name: "PageFourthViewController")
        self.pages = [firstPage, secondPage, thirdPage, fourthPage]
        self.setViewControllers([secondPage], direction: .forward, animated: false, completion: nil)
        
        self.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func pushPage(_ page: Page, currentID: Int) {
        if !self.pages.contains {  $0.pageID == page.pageID } {
            if let index = self.pages.firstIndex(where: { $0.pageID == currentID }) {
                self.pages.insert(page, at: index + 1)
            }
        }
        
        let vc = page.viewController
        self.setViewControllers([vc], direction: .forward, animated: true) { (finished) in
            if !finished {
                return
            }
        }
    }
    
    @IBAction func closeButtonTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let page = viewController as? Page else { return nil }
        if self != pageViewController { return nil }
        guard let index = self.pages.firstIndex(where: { $0.pageID == page.pageID }) else { return nil }
        
        let newIndex = index - 1
        if newIndex < 0 { return nil }
        if self.pages.count <= newIndex { return nil }
        return self.pages[newIndex].viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let page = viewController as? Page else { return nil }
        if self != pageViewController { return nil }
        guard let index = self.pages.firstIndex(where: { $0.pageID == page.pageID }) else { return nil }
        
        let newIndex = index + 1
        if self.pages.count <= newIndex { return nil }
        return self.pages[newIndex].viewController
    }
    
}
