//
//  IntractiveTransitionController.swift
//  UIKitPractice
//
//  Created by Yuki Yoshioka on 2017/11/12.
//  Copyright © 2017年 rikusouda. All rights reserved.
//

import Foundation

import UIKit

class IntractiveTransitionController: UIViewController {
    var dismissTransitioning: SlideVerticalDissmissTransitioning?
    
    @IBAction func didTapImage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "InteractiveTransition", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "IntractiveTransitionPreviewController") as! IntractiveTransitionPreviewController
        
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: {
            self.dismissTransitioning = SlideVerticalDissmissTransitioning(dissmissTransitionable: viewController)
        })
    }
}

extension IntractiveTransitionController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransitioning
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return dismissTransitioning?.getPercentageInteractiveTransition()
    }
}
