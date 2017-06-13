//
//  ViewController.swift
//  FaceIt
//
//  Created by Parankush Bhardwaj on 6/12/17.
//  Copyright © 2017 Parankush Bhardwaj. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            
            //handle pinch - affects scale of image.
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
            
            //tap for eyes.
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            
            
            //swipe up on the line to make face sad.
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseSaddness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            
            
            //swipe down for happy
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            
            
            updateUI() }
    }
    


    
    var expression = FacialExpression(eyes: .open, mouth: .frown) {
        didSet {
            updateUI() }
    }
    
    private let mouthCurvatures =
        [FacialExpression.Mouth.grin:0.5,.frown:-1.0,.smile:1.0,.neutral:0.0,.smirk:-0.5]

    
   
    //below func makes the model match the UI
    private func updateUI() {
        
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    
    
    func increaseSaddness()
    {
        expression = expression.sadder
    }
    
    
    func increaseHappiness()
    {
        expression = expression.happier
    }
    
    
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }

}

