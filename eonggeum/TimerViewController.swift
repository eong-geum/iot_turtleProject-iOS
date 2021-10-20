//
//  TimerViewController.swift
//  eonggeum
//
//  Created by YOONJONG on 2021/10/15.
//

import UIKit
import SRCountdownTimer
import AVFoundation

class TimerViewController: UIViewController, SRCountdownTimerDelegate {

    @IBOutlet weak var countdownTimer: SRCountdownTimer!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        countdownTimer.delegate = self
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
//        setConstraints()
        updateTimerUI()
        updateButtonUI()
    }
    
    private func updateTimerUI(){
        countdownTimer.lineWidth = 4.0
        countdownTimer.lineColor = UIColor(red: 43/255, green: 255/255, blue: 160/255, alpha: 1)
        countdownTimer.trailLineColor = UIColor.lightGray.withAlphaComponent(0.5)
        countdownTimer.isLabelHidden = false
        countdownTimer.labelFont = UIFont.systemFont(ofSize: 80, weight: .light)
        countdownTimer.timerFinishingText = "완료!"
    }
    private func updateButtonUI(){
        startButton.layer.cornerRadius = 30
        startButton.layer.backgroundColor = CGColor(red: 22/255, green: 217/255, blue: 129/255, alpha: 1)
    }
    @IBAction func startButtonTapped(_ sender: Any) {
        countdownTimer.start(beginingValue: 10, interval: 1)
    }
    func timerDidEnd(sender: SRCountdownTimer, elapsedTime: TimeInterval) {
        AudioServicesPlaySystemSound(4095)
        AudioServicesPlaySystemSound(1163)
    }
}
