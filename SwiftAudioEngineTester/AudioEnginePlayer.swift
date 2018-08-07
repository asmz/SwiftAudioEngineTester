//
//  AudioEnginePlayer.swift
//  SwiftAudioEngineSample
//
//  Created by asmz on 2015/10/17.
//  Copyright © 2015年 asmz. All rights reserved.
//

import AVFoundation

class AudioEnginePlayer {

    static let sharedInstance = AudioEnginePlayer()

    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioUnitTimePitch: AVAudioUnitTimePitch!
    var audioUnitVarispeed: AVAudioUnitVarispeed!
    var audioUnitDelay: AVAudioUnitDelay!
    var audioUnitDistortion: AVAudioUnitDistortion!

    var playing: Bool {
        get {
            return audioPlayerNode != nil && audioPlayerNode.isPlaying
        }
    }

    init() {
        do {
            audioEngine = AVAudioEngine()

            // Prepare AVAudioFile
            let url = URL(string: Bundle.main.path(forResource: "sample", ofType: "mp3")!)
            audioFile = try AVAudioFile(forReading: url!)

            // Prepare AVAudioPlayerNode
            audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attach(audioPlayerNode)

            // Prepare AVAudioUnitTimePitch
            audioUnitTimePitch = AVAudioUnitTimePitch()
            audioEngine.attach(audioUnitTimePitch)

            // Prepare AVAudioUnitVarispeed
            audioUnitVarispeed = AVAudioUnitVarispeed()
            audioEngine.attach(audioUnitVarispeed)

            // Prepare AVAudioUnitDelay
            audioUnitDelay = AVAudioUnitDelay()
            audioEngine.attach(audioUnitDelay)
            audioUnitDelay.wetDryMix = 0

            // Prepare AVAudioUnitDistortion
            audioUnitDistortion = AVAudioUnitDistortion()
            audioEngine.attach(audioUnitDistortion)
            audioUnitDistortion.wetDryMix = 0

            // Connect Nodes
            audioEngine.connect(audioPlayerNode, to: audioUnitTimePitch, format: audioFile.processingFormat)
            audioEngine.connect(audioUnitTimePitch, to: audioUnitVarispeed, format: audioFile.processingFormat)
            audioEngine.connect(audioUnitVarispeed, to: audioUnitDelay, format: audioFile.processingFormat)
            audioEngine.connect(audioUnitDelay, to: audioUnitDistortion, format: audioFile.processingFormat)
            audioEngine.connect(audioUnitDistortion, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)

            // Start Engine
            audioEngine.prepare()
        } catch {
            fatalError("AudioEnginePlayer initialize error.")
        }
    }

    func play() {
        try! audioEngine.start()
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: {
            self.play()
        });
        audioPlayerNode.play()
    }

    func pause() {
        audioEngine.pause()
        audioPlayerNode.pause()
    }
}
