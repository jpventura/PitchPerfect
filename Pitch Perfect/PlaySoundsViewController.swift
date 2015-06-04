//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Joao Paulo Fernandes Ventura on 5/31/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioPlayer.delegate = self
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    func handler() -> Void {
    // do some audio work
    }

    @IBAction func playSlowAudio(sender: AnyObject) {
        fastButton.enabled = false
        chipmunkButton.enabled = false
        darthVaderButton.enabled = false

        // Play audio slooooowly here.... //
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()

    }

    @IBAction func playFastAudio(sender: AnyObject) {
        slowButton.enabled = false
        chipmunkButton.enabled = false
        darthVaderButton.enabled = false

        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()

    }

    @IBAction func playChipmunkAudio(sender: AnyObject) {
        slowButton.enabled = false
        fastButton.enabled = false
        darthVaderButton.enabled = false

        playAudioWithVariablePitch(1000)
    }

    @IBAction func playDarthVader(sender: AnyObject) {
        slowButton.enabled = false
        fastButton.enabled = false
        chipmunkButton.enabled = false

        playAudioWithVariablePitch(-1000)
    }

    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        

        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: enableAllButtons)

        audioEngine.startAndReturnError(nil)
        audioPlayerNode.
        audioPlayerNode.play()
    }

    @IBAction func stopAudio(sender: AnyObject) {
        enableAllButtons()
        audioPlayer.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        enableAllButtons()
    }

    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println(error.description)
    }
    
    func enableAllButtons() {
        slowButton.enabled = true
        fastButton.enabled = true
        chipmunkButton.enabled = true
        darthVaderButton.enabled = true
    }

}
