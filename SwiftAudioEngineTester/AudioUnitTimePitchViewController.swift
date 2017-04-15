//
//  AudioUnitTimePitchController.swift
//  SwiftAudioEngineTester
//
//  Created by asmz on 2015/10/17.
//  Copyright © 2015年 asmz. All rights reserved.
//

import UIKit

class AudioUnitTimePitchViewController: UIViewController {

    var player = AudioEnginePlayer.sharedInstance

    @IBOutlet weak var PlayPauseButton : UIButton!

    @IBOutlet weak var audioUnitTimePitchOverlapLabel : UILabel!
    @IBOutlet weak var audioUnitTimePitchOverlapSlider : UISlider!
    @IBOutlet weak var audioUnitTimePitchPitchLabel : UILabel!
    @IBOutlet weak var audioUnitTimePitchPitchSlider : UISlider!
    @IBOutlet weak var audioUnitTimePitchRateLabel : UILabel!
    @IBOutlet weak var audioUnitTimePitchRateSlider : UISlider!

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
        audioUnitTimePitchOverlapSlider.value = 8.0
        audioUnitTimePitchPitchSlider.value = 1.0
        audioUnitTimePitchRateSlider.value = 1.0

        changeAudioUnitTimePitchOverlap()
        changeAudioUnitTimePitchPitch()
        changeAudioUnitTimePitchRate()
    }

    @IBAction func changeAudioUnitTimePitchOverlap() {
        player.audioUnitTimePitch.overlap = audioUnitTimePitchOverlapSlider.value
        audioUnitTimePitchOverlapLabel.text = String(format: "%.1f", audioUnitTimePitchOverlapSlider.value)
    }

    @IBAction func changeAudioUnitTimePitchPitch() {
        player.audioUnitTimePitch.pitch = audioUnitTimePitchPitchSlider.value
        audioUnitTimePitchPitchLabel.text = String(format: "%.1f", audioUnitTimePitchPitchSlider.value)
    }

    @IBAction func changeAudioUnitTimePitchRate() {
        player.audioUnitTimePitch.rate = audioUnitTimePitchRateSlider.value
        audioUnitTimePitchRateLabel.text = String(format: "%.1f", audioUnitTimePitchRateSlider.value)
    }
}

