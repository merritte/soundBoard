//
//  NewSoundViewController.swift
//  soundBoard
//
//  Created by Merritte on 2/17/15.
//  Copyright (c) 2015 Merritte. All rights reserved.
//

import UIKit
import AVFoundation

class NewSoundViewController : UIViewController {

    required init(coder aDecoder: NSCoder) {
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        var pathComponents = [baseString, "MyAudio.m4a"]
        var audioURL = NSURL.fileURLWithPathComponents(pathComponents)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings: [NSObject : AnyObject] = Dictionary()
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        recordSettings[AVSampleRateKey] = 44100.0
        recordSettings[AVNumberOfChannelsKey] = 2
        
        self.audioRecorder = AVAudioRecorder(URL: audioURL, settings: recordSettings, error: nil)
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord()
       
        // Super init is below
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var soundTextField: UITextField!

    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder
    
    var previousViewController = SoundListViewController()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //Magic
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        //create sound object
        var sound = Sound()
        sound.name = self.soundTextField.text
        
        
        //add sounds to sounds array
        self.previousViewController.sounds.append(sound)
        
        // dismiss view controller
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func recordTapper(sender: AnyObject) {
        self.recordButton.setTitle("Finish Recording", forState: UIControlState.Normal)
    }
    
}
