//
//  AudioUnitDistortionViewController.swift
//  SwiftAudioEngineTester
//
//  Created by asmz on 2015/10/17.
//  Copyright © 2015年 asmz. All rights reserved.
//

import UIKit

class AudioUnitDistortionViewController: UIViewController {

    var player = AudioEnginePlayer.sharedInstance

    @IBOutlet weak var PlayPauseButton : UIButton!

    @IBOutlet weak var audioUnitDistortionPreGainLabel : UILabel!
    @IBOutlet weak var audioUnitDistortionPreGainSlider : UISlider!
    @IBOutlet weak var audioUnitDistortionWetDryMixLabel : UILabel!
    @IBOutlet weak var audioUnitDistortionWetDryMixSlider : UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        resetDefaultValue()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateView() {
        if player.playing {
            PlayPauseButton.setTitle("Pause", forState: .Normal)
        } else {
            PlayPauseButton.setTitle("Play", forState: .Normal)
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
        audioUnitDistortionPreGainSlider.value = -6
        audioUnitDistortionWetDryMixSlider.value = 0

        chahgeAudioUnitDistortionPreGain()
        chahgeAudioUnitDistortionWetDryMix()
    }

    @IBAction func chahgeAudioUnitDistortionPreGain() {
        player.audioUnitDistortionPreGain = audioUnitDistortionPreGainSlider.value
        audioUnitDistortionPreGainLabel.text = String(format: "%.1f", audioUnitDistortionPreGainSlider.value)
    }

    @IBAction func chahgeAudioUnitDistortionWetDryMix() {
        player.audioUnitDistortionWetDryMix = audioUnitDistortionWetDryMixSlider.value
        audioUnitDistortionWetDryMixLabel.text = String(format: "%.1f", audioUnitDistortionWetDryMixSlider.value)
    }
}

