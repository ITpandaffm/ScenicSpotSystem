//
//  ScenicSpotDataModel.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/23.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

import Foundation



public class ScenicSpotListModel : NSObject {
    
    var name:String?
    var introduction:String?
    var popularity:String?
    var isHaveRestArea:String?
    var isHaveWC:String?
    
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
}

public class EdgeListModel : NSObject {
    var startPoint:String?
    var endPoint:String?
    var weight:String?
    
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
    
}
