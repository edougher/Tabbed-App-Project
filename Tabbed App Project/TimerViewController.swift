//
//  TimerViewController.swift
//  Tabbed App Project
//
//  Created by Aaron Dougher on 2/26/18.
//  Copyright © 2018 Erin Dougher. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    

    
    @IBOutlet weak var timerPicker: UIDatePicker!
    
 
    var timeRemaining = UILabel()
    var countdownView = UIView()
    var sleepTime = 0.0 {
        didSet {
            print(sleepTime)
        }
    }
    var timer: Timer?
    var timerIsRunning = false
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
            setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var timerButton: UIButton!
    @IBAction func timerButton(_ sender: UIButton) {
        startTimer()
    }

    

    private func startTimer() {
        print("startTimer")
        sleepTime = timerPicker.countDownDuration
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        countdownView.isHidden = false
        timerIsRunning = true
        timerButton.titleLabel?.text = "Stop"
        timeRemaining.text = timeString(sleepTime)
    }
    
    @objc private func updateTimer() {
       
        if sleepTime != 0.0 {
            sleepTime -= 1
            timeRemaining.text = timeString(sleepTime)
        }
        else {
            timer?.invalidate()
            countdownView.isHidden = true
            timerIsRunning = false
            timerButton.titleLabel?.text = "Start"
        }
        
    }
    
    private func timeString(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    private func setupView(){
        countdownView.frame = timerPicker.frame
        countdownView.center = timerPicker.center
        countdownView.backgroundColor = UIColor.white
        countdownView.bounds = timerPicker.frame
        timeRemaining.backgroundColor = UIColor.clear
        timeRemaining.textColor = UIColor.black
        timeRemaining.bounds = countdownView.bounds
        timeRemaining.center = countdownView.center
        timeRemaining.font = UIFont(name: "System", size: 60)
        timeRemaining.adjustsFontSizeToFitWidth = true
        timeRemaining.text = ""
        countdownView.addSubview(timeRemaining)
        timerPicker.addSubview(countdownView)
        countdownView.isHidden = true
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
