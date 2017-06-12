//
//  ViewController.swift
//  FaceIt
//
//  Created by Parankush Bhardwaj on 6/12/17.
//  Copyright © 2017 Parankush Bhardwaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            updateUI() }
    }
    

    
    var expression = FacialExpression(eyes: .open, mouth: .frown) {
        didSet {
            updateUI() }
    }
    
   
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
    
    
    private let mouthCurvatures =
        [FacialExpression.Mouth.grin:0.5,.frown:-1.0,.smile:1.0,.neutral:0.0,.smirk:-0.5]
    

}

