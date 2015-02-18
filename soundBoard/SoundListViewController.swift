//
//  SoundListViewController.swift
//  soundBoard
//
//  Created by Merritte on 2/16/15.
//  Copyright (c) 2015 Merritte. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class SoundListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer = AVAudioPlayer()
    
    var sounds: [Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
                

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //do it...
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!

        var request = NSFetchRequest(entityName: "Sound")
        
        self.sounds = context.executeFetchRequest(request, error: nil)! as [Sound]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounds.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var sound = self.sounds[indexPath.row]
        var cell = UITableViewCell()
        cell.textLabel!.text = sound.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var sound = self.sounds[indexPath.row]
        
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        var pathComponents = [baseString, sound.url]
        var audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)
        
        self.audioPlayer = AVAudioPlayer(contentsOfURL: audioNSURL, error: nil)
        self.audioPlayer.play()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nextViewController = segue.destinationViewController as NewSoundViewController
        nextViewController.previousViewController = self
    }
    
}

