//
//  PlayButton.swift
//  Paint
//
//  Created by Christopher REECE on 2/21/15.
//  Copyright (c) 2015 Christopher Reece. All rights reserved.
//

import UIKit

protocol playButtonDelegate: class {
    
    func play(sender: UIButton)
    func increment(sender: NSTimer)
    func addScrubber(slider: UISlider)
}

class PlayButton: UIButton {
    
    weak var Delegate: playButtonDelegate?
    
    
}


