//
//  PlaceHolderTextView.swift
//  
//
//  Created by Sepand Yadollahifar on 7/9/18.
//  Copyright © 2018 3p. All rights reserved.
//

import UIKit

@IBDesignable
class PlaceHolderTextView: UITextView {
  
    @IBInspectable var placeholder: String = "" {
        didSet{
            updatePlaceHolder()
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = UIColor.gray {
        didSet {
            updatePlaceHolder()
        }
    }
    
    private var originalTextColor = UIColor.darkText
    private var originalText: String = ""
    
    public func updatePlaceHolder() {
    
        if self.text == "" || self.text == placeholder  {
    
            self.text = placeholder
            self.textColor = placeholderColor
            if let color = self.textColor {
                
                self.originalTextColor = color
            }
            
            self.originalText = ""
        } else {
            self.textColor = self.originalTextColor
            self.originalText = self.text
        }
        
    }

    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.textColor = self.originalTextColor
        self.text = self.originalText
        return result
    }
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updatePlaceHolder()
        
        return result
    }
}
