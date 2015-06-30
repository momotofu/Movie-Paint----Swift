//
//  ViewController.swift
//  Paint
//
//  Created by Christopher REECE on 2/11/15.
//  Copyright (c) 2015 Christopher Reece. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController
{
    var paintView: PaintView { return view as! PaintView }
    let showTools: Gear = Gear()
    private var _showToolsPressed = false
    
    // CGRects used for animations
    private var _toolRect: CGRect!
    private var _inverseRect: CGRect!
    private var _animationRect: CGRect!
    private var _paintTools: PaintTools?
    private var _buttonRect: CGRect!
    
    override func loadView()
    {
        view = PaintView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))

    }
    
    override func viewDidAppear(animated: Bool) {
        
        showTools.frame = _buttonRect
      
        showTools.addTarget(self, action: "showTools:", forControlEvents: UIControlEvents.TouchDown)
        paintView.addSubview(showTools)
        
        _paintTools = PaintTools(frame: _toolRect)
        _paintTools!.parent = paintView
        paintView.insertSubview(_paintTools!, belowSubview: showTools)
    }
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        _toolRect = CGRectMake(0.0, paintView.bounds.height + paintView.bounds.height / 8, paintView.bounds.width + 57, paintView.bounds.height / 8)
        
        _inverseRect = CGRectMake(0.0, paintView.bounds.width + paintView.bounds.width / 8, paintView.bounds.height + 57, paintView.bounds.width / 8)
        
        _animationRect = CGRectMake(0.0, paintView.bounds.height - paintView.bounds.height / 8, paintView.bounds.width, paintView.bounds.height / 8)

        _buttonRect = CGRectMake(paintView.bounds.height / 48, _animationRect.midY - paintView.bounds.height / 32, 32, 32)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // paint area / navigation controller / controlling a hiearchy
        
    }
    
    func showTools(sender: UIButton)
    {
        
        // TODO: find out how to remove the toolBar from the subviews w/o interrupting the dismissal animation
   
        // tools are popped onto screen
        if _showToolsPressed == false {

            UIView.animateWithDuration(0.45, animations: {() in self._paintTools!.frame = self._animationRect})
            showTools.isPressed = false
            showTools.setNeedsDisplay()
            
            _showToolsPressed = true
        
        // tools are popped off of screen
        } else if _showToolsPressed {

            
             UIView.animateWithDuration(0.45, animations: {() in self._paintTools!.frame = self._toolRect
             })
            
          //  _paintTools!.removeFromSuperview()
            
          //  _paintTools = nil
            showTools.isPressed = true
            showTools.setNeedsDisplay()
            
            _showToolsPressed = false
  
        }

    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        let transitionToWide = size.width > size.height
        let image = UIImage(named: transitionToWide ? "bg_wide" : "bg_tall")
        
        coordinator.animateAlongsideTransition({
            context in

            }, completion:{ context in
                LineStore.sharedInstance.convertPolylines(self.paintView)
        })
    }


}

















