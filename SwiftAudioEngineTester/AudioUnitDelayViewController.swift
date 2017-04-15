//
//  AudioUnitDelayViewController.swift
//  SwiftAudioEngineTester
//
//  Created by asmz on 2015/10/17.
//  Copyright © 2015年 asmz. All rights reserved.
//

import UIKit

class AudioUnitDelayViewController: UIViewController {

    var player = AudioEnginePlayer.sharedInstance

    @IBOutlet weak var PlayPauseButton : UIButton!

    @IBOutlet weak var audioUnitDelayDelayTimeLabel : UILabel!
    @IBOutlet weak var audioUnitDelayDelayTimeSlider : UISlider!
    @IBOutlet weak var audioUnitDelayFeedbackLabel : UILabel!
    @IBOutlet weak var audioUnitDelayFeedbackSlider : UISlider!
    @IBOutlet weak var audioUnitDelayLowPassCutoffLabel : UILabel!
    @IBOutlet weak var audioUnitDelayLowPassCutoffSlider : UISlider!
    @IBOutlet weak var audioUnitDelayWetDryMixLabel : UILabel!
    @IBOutlet weak var audioUnitDelayWetDryMixSlider : UISlider!

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
        audioUnitDelayDelayTimeSlider.value = 1.0
        audioUnitDelayFeedbackSlider.value = 50
        audioUnitDelayLowPassCutoffSlider.value = 15000
        audioUnitDelayWetDryMixSlider.value = 0

        chahgeAudioUnitDelayDelayTime()
        chahgeAudioUnitDelayFeedback()
        chahgeAudioUnitDelayLowPassCutoff()
        chahgeAudioUnitDelayWetDryMix()
    }

    @IBAction func chahgeAudioUnitDelayDelayTime() {
        player.audioUnitDelay.delayTime = Double(audioUnitDelayDelayTimeSlider.value)
        audioUnitDelayDelayTimeLabel.text = String(format: "%.1f", audioUnitDelayDelayTimeSlider.value)
    }

    @IBAction func chahgeAudioUnitDelayFeedback() {
        player.audioUnitDelay.feedback = audioUnitDelayFeedbackSlider.value
        audioUnitDelayFeedbackLabel.text = String(format: "%.1f", audioUnitDelayFeedbackSlider.value)
    }

    @IBAction func chahgeAudioUnitDelayLowPassCutoff() {
        player.audioUnitDelay.lowPassCutoff = audioUnitDelayLowPassCutoffSlider.value
        audioUnitDelayLowPassCutoffLabel.text = String(format: "%.1f", audioUnitDelayLowPassCutoffSlider.value)
    }

    @IBAction func chahgeAudioUnitDelayWetDryMix() {
        player.audioUnitDelay.wetDryMix = audioUnitDelayWetDryMixSlider.value
        audioUnitDelayWetDryMixLabel.text = String(format: "%.1f", audioUnitDelayWetDryMixSlider.value)
    }
}

