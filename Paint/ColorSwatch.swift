//
//  ColorSwatch.swift
//  Paint
//
//  Created by Christopher REECE on 2/23/15.
//  Copyright (c) 2015 Christopher Reece. All rights reserved.
//

import UIKit

class ColorSwatch: UIButton {
    
    // holds a color value
    // draws it's rect based on that color
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        let paintImage = UIImage(named: "ColorSwatch")
        paintImage!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
       

        setImage(paintImage, forState: UIControlState.Normal)
       
        tintColor = UIColor.redColor()


        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func drawRect(rect: CGRect) {
        

    }
}