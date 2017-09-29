//
//  ScrollViewController.swift
//  UIKitPractice
//
//  Created by Yuki Yoshioka on 2017/08/20.
//  Copyright © 2017年 rikusouda. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func loadView() {
        let sv = UIScrollView(frame: UIScreen.main.bounds)
        sv.backgroundColor = UIColor.white
        self.view = sv
        self.scrollView = sv
        
        var y: CGFloat = 10
        for i in 0...30 {
            let label = UILabel()
            label.text = "Label \(i)"
            label.sizeToFit()
            var f = label.frame
            f.origin = CGPoint(x: 10, y: y)
            label.frame = f
            sv.addSubview(label)
            y += label.bounds.size.height + 10
        }
        var sz = sv.bounds.size
        sz.height = y
        sv.contentSize = sz
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func didTapIsBottomButton(_ sender: Any) {
        let isBottom = self.scrollView.contentSize.height <= self.scrollView.contentOffset.y + self.scrollView.bounds.size.height
        
        let alert = UIAlertController(title: isBottom ? "Bottom" : "Not bottom", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
    
}

