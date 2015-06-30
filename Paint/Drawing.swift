////
////  Drawing.swift
////  Paint
////
////  Created by Christopher REECE on 2/11/15.
////  Copyright (c) 2015 Christopher Reece. All rights reserved.
////
//
//import Foundation
//
//struct Polyline
//{
//    var begPoint: PointF
//    var endPoint: PointF
//    var color: Color
//    var points: PointF
//}
//
//// regular point represented with ints. Don't want that
//struct PointF
//{
//    var x: Float
//    var y: Float
//}
//
//// typealias PointF = Float32Point
//
//struct Color
//{
//    var r: Float
//    var g: Float
//    var b: Float
//    var a: Float
//}
//
//
//class Drawing
//{
//    
////    init(fromFile: path: String)
////    {
////        
////    }
//    
//    private var _polyLines: [Polyline] = []
//
//    // define what the drawing is made of.
//    // polylines.. a set of points conected by lines.
//    // a drawing is an array of poly lines.
//    var polyLineCount: Int
//    {
//        return _polyLines.count
//    }
//    
//    func polyLineAtINdex(polylineIndex: Int) -> Polyline
//    {
//        return _polyLines[polylineIndex]
//    }
//    
//    // an array or set of polylines
//    
//    func appendPolylines(polyline: Polyline)
//    {
//        _polyLines.append(polyline)
//    }
//    
////    func writeToFile(path: String)
////    {
////        // monolithic object
////        // chose a root object NSArray, NSDict
////        var drawingArray: NSMutableArray = []
////        
////        // TODO: build up object graph
////        for polyline in _polyLines {
////            
////            let polylineColor: NSDictionary = [
////                "r": polyline.color.r,
////                "g": polyline.color.g,
////                "b": polyline.color.b,
////                "a": polyline.color.a]
////            
////            var polylinePoints: NSMutableArray = []
////            
////            for point in polyline.points
////            {
////                let pointDictionary: NSDictionary = ["x" : point.x, "y" : point.y]
////                polylinePoints.addObject(point)
////            }
////            
////            var polylineDictionary: NSDictionary = ["points": polyline.points, "color" : polyline.color]
////            drawingArray.addObject(polylineDictionary)
////        }
////        
////        drawingArray.writeToFile(path, atomically: true)
////        
////    }
//    
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
