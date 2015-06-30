//
//  PaintTools.swift
//  Paint
//
//  Created by Christopher REECE on 2/18/15.
//  Copyright (c) 2015 Christopher Reece. All rights reserved.
//

import UIKit

extension UIButton {
    
    var color: UIColor {return self.tintColor! }
}


// declare swatch protocol
protocol PaintToolsDelegate: class {
    
    func enableUserInteraction()
    
}

class PaintTools: UIScrollView, MovieToolsDelegate {
    
    weak var parent: PaintView?
    private var _colorArray: [UIColor] = []

    
  
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        let cubHeight: CGFloat = 50.0
        let movieButtonFrame = CGRectMake(60, bounds.midY - cubHeight / 2, 36, 44)
        
        let myContentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        let movieButton = UIButton(frame: movieButtonFrame)
       
        movieButton.addTarget(self, action: "presentMovieTools:", forControlEvents: UIControlEvents.TouchDown)
        movieButton.backgroundColor = UIColor(patternImage: UIImage(named: "viewMode")!)
        
        let multiButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        multiButton.frame = movieButtonFrame
        multiButton.setTitle("MULTI", forState: UIControlState.Normal)
        multiButton.addTarget(parent, action: "enableMultiColor:", forControlEvents: UIControlEvents.TouchDown)
        multiButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        multiButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)

        
        backgroundColor = UIColor(red: 0.99, green: 0.97, blue: 0.97, alpha: 1.0)
        contentSize = CGSizeMake(frame.size.width * 3, frame.size.height)
        contentInset = myContentInset
        scrollEnabled = true
        showsHorizontalScrollIndicator = false
        
        // create an array of colors
        _colorArray.append(UIColor.blueColor())
        _colorArray.append(UIColor.cyanColor())
        _colorArray.append(UIColor.greenColor())
        _colorArray.append(UIColor(red: 0.50, green: 0.90, blue: 0.60, alpha: 1.0))
        _colorArray.append(UIColor.yellowColor())
        _colorArray.append(UIColor.orangeColor())
        _colorArray.append(UIColor.magentaColor())
        _colorArray.append(UIColor.redColor())
        _colorArray.append(UIColor.purpleColor())
        _colorArray.append(UIColor(red: 0.60, green: 0.40, blue: 0.60, alpha: 1.0))
        _colorArray.append(UIColor.brownColor())
        _colorArray.append(UIColor.darkGrayColor())
        _colorArray.append(UIColor.grayColor())
        _colorArray.append(UIColor.lightGrayColor())
        _colorArray.append(UIColor.blackColor())
        _colorArray.append(UIColor.whiteColor())

        let paintImage = UIImage(named: "ColorSwatch")
        paintImage!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        for i in 1...18 {
            
            if i == 1 {
                
                addSubview(movieButton)
            } else if i == 2 {
                
                multiButton.frame.origin.x = CGFloat(i) * 52.5
                multiButton.frame.size.width = 60
                addSubview(multiButton)
            }
            else {

                let paintSwatch: UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
                paintSwatch.frame = CGRectMake(CGFloat(i * 60), bounds.midY - cubHeight / 2, 44, 44)

                paintSwatch.setImage(paintImage, forState: UIControlState.Normal)
                paintSwatch.tintColor = _colorArray[i - 3]
                paintSwatch.addTarget(parent, action: "setColor:", forControlEvents: UIControlEvents.TouchDown)
                
                addSubview(paintSwatch)
            }

        
        }


    }
    
    init()
    {
        super.init(frame: CGRectZero)
        backgroundColor = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func presentMovieTools(sender: UIButton)
    {
        let paintView = superview as! PaintView
        let movieTools = MovieTools(frame: bounds, buttonDelegate: paintView)
        
        
        movieTools.frame.origin.y += bounds.size.height
        movieTools.Delegate = self
        scrollEnabled = false
        
        addSubview(movieTools)
        
        UIView.animateWithDuration(0.45, animations: {() in movieTools.frame = self.bounds
        })

        println("button fired")
        
    }
    
    func enableScrolling()
    {
        scrollEnabled = true
    }

}

