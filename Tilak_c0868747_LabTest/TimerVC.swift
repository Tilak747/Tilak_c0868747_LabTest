//
//  TimerVC.swift
//  Tilak_c0868747_LabTest
//
//  Created by Tilak Acharya on 2022-11-04.
//

import Foundation
import UIKit


class TimerVC: UIViewController{
    
    
    @IBOutlet weak var picker: UIDatePicker!
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    @IBOutlet weak var lblTime: UILabel!

    
    
    var isRunning:Bool = false
    var countDownTime : Int = 0
    var timer:Timer? = nil
    
    @IBAction func gotoStopwatch(_ sender: Any) {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = mainSB.instantiateViewController(withIdentifier: "StopwatchScene")
        navigationController?.pushViewController(homeVC, animated: true)
    }
    @IBAction func startCountdown(_ sender: Any) {
        
        if(countDownTime == 0){
            countDownTime = Int(picker.countDownDuration)
        }
        
        
        if(isRunning){
            
            isRunning = false
            btnStart.setTitle("Start", for: .normal)
            
            timer?.invalidate()
            
        }
        else{
            isRunning = true
            btnStart.setTitle("Pause", for: .normal)
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
            lblTime.isHidden = false
            lblTime.text = "Countdown remaining: \(countDownTime)"
            
        }
        
    }
    
    @objc func updateCounter(){
        countDownTime -= 1
        lblTime.text = "Countdown remaining : \(countDownTime)"
    }
    
    @IBAction func cancelCountdown(_ sender: Any) {
        timer?.invalidate()
        let alert = UIAlertController(title: "Cancelled", message: "Timer has been cancelled", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel){
            _ in
            self.lblTime.isHidden = true
            
            self.btnStart.setTitle("Start", for: .normal)
            self.isRunning = false
            self.countDownTime = 0
        })
        present(alert, animated: true)
    }
}
