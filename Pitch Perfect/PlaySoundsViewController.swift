//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Joao Paulo Fernandes Ventura on 5/31/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var echoPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        echoPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    @IBAction func playSlowAudio(sender: AnyObject) {
        self.stopAudio()
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }

    @IBAction func playFastAudio(sender: AnyObject) {
        self.stopAudio()
        audioPlayer.rate = 1.5
        audioPlayer.play()
    }

    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }

    @IBAction func playDarthVader(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }

    func playAudioWithVariablePitch(pitch: Float){
        self.stopAudio()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }

    
    @IBAction func playEcho(sender: AnyObject) {
        self.stopAudio()
        audioPlayer.play()
        let delay:NSTimeInterval = 0.200
        var playtime:NSTimeInterval
        playtime = echoPlayer.deviceCurrentTime + delay
        echoPlayer.volume = 0.3;
        echoPlayer.playAtTime(playtime)
    }

    @IBAction func playReverb(sender: AnyObject) {
        stopAudio()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        var changeReverbEffect = AVAudioUnitReverb()
        changeReverbEffect.loadFactoryPreset(.Cathedral)
        changeReverbEffect.wetDryMix = 61.80339887498949
        audioEngine.attachNode(changeReverbEffect)
        audioEngine.connect(audioPlayerNode, to: changeReverbEffect, format: nil)
        audioEngine.connect(changeReverbEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }

    @IBAction func stopAudio(sender: AnyObject) {
        self.stopAudio()
    }

    func stopAudio() {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        echoPlayer.stop()
        echoPlayer.currentTime = 0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
