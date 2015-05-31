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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            var filePathUrl = NSURL.fileURLWithPath(filePath)
            var audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
        } else {
            println("the filePath is empty")
        }
    }

    @IBAction func playSlowAudio(sender: AnyObject) {
        // Play audio slooooowly here....
        audioPlayer.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
