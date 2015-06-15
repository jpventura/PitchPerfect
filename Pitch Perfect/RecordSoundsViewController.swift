//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Joao Paulo Fernandes Ventura on 5/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        setButtonsHidden(true)
        recordButton.enabled = true
    }

    @IBAction func recordAudio(sender: AnyObject) {
        recordingInProgress.text = "recording"

        // Hide recording flow buttons, disable microphone button, and
        // (re)enable all other buttons except resume recording.
        setButtonsHidden(false)
        pauseButton.enabled = true
        stopButton.enabled = true
        playButton.enabled = false
        recordingInProgress.hidden = false
        recordButton.enabled = false

        // Record the user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)

        // Setup audio session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)

        // Initialize and prepare the recorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag) {
            if let title = recorder.url.lastPathComponent {
                recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: title)
                performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            }
        } else {
            println("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ("stopRecording" == segue.identifier) {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

    @IBAction func pauseAudio(sender: AnyObject) {
        recordingInProgress.text = "paused"
        pauseButton.enabled = false
        playButton.enabled = true
        audioRecorder.pause()
    }

    @IBAction func stopAudio(sender: AnyObject) {
        recordingInProgress.text = "tap to record"
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }

    @IBAction func restartToRecordAudio(sender: AnyObject) {
        recordingInProgress.text = "recording"
        pauseButton.enabled = true
        playButton.enabled = false
        audioRecorder.record()
    }

    func setButtonsHidden(hidden: Bool) {
        pauseButton.hidden = hidden
        stopButton.hidden = hidden
        playButton.hidden = hidden
    }

}
