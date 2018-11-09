//
//  UITextFieldExtensions.swift
//  
//
//  Created by Sepand Yadollahifar on 6/13/18.
//  Copyright © 2018 3p. All rights reserved.
//

import UIKit

private var kAssociationKeyNextField: UInt8 = 0

extension UITextField {
    @IBOutlet var nextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UITextField
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}
