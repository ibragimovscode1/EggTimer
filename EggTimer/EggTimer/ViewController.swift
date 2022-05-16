//
//  ViewController.swift
//  EggTimer
//
//

import UIKit
import AVFoundation
var player: AVAudioPlayer?

class ViewController: UIViewController {
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
   var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    
  
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var eggStatus: UILabel!
    
    
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    @IBAction func hardnessSelected (sender: UIButton) {
                
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        if hardness == "Soft" {
            print(eggTimes["Soft"]!)
        } else if hardness == "Medium" {
            print(eggTimes["Medium"]!)
        }else if hardness == "Hard" {
            print(eggTimes["Hard"]!)
        } else {
            print("Error")
        }
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        self.eggStatus.text = hardness
     
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1
                progressBar.progress = Float(secondsPassed) / Float(totalTime)
                    } else {
                    self.timer.invalidate()
                    self.eggStatus.text = "DONE!"
                    playSound()
                        
                        
                    }

                     
                }
            }
                    
    }




