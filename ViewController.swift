//
//  ViewController.swift
//  catchTheKennyGame
//
//  Created by Mina Namlı on 3.03.2022.
//

import UIKit

class ViewController: UIViewController {

    var counter = 0
    var timer = Timer()
    var score = 0
    var Kennys = [UIImageView] ()
    var hideTimer = Timer ()
    var highscore = 0
        
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var kennyImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
                         
        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highscore = 0
            highScoreLabel.text = "High Score: \(highscore)"
        }
        
        if let newscore = storedHighScore as? Int {
            highscore = newscore
            highScoreLabel.text = "High Score: \(highscore)"
        }
        
        kennyImage.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true

        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(clickedKenny))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(clickedKenny))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(clickedKenny))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(clickedKenny))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(clickedKenny))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(clickedKenny))

        kennyImage.addGestureRecognizer(gestureRecognizer1)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)

        Kennys = [ kennyImage, kenny2, kenny3, kenny4, kenny5, kenny6]
        
        counter = 10
        timeLabel.text = "Time: \(counter)"
        
        score = 0
    
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil , repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5 , target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        
        
        hideKenny()
    }
     
    @objc func hideKenny() {
        
        for kenny in Kennys {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(Kennys.count - 1)))
        Kennys[random].isHidden = false
    }
    
    @objc func clickedKenny() {
            score += 1
            scoreLabel.text = "Score: \(score)"
    
    }

    @objc func timerFunction(){
        
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
        
            for kenny in Kennys {
                kenny.isHidden = true
            }
            
            if self.score > self.highscore {
                self.highscore = self.score
                highScoreLabel.text = "High Score: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
                
            }
            
            let alert = UIAlertController(title: "Time is over.", message: "Do you wanna play again?", preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil)
            let replaybutton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil , repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5 , target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okbutton)
            alert.addAction(replaybutton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

