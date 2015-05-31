//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Joao Paulo Fernandes Ventura on 5/31/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
    }

    @IBAction func playSlowAudio(sender: AnyObject) {
        // Play audio slooooowly here....
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
