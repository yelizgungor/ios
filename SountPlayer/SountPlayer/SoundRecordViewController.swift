//
//  ViewController.swift
//  SountPlayer
//
//  Created by Yeliz Güngör on 2016-11-09.
//  Copyright © 2016 Yeliz Güngör. All rights reserved.
//

import UIKit
import AVFoundation

class SoundRecordViewController: UIViewController,AVAudioRecorderDelegate {

  
  
    
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var timerView: UIView!
    
    var timer:Timer!
    var counter = 0
    var audioRecorder: AVAudioRecorder!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer()
        timerView.backgroundColor = UIColor.darkGray
        timerView.layer.cornerRadius = 10.0
        timerView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func recordSound(_ sender: UIButton) {
        if counter > 0{
            stopRecording()
            resetTimer()
            timer.invalidate()
            sender.setImage(UIImage(named: "Record"), for: .normal)
            
            
        }
        else{
            timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(SoundRecordViewController.updateCounter), userInfo: nil, repeats: true)
             sender.setImage(UIImage(named: "Recording"), for: .normal)
            startRecording()
        }
        
    }
    func updateCounter() {
        counter += 1
        if counter == 60 * 60{
            stopRecording()
            resetTimer()
        }
        else{
            setTimer(minute: Int(counter / 60) , second: counter % 60)
        }
    }
    func stopRecording(){
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)

    }
    func startRecording(){
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    func resetTimer(){
        setTimer(minute: 0,second: 0)
        counter = 0;
    }
    
    func setTimer(minute : Int, second:Int){
        if minute < 10 {
            minuteLabel.text = "0" + String(minute)
        }else{
            minuteLabel.text = String(minute)
        }
        if second < 10 {
            secondLabel.text = "0" + String(second)
        }
        else{
            secondLabel.text =  String(second)
        }
    }
    
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if(flag){
            self.performSegue(withIdentifier: "stopRecording", sender:audioRecorder.url)
        }
        else{
            print("Saving of record failed")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playRecordVC = segue.destination as! PlayRecordViewController
            let recordedAudioURL = sender as! NSURL
            playRecordVC.recordedAudioURL = recordedAudioURL
        }
    }
    


}

