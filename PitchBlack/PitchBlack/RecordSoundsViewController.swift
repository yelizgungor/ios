//
//  ViewController.swift
//  PitchBlack
//
//  Created by Yeliz Güngör on 2016-11-07.
//  Copyright © 2016 Yeliz Güngör. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    @IBOutlet weak var recordLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!

    @IBOutlet weak var stopBtton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nb.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        stopBtton.isEnabled = false
    }

   
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished saving recording")
        if(flag){
            self.performSegue(withIdentifier: "stopRecording", sender:audioRecorder.url)
        }
        else{
            print("Saving of record failed")
        }
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        recordLabel.text = "Recording..."
        recordButton.isEnabled = false
        stopBtton.isEnabled=true
        
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
    
    @IBAction func stopAudio(_ sender: Any) {
        stopBtton.isEnabled = false
        recordButton.isEnabled = true
        recordLabel.text = "Tab to Recorded..."
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}

