//
//  UnderlinedTextField.swift
//  
//
//  Created by Sepand Yadollahifar on 7/4/18.
//  Copyright © 2018 3p. All rights reserved.
//

import UIKit

@IBDesignable
class UnderlinedTextField: UITextField {

    
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.backgroundColor = UIColor.clear
        //self.backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    @IBInspectable var UnderlineColor: UIColor = UIColor.lightGray
    
    override func draw(_ rect: CGRect) {
        path = UIBezierPath()
        
        // Specify the point that the path should start get drawn.
        path.move(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        self.borderStyle = .none
        
        UnderlineColor.setStroke()
        path.stroke()
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
