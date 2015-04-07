//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Theo on 2/9/15.
//  Copyright (c) 2015 pid. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer : AVAudioPlayer!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var audioTimePitch : AVAudioUnitTimePitch!
    var receivedAudio : RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        var filePath:NSURL = NSURL(fileURLWithPath: "/Users/theo/Courses/udacity/iOS/PitchPerfect/PitchPerfect/movie_quote.mp3")!
//        audioPlayer = AVAudioPlayer(contentsOfURL: filePath, error: nil)
//        audioPlayer.enableRate = true
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePath, error: nil)
        audioPlayer.enableRate = true
        
        // This is for funky sounds
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        audioTimePitch = AVAudioUnitTimePitch()
        audioTimePitch.pitch = 1000
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(audioTimePitch)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowPlayButton(sender: UIButton) {
        println("Slow play button pressed")
        audioPlayer.stop()
        audioPlayerNode.stop()
        audioPlayer.rate = 0.7
        audioPlayer.play()
    }
    
    
    @IBAction func fastPlayButton(sender: UIButton) {
        println("Fast play button pressed")
          audioPlayer.stop()
          audioPlayerNode.stop()
          audioPlayer.rate = 1.5
          audioPlayer.play()
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playFunkyAudioWithPitch(1000)
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playFunkyAudioWithPitch(-1000)
    }
    
    @IBAction func stopButton(sender: UIButton) {
        audioPlayer.stop()
        audioPlayerNode.stop()
    }
    
    
    func playFunkyAudioWithPitch(pitch : Float){
        
        audioPlayer.stop()
        audioPlayerNode.stop()
        //audioEngine.stop()
        //audioEngine.reset()
        
        let audioFile = AVAudioFile(forReading: receivedAudio.filePath, error: nil)
        let audioFormat = audioFile.processingFormat
        let audioFrameCount = UInt32(audioFile.length)
        //let audioFileBuffer = AVAudioPCMBuffer(PCMFormat: audioFormat, frameCapacity: audioFrameCount)
        
        audioTimePitch.pitch = pitch
        audioEngine.connect(audioPlayerNode, to: audioTimePitch, format: nil)
        audioEngine.connect(audioTimePitch, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
