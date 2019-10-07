//
//  IntractiveTransitionPreviewController.swift
//  UIKitPractice
//
//  Created by Yuki Yoshioka on 2017/11/12.
//  Copyright © 2017年 rikusouda. All rights reserved.
//

import UIKit

class IntractiveTransitionPreviewController: UIViewController {
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension IntractiveTransitionPreviewController: SlideVerticalDissmissTransitionable {

}
