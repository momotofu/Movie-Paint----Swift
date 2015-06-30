//
//  Gear.swift
//  Paint
//
//  Created by Christopher REECE on 2/23/15.
//  Copyright (c) 2015 Christopher Reece. All rights reserved.
//

import UIKit


class Gear: UIButton {
    
    var isPressed: Bool = false
    
    override init(frame: CGRect)
    {
        
        super.init(frame: frame)
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect)
    {
        let image = UIImage(named: "gear.png")?.CGImage
        let context: CGContext = UIGraphicsGetCurrentContext()
        if isPressed {
            
            println("gear rotated")
            
            let rotation = CGFloat(M_PI / 2)
            CGContextTranslateCTM(context, bounds.midX + 11, bounds.midY - 16)
            CGContextRotateCTM(context,
                rotation)
            CGContextDrawImage(context, CGRectMake(bounds.origin.x, bounds.origin.y, 32, 27), image)
            
        } else {
            
            println("gear rotated")

            CGContextDrawImage(context, CGRectMake(bounds.origin.x, bounds.origin.y, 32, 27), image)
        }

        
    }
}


/*
var colorPath: UIBezierPath?

UIGraphicsBeginImageContext(CGSizeMake(bounds.size.width, bounds.size.height))

for var i:CGFloat = 0; i < sectors; i++
{
colorPath = UIBezierPath(arcCenter: _center!, radius: _radius, startAngle:i * angle, endAngle:(i + 1) * angle, clockwise: true)

colorPath?.lineCapStyle = kCGLineCapRound
colorPath?.addLineToPoint(_center!)
colorPath?.closePath()

var currentColor = UIColor(hue: i / sectors, saturation: 1.0, brightness: 1.0, alpha: 1)
currentColor.setStroke()
currentColor.setFill()

colorPath?.stroke()

}


drawOutline()


let backgroundImg = UIGraphicsGetImageFromCurrentImageContext()

return backgroundImg
*/















