//
//  LapModel.swift
//  Tilak_c0868747_LabTest
//
//  Created by Tilak Acharya on 2022-11-04.
//

import Foundation


struct LapModel{
    
    var lapElapseTime:Int
    var lapStoppedTime:Int
    
    init(lapElapseTime: Int, lapStoppedTime: Int) {
        self.lapElapseTime = lapElapseTime
        self.lapStoppedTime = lapStoppedTime
    }
    
}
