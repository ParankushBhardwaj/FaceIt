//
//  BlinkingViewController.swift
//  FaceIt
//
//  Created by Parankush Bhardwaj on 6/19/17.
//  Copyright © 2017 Parankush Bhardwaj. All rights reserved.
//

import UIKit

class BlinkingViewController: FaceViewController
{

    //boolean function that determines wheter the face will blink
    var blinking = false {
        didSet {
            blinkIfNeeded()
        }
    }
    
    //struct holds the time durations for eyes when blinking, drand 48 is random double from 0.0 - 1.0
    private struct BlinkRate {
        static let closedDuration: TimeInterval = drand48() //0.4
        static let openDuration: TimeInterval = drand48() + 2.0 //2.5

    }
    
    
    private func blinkIfNeeded() {
        
        
        if blinking {   //if blinking (face appeared on screen)
            
            faceView.eyesOpen = false   //close eyes and then schedule timer based on struct, don't repeat.
            Timer.scheduledTimer(withTimeInterval: BlinkRate.closedDuration, repeats: false) { [weak self] timer in
                
                self?.faceView.eyesOpen = true  //now open eyes for duration based off of blinkrate struct
                Timer.scheduledTimer(withTimeInterval: BlinkRate.openDuration, repeats: false) { [weak self] timer in
                    
                    self?.blinkIfNeeded()  //now call back blink if needed to open eyes back up.
                }
            }
        }
    }
    
    
    //only start blinking once view is visible
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }
    
    //stop blinking once view is invisible
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        blinking = false
    }
    
}

