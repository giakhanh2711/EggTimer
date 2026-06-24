//
//  ViewController.swift
//  EggTimer
//
//  Created by Le Gia Khanh on 18/6/26.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes : [String : Int] = ["Soft": 5, "Medium": 7, "Hard": 12]
    let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    
    var secondsPassed: Int = 0
    var secondsTotal: Int = 0
    
    var timer: Timer = Timer()
    var player: AVAudioPlayer?
    
    @IBOutlet weak var titleUILabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        
        let hardness = sender.titleLabel!.text!
        titleUILabel.text = hardness
        
        secondsTotal = eggTimes[hardness]!
        secondsPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    
    @objc func update() {
        if(secondsPassed < secondsTotal) {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(secondsTotal)
        }
        else{
            timer.invalidate()
            titleUILabel.text = "DONE!"
            player = try! AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.mp3.rawValue)
            player?.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0){
                self.titleUILabel.text = "How do you like your eggs?"
            }
        }

    }

    
}

