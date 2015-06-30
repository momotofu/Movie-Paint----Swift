//
//  PaintView.swift
//  Paint
//
//  Created by Christopher REECE on 2/11/15.
//  Copyright (c) 2015 Christopher Reece. All rights reserved.
//

import UIKit

class PaintView: UIView, playButtonDelegate
{
    // segmentation between the view and the model
//    class var sharedInstance: LineStore
//    {
//        
//        struct Static {
//            
//            
//            static var instance: LineStore?
//            static var token: dispatch_once_t = 0
//        }
//        
//        dispatch_once(&Static.token) {
//            
//            Static.instance = LineStore()
//        }
//        
//        return Static.instance!
//    }
    
    struct Counter {
        
        static var count: Int = 0
        
    }
    
    private var _isPlaying: Bool = false
    private var _isScrubbing: Bool = false
    private var _completion: Float = 0.0
    private var _iterationCount: NSTimeInterval = 0.0
    private var _currentColor: UIColor = UIColor.redColor()
    private var _currentColors: [UIColor] = [UIColor.redColor(), UIColor.redColor(), UIColor.redColor(), UIColor.redColor(), UIColor.redColor(), UIColor.redColor()]
    private var _numberOfTouches: Int = 0
    
    private var _firstPoints: [NSValue: CGPoint] = [:]
    

    private var _multiEnabled: Bool = false
    
    // point to optional slider
    private var _slider: UISlider?
    
    // movie length
    let length: Float = 10.0
    
    
    // delcare a pointer to a button
    var playButton = UIButton(frame: CGRectZero)
    
    var firstPoint: CGPoint = CGPointMake(0.0, 0.0)
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if let touch = touches.first as? UITouch
        {
            for touch: AnyObject in touches {
                
                
                let location = touch.locationInView(self)
                
                let key = NSValue(nonretainedObject: touch)
                _firstPoints[key] = location
                
                println("number of touches \(touches.count)")
            }
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if let touch = touches.first as? UITouch
        {
            for touch: AnyObject in touches {
                
                let location = touch.locationInView(self)
                
                println("location of touch: \(location)")
                
                
                let key = NSValue(nonretainedObject: touch)
                let lastPoint = _firstPoints[key]
                
                var line = Polyline(begPoint: lastPoint!, endPoint: location, color: _currentColor)
                
                if _multiEnabled {
                    
                    let count: UInt32 = UInt32(touches.count)
                    
                    let randomIndex = arc4random_uniform(count) + 1
                    
                    _numberOfTouches = touches.count
                    line = Polyline(begPoint: lastPoint!, endPoint: location, color: _currentColors[Int(randomIndex)])
                } else {
                    line = Polyline(begPoint: lastPoint!, endPoint: location, color: _currentColor)
                }
                _firstPoints[key] = location
                
                LineStore.sharedInstance.addPolyLine(line)
            }
            
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, bounds)

        let polylines = LineStore.sharedInstance.polylines()
        
        if _isScrubbing {
            
            // get the percent of the scrubber
            // get that percent of lines drawn
            let percentToDraw = _slider!.value / length

            // get total number of lines
            let totalLines = Float(LineStore.sharedInstance.polyLineCount())
            let numberOfLines = Int(round(Float(totalLines * percentToDraw)))
            
            
            for i in 0..<numberOfLines {
                
                let line = polylines[i]
                let path = UIBezierPath()
                path.lineCapStyle = kCGLineCapRound
                path.lineWidth = 10
                path.moveToPoint(line.begPoint)
                path.addLineToPoint(line.endPoint)
                line.color.setStroke()
                path.stroke()
            }
            
            println("number of lines to draw: \(round(Float(totalLines) * percentToDraw)), percent: \(percentToDraw), number of lines: \(totalLines)")
            
        } else {
            // what is a leaf node
        
            for line in polylines {
                
                line.color.setStroke()
                let path = UIBezierPath()
                path.lineCapStyle = kCGLineCapRound
                path.lineWidth = 10
                path.moveToPoint(line.begPoint)
                path.addLineToPoint(line.endPoint)
                path.stroke()
            }
            
        }
       
    

    }
    
    init()
    {
        super.init(frame: CGRectZero)
        backgroundColor = UIColor.clearColor()
        multipleTouchEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        multipleTouchEnabled = true
    }
    
    
    func play(sender: UIButton)
    {
//        _isPlaying = true
//        self.userInteractionEnabled = false
//        

        // find out how many lines are in the array
        let lineCount =  LineStore.sharedInstance.polyLineCount()
        _iterationCount = NSTimeInterval(length / Float(lineCount))
        
        let runLoop = NSRunLoop.currentRunLoop()
        let timer = NSTimer(timeInterval: _iterationCount, target: self, selector: "increment:", userInfo: nil, repeats: true)
        runLoop.addTimer(timer, forMode: NSDefaultRunLoopMode)
        userInteractionEnabled = false
    }
    
    func increment(sender: NSTimer)
    {
        
        let sliderValue = Float(_slider!.value)
        let icount = Float(_iterationCount)
        var newValue: Float { return sliderValue + icount }
        _slider!.setValue(newValue, animated: true)
        _slider!.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        
        let percentDrawn = sliderValue / Float(length)
        
        if percentDrawn % 2 >= 1.0 {
            
            sender.invalidate()
            userInteractionEnabled = true
            _slider!.value = 0.0
            _isScrubbing = false
        
        }
        
    }
    
    func sliderIncrement(sender: UISlider)
    {
       
        _isScrubbing = true
        _slider = sender
        let lineCount = LineStore.sharedInstance.polyLineCount()
        if lineCount == 0 {
            return
        }
        _iterationCount = NSTimeInterval(length / Float(lineCount))
        sender.maximumValue = Float(_iterationCount) * Float(lineCount)
        sender.minimumValue = 0.0
        setNeedsDisplay()
        println("scrubber's value: \(sender.value)")
       
    }
    
    func addScrubber(slider: UISlider)
    {
        _slider = slider
    }
    
    func sliderStopped(sender: UISlider)
    {
        //_isScrubbing = false
       // _slider = nil
       
    }
    
    func setColor(sender: UIButton)
    {
        if _multiEnabled {
            
            let index: Int = Counter.count
            println("index =  \(index)")
            _currentColors[index] = sender.color
            
            if Counter.count >= _numberOfTouches {
                
                Counter.count = 0
            } else {
                
                Counter.count++
            }
        } else {
            
            _currentColor = sender.color
        }
       
    }
    
    func enableMultiColor(sender: UIButton)
    {
        
        if _multiEnabled {
            
            sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            
            _multiEnabled = false
            println("enable being called")
            
        } else {
            println("enable true being called")
            _multiEnabled = true
            sender.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        }
    }

    // push pop generics! Boo ya --- they don't work :/
    func push<T>(item: T, var array: [T])
    {
        array.append(item)
    }
    
    func pop<T>(var array: [T]) -> T
    {
        var lastItem: T
        lastItem = array.last!
        array.removeLast()
        
        return lastItem
    }
}
