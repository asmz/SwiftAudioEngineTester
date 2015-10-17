//
//  AudioEnginePlayer.swift
//  SwiftAudioEngineSample
//
//  Created by asmz on 2015/10/17.
//  Copyright © 2015年 asmz. All rights reserved.
//

import AVFoundation

class AudioEnginePlayer: NSObject {

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
            return audioPlayerNode != nil && audioPlayerNode.playing
        }
    }
    var audioUnitTimePitchOverlap: Float {
        get {
            return audioUnitTimePitch.overlap
        }
        set {
            audioUnitTimePitch.overlap = newValue
        }
    }
    var audioUnitTimePitchPitch: Float {
        get {
            return audioUnitTimePitch.pitch
        }
        set {
            audioUnitTimePitch.pitch = newValue
        }
    }
    var audioUnitTimePitchRate: Float {
        get {
            return audioUnitTimePitch.rate
        }
        set {
            audioUnitTimePitch.rate = newValue
        }
    }
    var audioUnitVarispeedRate: Float {
        get {
            return audioUnitVarispeed.rate
        }
        set {
            audioUnitVarispeed.rate = newValue
        }
    }
    var audioUnitDelayDelayTime: NSTimeInterval {
        get {
            return audioUnitDelay.delayTime
        }
        set {
            audioUnitDelay.delayTime = newValue
        }
    }
    var audioUnitDelayFeedback: Float {
        get {
            return audioUnitDelay.feedback
        }
        set {
            audioUnitDelay.feedback = newValue
        }
    }
    var audioUnitDelayLowPassCutoff: Float {
        get {
            return audioUnitDelay.lowPassCutoff
        }
        set {
            audioUnitDelay.lowPassCutoff = newValue
        }
    }
    var audioUnitDelayWetDryMix: Float {
        get {
            return audioUnitDelay.wetDryMix
        }
        set {
            audioUnitDelay.wetDryMix = newValue
        }
    }
    var audioUnitDistortionPreGain: Float {
        get {
            return audioUnitDistortion.preGain
        }
        set {
            audioUnitDistortion.preGain = newValue
        }
    }
    var audioUnitDistortionWetDryMix: Float {
        get {
            return audioUnitDistortion.wetDryMix
        }
        set {
            audioUnitDistortion.wetDryMix = newValue
        }
    }

    override init() {
        super.init()

        do {
            audioEngine = AVAudioEngine()

            // Prepare AVAudioFile
            let url = NSURL(string: NSBundle.mainBundle().pathForResource("sample", ofType: "mp3")!)
            audioFile = try AVAudioFile(forReading: url!)
            print(audioFile.fileFormat.sampleRate)

            // Prepare AVAudioPlayerNode
            audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attachNode(audioPlayerNode)

            // Prepare AVAudioUnitTimePitch
            audioUnitTimePitch = AVAudioUnitTimePitch()
            audioEngine.attachNode(audioUnitTimePitch)

            // Prepare AVAudioUnitVarispeed
            audioUnitVarispeed = AVAudioUnitVarispeed()
            audioEngine.attachNode(audioUnitVarispeed)

            // Prepare AVAudioUnitDelay
            audioUnitDelay = AVAudioUnitDelay()
            audioEngine.attachNode(audioUnitDelay)
            audioUnitDelay.wetDryMix = 0

            // Prepare AVAudioUnitDistortion
            audioUnitDistortion = AVAudioUnitDistortion()
            audioEngine.attachNode(audioUnitDistortion)
            audioUnitDistortion.wetDryMix = 0

            // Connect Nodes
            audioEngine.connect(audioPlayerNode, to: audioUnitTimePitch, format: audioFile.processingFormat)
            audioEngine.connect(audioUnitTimePitch, to: audioUnitVarispeed, format: audioFile.processingFormat)
            audioEngine.connect(audioUnitVarispeed, to: audioUnitDelay, format: audioFile.processingFormat)
            audioEngine.connect(audioUnitDelay, to: audioUnitDistortion, format: audioFile.processingFormat)
            audioEngine.connect(audioUnitDistortion, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)

            // Start Engine
            try audioEngine.start()
        } catch {
            print("AudioEnginePlayer initialize error.")
        }
    }

    func play() {
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: {
            self.play()
        });
        audioPlayerNode.play()
    }

    func pause() {
        audioPlayerNode.pause()
    }

    func stop() {
        audioPlayerNode.stop()
    }

}