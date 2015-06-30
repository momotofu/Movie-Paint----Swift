//
//  MovieTools.swift
//  Paint
//
//  Created by Christopher REECE on 2/19/15.
//  Copyright (c) 2015 Christopher Reece. All rights reserved.
//

import UIKit

protocol MovieToolsDelegate: class {
    
    func enableScrolling()
    
}

class MovieTools: UIView {
    
    weak var Delegate: MovieToolsDelegate?
    weak var paintView: PaintView?
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, buttonDelegate: PaintView) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.99, green: 0.97, blue: 0.97, alpha: 1.0)
        
        let cubHeight: CGFloat = 50
        let buttonFrame = CGRectMake(60, bounds.midY - cubHeight / 2, 40, 44)

        let testCube = UIButton(frame: buttonFrame)
        testCube.backgroundColor = UIColor(patternImage: UIImage(named: "brush.png")!)
        testCube.addTarget(self, action: "dismiss:", forControlEvents: UIControlEvents.TouchDown)
        addSubview(testCube)
        
        let scrubber = UISlider(frame: CGRectMake(testCube.frame.origin.x + cubHeight * 1.2, bounds.midY - bounds.height / 2, bounds.width - bounds.width * 0.6, bounds.height))
        let paintView = superview?.superview?.superview
        scrubber.addTarget(paintView, action: "sliderIncrement:", forControlEvents: UIControlEvents.ValueChanged)
        scrubber.addTarget(paintView, action: "sliderStopped:", forControlEvents: UIControlEvents.TouchUpInside)
        scrubber.continuous = true
        addSubview(scrubber)
        
        let playButton = PlayButton(frame: CGRectMake(scrubber.frame.origin.x + scrubber.frame.width * 1.1, buttonFrame.origin.y + 10, 44, 32))
        playButton.backgroundColor =  UIColor(patternImage: UIImage(named: "play.png")!)
        playButton.Delegate = buttonDelegate
        playButton.addTarget(self, action: "playMovie:", forControlEvents: UIControlEvents.TouchDown)
        
        playButton.Delegate?.addScrubber(scrubber)
        addSubview(playButton)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    func dismiss(sender: UIButton)
    {
        let newFrame = CGRectMake(bounds.origin.x, bounds.origin.y + bounds.height, bounds.width, bounds.height)
        UIView.animateWithDuration(0.45, animations: {() in self.frame = newFrame
        })
        
        Delegate?.enableScrolling()
    }
    
    func playMovie(sender: PlayButton)
    {
        sender.Delegate?.play(sender)
    }

    
}
