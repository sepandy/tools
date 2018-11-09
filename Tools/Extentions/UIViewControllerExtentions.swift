//
//  UIViewControllerExtentions.swift
//
//
//  Created by Sepand Yadollahifar on 9/27/18.
//  Copyright © 2018 Sepand Yadollahifar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail() {
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
}

// MARK: - Tap to hide the keyboard

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    
    class func displayActivityIndicator(onView : UIView) -> UIView {
        let activityIndicatorView = UIView.init(frame: onView.bounds)
        activityIndicatorView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = activityIndicatorView.center
        
        DispatchQueue.main.async {
            activityIndicatorView.addSubview(ai)
            onView.addSubview(activityIndicatorView)
        }
        
        return activityIndicatorView
    }
    
    class func removeActivityIndicator(activityIndicator :UIView) {
        DispatchQueue.main.async {
            activityIndicator.removeFromSuperview()
        }
    }
}
