//
//  UIButtonExtenstion.swift
//  
//
//  Created by Sepand Yadollahifar on 10/4/18.
//  Copyright © 2018 Sepand Yadollahifar. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func underline() {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
