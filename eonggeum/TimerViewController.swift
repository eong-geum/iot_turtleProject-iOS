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
    var isRunning = false
    @IBOutlet weak var countdownTimer: SRCountdownTimer!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startButtonCenterX: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: UIButton!
    
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
        countdownTimer.labelFont = UIFont.systemFont(ofSize: 100, weight: .light)
        countdownTimer.timerFinishingText = "완료!"
    }
    private func updateButtonUI(){
        cancelButton.isHidden = true
        cancelButton.layer.cornerRadius = 30
        startButton.layer.cornerRadius = 30
        startButton.layer.backgroundColor = CGColor(red: 22/255, green: 217/255, blue: 129/255, alpha: 1)
    }
    @IBAction func startButtonTapped(_ sender: Any) {
        countdownTimer.start(beginingValue: 30, interval: 1)
        stopStateUI()
    }
    func timerDidStart(sender: SRCountdownTimer) {
        isRunning = true
        startButton.setTitle("다시 시작하기", for: .normal)
        startButtonCenterX.constant = 55
        startButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        cancelButton.isHidden = false
    }
    func timerDidEnd(sender: SRCountdownTimer, elapsedTime: TimeInterval) {
        isRunning = false
        AudioServicesPlaySystemSound(4095)
        AudioServicesPlaySystemSound(1163)
        startButtonCenterX.constant = 0
        cancelButton.isHidden = true
    }
    @IBAction func exitButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        if (isRunning == true) { // 현재 돌아가고 있는 중이었다면 멈추기
            isRunning = false
            countdownTimer.pause()
            resumeStateUI()
        } else {    // 현재 멈춰있었따면 재개
            isRunning = true
            countdownTimer.resume()
            stopStateUI()
        }
    }
    
    
    
    private func stopStateUI(){
        cancelButton.setTitle("중지", for: .normal)
        cancelButton.backgroundColor = .red
        countdownTimer.lineColor = UIColor(red: 43/255, green: 255/255, blue: 160/255, alpha: 1)
    }
    private func resumeStateUI(){
        cancelButton.setTitle("재개", for: .normal)
        cancelButton.backgroundColor = .systemBlue
        countdownTimer.lineColor = UIColor(red: 255/255, green: 0/255, blue: 72/255, alpha: 1)
    }
}
