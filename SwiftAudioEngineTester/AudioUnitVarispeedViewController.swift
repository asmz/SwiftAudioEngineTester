//
//  AudioUnitVarispeedController.swift
//  SwiftAudioEngineTester
//
//  Created by asmz on 2015/10/17.
//  Copyright © 2015年 asmz. All rights reserved.
//

import UIKit

class AudioUnitVarispeedViewController: UIViewController {

    var player = AudioEnginePlayer.sharedInstance

    @IBOutlet weak var PlayPauseButton : UIButton!

    @IBOutlet weak var audioUnitVarispeedRateLabel : UILabel!
    @IBOutlet weak var audioUnitVarispeedRateSlider : UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        resetDefaultValue()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateView() {
        if player.playing {
            PlayPauseButton.setTitle("Pause", for: .normal)
        } else {
            PlayPauseButton.setTitle("Play", for: .normal)
        }
    }

    @IBAction func playPauseAction() {
        if player.playing {
            player.pause()
        } else {
            player.play()
        }
        updateView()
    }

    @IBAction func resetDefaultValue() {
        audioUnitVarispeedRateSlider.value = 1.0

        chahgeAudioUnitVarispeedRate()
    }

    @IBAction func chahgeAudioUnitVarispeedRate() {
        player.audioUnitVarispeed.rate = audioUnitVarispeedRateSlider.value
        audioUnitVarispeedRateLabel.text = String(format: "%.1f", audioUnitVarispeedRateSlider.value)
    }
}

