//
//  ViewController.swift
//  Tilak_c0868747_LabTest
//
//  Created by Tilak Acharya on 2022-11-04.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelLapTime: UILabel!
    
    @IBOutlet weak var btnResume: UIButton!
    
    @IBOutlet weak var btnReset: UIButton!
    
    @IBOutlet weak var lapTableView: UITableView!
    
    var lapArray:Array<LapModel> = []
    
    @IBOutlet weak var tabBar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lapTableView.delegate = self
        lapTableView.dataSource = self
        lapTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        initData()
        

    }
    
    @IBAction func toggle() {
        
        
        
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
           case 1 :
            btnResume.isHidden = true
            break
        default:
            btnResume.isHidden = false
            break
        }
    }

    @IBAction func gotoTimer(_ sender: Any) {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = mainSB.instantiateViewController(withIdentifier: "TimerScene") as! TimerVC
//        self.navigationController?.pushViewController(homeVC, animated: true)
        self.present(homeVC, animated: true)
    }
    
    var isRunning =  false
    var isPaused = false
    func initData(){
        
        isRunning = false
        isPaused = false
        
        mainCounter = 0
        lapCounter = 0
        
        labelTime.text = "00:00:00"
        labelTime.isHidden = false
        
        labelLapTime.text = "00:00:00"
        
        btnResume.isHidden = false
        btnResume.setTitleColor(UIColor.blue, for: .normal)
        btnResume.setTitle("Start", for: .normal)
        
        btnReset.isHidden = false
        btnReset.setTitleColor(UIColor.blue, for: .normal)
        btnReset.setTitle("Lap", for: .normal)
        
        lapArray = []
        
        mainTimerCounting = false
        lapTimerCounting = false
    }
    
    
    
    var mainTimer:Timer? = nil
    var mainCounter :Int = 0
    var mainTimerCounting:Bool = false
    var lapTimer:Timer? = nil
    var lapCounter: Int = 0
    var lapTimerCounting:Bool = false
    var isResetable : Bool = false
    @IBAction func startTimer() {
        
        isRunning = true
        
        btnResume.isHidden = false
        btnResume.setTitle("Stop", for: .normal)
        btnResume.setTitleColor(UIColor.red, for: .normal)
        
        btnReset.isHidden = false
        btnReset.setTitle("Lap", for: .normal)
        btnReset.setTitleColor(UIColor.blue, for: .normal)
        
        mainTimerCounting  = true
        mainTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(timerCounter),
            userInfo: nil,
            repeats: true
        )
        
    }
    
    func convertToSeconds(seconds:Int) -> (Int,Int,Int){
        return (seconds / 3600 , (seconds % 3600) / 60 , (seconds % 3600 ) % 60)
    }
    
    @objc func timerCounter(){
        mainCounter = mainCounter + 1
        let time = convertToSeconds(seconds: mainCounter)
        displayTimerValue(hrs: time.0, mins: time.1, sec: time.2)
        
    }
    func displayTimerValue(hrs:Int,mins:Int,sec:Int){
        labelTime.text = "\(String(format: "%2d", hrs)) : \(String(format: "%2d", mins)) : \(String(format: "%2d", sec))"
    }
    
    

    @IBAction func resumeStopTimer() {
        
        if(mainTimerCounting){
            mainTimerCounting = false
            isResetable = true
            
            btnResume.setTitle("Resume", for: .normal)
            btnResume.setTitleColor(UIColor.blue, for: .normal)
            
            btnReset.setTitle("Reset", for: .normal)
            
            mainTimer?.invalidate()
            lapTimer?.invalidate()
            
            
        }
        else{
            
            mainTimerCounting = true
            isResetable = false
            
            btnResume.setTitle("Stop", for: .normal)
            btnResume.setTitleColor(UIColor.red, for: .normal)
            
            btnReset.setTitle("Lap", for: .normal)
            
            mainTimer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(timerCounter),
                userInfo: nil,
                repeats: true
            )
            
            if(lapTimerCounting){
                lapTimer = Timer.scheduledTimer(
                    timeInterval: 1,
                    target: self,
                    selector: #selector(lapTimeCounter),
                    userInfo: nil,
                    repeats: true
                )
            }
        }
    
    }
    

    
    
    @objc func lapTimeCounter(){
        lapCounter = lapCounter + 1
        let time = convertToSeconds(seconds: lapCounter)
        displayLapTimerValue(hrs: time.0, mins: time.1, sec: time.2)
    }
    func displayLapTimerValue(hrs:Int,mins:Int,sec:Int){
        labelLapTime.text = "\(String(format: "%2d", hrs)) : \(String(format: "%2d", mins)) : \(String(format: "%2d", sec))"
    }
    
    @IBAction func resetLapTimer() {
        
        //is paused then reset trigger
        if(isResetable){
            
            mainTimer?.invalidate()
            lapTimer?.invalidate()
            
            initData()
            
            lapTableView.reloadData()
            
        }
        else{
            
            if(lapArray.isEmpty){
                let lap = LapModel(lapElapseTime: mainCounter, lapStoppedTime: mainCounter)
                lapArray.append(lap)
            }
            else{
                let lap = LapModel(lapElapseTime: lapCounter, lapStoppedTime: mainCounter)
                lapArray.append(lap)
            }
            
            lapTimer?.invalidate()
            lapCounter = 0
            
            labelLapTime.isHidden = false
            lapTimerCounting = true
            lapTimer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(lapTimeCounter),
                userInfo: nil,
                repeats: true
            )
            
            lapTableView.reloadData()
            
        }
        
    }
    
    
    
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        let lap = lapArray[indexPath.row]
        
        let lapTime = convertToSeconds(seconds: lap.lapElapseTime)
        
        let lapValue = "\(String(format: "%2d", lapTime.0)) : \(String(format: "%2d", lapTime.1)) : \(String(format: "%2d", lapTime.2))"
        
        cell.textLabel?.text = "Lap \(indexPath.row+1): \(lapValue)"
        
        return cell
    }
    
    
}
