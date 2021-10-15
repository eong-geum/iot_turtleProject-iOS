//
//  MainViewController.swift
//  eonggeum
//
//  Created by YOONJONG on 2021/10/11.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var turtleImageView: UIImageView!
    @IBOutlet weak var todayCountView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    

    func updateUI(){
        todayView.layer.cornerRadius = 20
        turtleImageView.layer.cornerRadius = 20
        todayCountView.layer.cornerRadius = 20
//        todayCountView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
    }

}
