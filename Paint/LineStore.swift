//
//  LineStore.swift
//  Paint
//
//  Created by Christopher REECE on 2/20/15.
//  Copyright (c) 2015 Christopher Reece. All rights reserved.
//

import UIKit

//
//func ==(lhs: Polyline, rhs: Polyline) -> Bool {
//    return lhs.key == rhs.key
//}

struct Polyline
{
    var begPoint: CGPoint
    var endPoint: CGPoint
    var color: UIColor
//    var key: String
    
    mutating func setPointBeginPoint(point: CGPoint)
    {
        begPoint = point
    }
    
    mutating func setPointEndingPoint(point: CGPoint)
    {
        endPoint = point
    }
}



class LineStore: NSObject {
    
    private var _evenOddRotate: Bool = true
    private var _convertedLines: [Polyline] = []
    private var _origonLines: [Polyline] = []
    
    struct standardizedLine
    {
        var beginPoint: PointF
        var endPoint: PointF
        private var _color: [String: Float]?
        var color: [String: Float] {
            get {
                return _color!
            }
        }
        
        mutating func setColor(red: Float, green: Float, blue: Float, alpha: Float)
        {
            _color = ["red" : red, "green" : green, "blue" : blue, "alpha" : alpha]
        }
    }
    
    struct PointF
    {
        var x: Float
        var y: Float
    }
    
    // an array of completed lines
    private var _standardLines = [standardizedLine]()
    private var _polylines: [Polyline] = []
    
    
    class var sharedInstance: LineStore
    {
        
        struct Static {
            
            
            static var instance: LineStore?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            
            Static.instance = LineStore()
        }
        
        return Static.instance!
    }
    
    func polylines() -> [Polyline]
    {
        return _polylines
    }
    
    func polyLineCount() -> Int
    {
        return _polylines.count
    }
    
    func addPolyLine(polyline: Polyline)
    {
        _polylines.append(polyline)
    }
    
    func polylineAtIndex(index: Int) -> Polyline
    {
        return _polylines[index]
    }
    
    // convert from PolyLine to a standardized line
    func convertAddPolyLine(polyLine: Polyline)
    {
        println(" first  \(polyLine.begPoint)")
        // convert poly line into a view independend coordinate system
        let endP = PointF(x: Float(polyLine.endPoint.x), y: Float(polyLine.endPoint.y))
        let begP = PointF(x: Float(polyLine.begPoint.x), y: Float(polyLine.begPoint.y))
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        polyLine.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var standardLine = standardizedLine(beginPoint: begP, endPoint: endP, _color: nil)
        standardLine.setColor(Float(red), green: Float(green), blue: Float(blue), alpha: Float(alpha))
        _standardLines.append(standardLine)
        println("second \(standardLine.beginPoint.x) : \(standardLine.endPoint.y)")

    }
    
    func polyLineAtIndex(index: Int, bounds: CGRect) -> Polyline
    {
        let width = Float(bounds.size.width)
        let height = Float(bounds.size.height)
        
        // get specified line
        let conversionLine = _standardLines[index]
        // convert properties back to polyline
        let endP = PointF(x: conversionLine.endPoint.x, y: conversionLine.endPoint.y)
        let begP = PointF(x: conversionLine.beginPoint.x, y: conversionLine.beginPoint.y)
        
        // create a CGFloat from new converted values
        let newEndP = CGPointMake(CGFloat(endP.x), CGFloat(endP.y))
        let newBegP = CGPointMake(CGFloat(begP.x), CGFloat(begP.y))
        
        // convert standardized values back to CGFloat
        let colors = conversionLine.color
        let r = CGFloat(colors["red"]!)
        let g = CGFloat(colors["green"]!)
        let b = CGFloat(colors["blue"]!)
        let a = CGFloat(colors["alpha"]!)
    
        
        // create a UIColor from standarline rgba values
        let color = UIColor(red: r, green: g, blue: b, alpha: a)
        
        // create new Polyline
        let polyline = Polyline(begPoint: newBegP, endPoint: newEndP, color: color)
        return polyline
    }
    
    func numberOfLines() -> Int
    {
        return _standardLines.count
    }
    
    func convertPolylines(view: UIView)
    {
        for i in 0..<_polylines.count
        {
            var line = _polylines[i]

            if _evenOddRotate {
                
                _origonLines.append(line)
                
                var newBegPoint = view.convertPoint(line.begPoint, fromCoordinateSpace: UIScreen.mainScreen().fixedCoordinateSpace)
                var newEndPoint = view.convertPoint(line.endPoint, fromCoordinateSpace: UIScreen.mainScreen().fixedCoordinateSpace)
                
                println("convert being called from")
                line.begPoint = newBegPoint
                line.endPoint = newEndPoint
                _polylines[i] = line
                
            } else {
                
      
            }
            
           
          
            //            newLine.begPoint = convertPoint(newLine.begPoint, fromCoordinateSpace: UIScreen.mainScreen().fixedCoordinateSpace)
            //            newLine.endPoint = convertPoint(newLine.endPoint, fromCoordinateSpace: UIScreen.mainScreen().fixedCoordinateSpace)

        }
        
        if _evenOddRotate {
            _evenOddRotate = false
        } else {
            _polylines = _origonLines
            _origonLines = []
            
            _evenOddRotate = true
        }
        view.setNeedsDisplay()
        return
    }
    
}































