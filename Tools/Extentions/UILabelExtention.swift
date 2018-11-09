//
//  UILabelExtention.swift
//  
//
//  Created by Sepand Yadollahifar on 10/6/18.
//  Copyright © 2018 Sepand Yadollahifar. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
