//
//  PlayRecordViewController.swift
//  SountPlayer
//
//  Created by Yeliz Güngör on 2016-11-10.
//  Copyright © 2016 Yeliz Güngör. All rights reserved.
//

import UIKit
import AVFoundation

class PlayRecordViewController: UIViewController {

    var recordedAudioURL : NSURL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    var changeRatePitchNode: AVAudioUnitTimePitch!

    
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAudio()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        playSound(rate: rateSlider.value/10)
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        print("Stop Audio Button Pressed")
        stopAudio()
    }
    
    @IBAction func playSoundForButtton(_ sender: UIButton) {
        print("Funny Sound Button Pressed")
        
        if sender.tag == 0{
            playSound(rate: rateSlider.value/10,pitch: 1000)
        }
        else{
            playSound(rate: rateSlider.value/10,pitch: -1000)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func rateValueChanged(_ sender: Any) {
        changeRatePitchNode.rate = rateSlider.value/10;
    }


}
