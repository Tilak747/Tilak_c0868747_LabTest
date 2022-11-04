//
//  ViewController.swift
//  Tilak_c0868747_LabTest
//
//  Created by Tilak Acharya on 2022-11-04.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var labelTime: UILabel!
    
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet weak var btnResume: UIButton!
    
    @IBOutlet weak var btnReset: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    var isRunning =  false
    var isPaused = false
    func initData(){
        labelTime.text = "00:00:00"
        
        btnStart.isHidden = false
        btnStart.setTitle("Start", for: .normal)
        btnStart.setTitleColor(UIColor.blue, for: .normal)
        
        btnResume.isHidden = true
        btnResume.setTitleColor(UIColor.blue, for: .normal)
        btnReset.isHidden = true
        btnResume.setTitleColor(UIColor.blue, for: .normal)
    }
    
    
    
    var mainTimer:Timer? = nil
    var mainCounter :Int = 0
    var lapTimer:Timer? = nil
    @IBAction func startTimer() {
        
        btnStart.isHidden = true
        isRunning = true
        
        btnResume.isHidden = false
        btnResume.setTitle("Stop", for: .normal)
        btnResume.setTitleColor(UIColor.red, for: .normal)
        
        btnReset.isHidden = false
        btnReset.setTitle("Lap", for: .normal)
        btnReset.setTitleColor(UIColor.blue, for: .normal)
        
    }
    
    func timerCounter(){
        mainCounter = mainCounter + 1
        
    }

    @IBAction func resumeStopTimer() {
        
        if(isPaused){
            isPaused = false
            btnResume.setTitle("Stop", for: .normal)
            btnResume.setTitleColor(UIColor.red, for: .normal)
            mainTimer?.invalidate()
            
        }
        else{
            isPaused = true
            btnResume.setTitle("Resume", for: .normal)
            btnResume.setTitleColor(UIColor.blue, for: .normal)
            mainTimer?.invalidate()
        }
    
    }
    
    func mainTimerCounter(){
        
    }
    
    @IBAction func resetLapTimer() {
    }
    
    
    
}

