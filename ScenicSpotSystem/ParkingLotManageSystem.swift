//
//  ParkingLotManageSystem.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/25.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/*
 8、车辆进出管理系统
 存在bug与不足： 时间只能输入整数
        在等待队列里的车其实不应该计费的，进入排队队列应该不能算停车费。
        在排队队列转移到停车场的时候，应该更新他们的arriveTime才对。
 */

import Foundation

let MAX_PARKING_CAR_COUNT = 5  //设置停车场停车位
let PRICE_PER_HOUR = 30

public func parkingLotManageSys() {
    print("   ** 停车场管理程序 **")
    print("==========================")
    print("**                   **")
    print("**  1. ---- 汽车 进 车场")
    print("**  2. ---- 汽车 出 车场")
    print("**  3. ---- 退出 程序")
    print("**                   **")
    print("==========================")
    
    let parkingSys:ParkingLotSystem = ParkingLotSystem()
    var value:Int = 1
    while value != 0 {
        print("请输入你要执行的操作")
        value = parkingSys.start()
    }
    
}

class ParkingLotSystem: NSObject {
    
    var parkingLotStack:[Car] = []
    var waitingQueue:[Car] = []
    var tempPark:[Car] = []
    
    func start() -> Int {
        let userInp = FileHandle.standardInput
        let inputData = NSString(data: userInp.availableData, encoding: String.Encoding.utf8.rawValue)
        let carAction:Int = Int(inputData!.intValue)
        
        switch carAction {
        case 1:
            carEnter()
        case 2:
            carLeave()
        case 3:
            return 0
        default:
            print("输入有误")
        }
        return 1
    }
    func carEnter() {
        let newInCar = getCarInfo()
        if isParkingLotFull() {
            //如果停车场满了 放入等待队列末尾
            self.waitingQueue.append(newInCar)
            print("场停车已满，该车进入等待队列，队列前面还有\(self.waitingQueue.count-1)辆车")
        } else {
            self.parkingLotStack.append(newInCar)
            print("你的车停在了\(self.parkingLotStack.count-1)号车位")
        }
        
    }
    func carLeave() {
        
        print("请输入要离开的车辆的车牌号：")
        let carID:String? = getUserInput().first!
        print("请输入当前的时间 （0~24）")
        let currentTime:Int = Int((getUserInput().first! as NSString).intValue)
        
        for (index, value) in self.parkingLotStack.enumerated() {
            if carID == value.carID {
                print("你的车在\(index)号停车位")
                takeCharge(currentTime: currentTime, leavingCar: value)
                    //开始退栈，进行让路
                    for i in index+1 ..< self.parkingLotStack.count {  //把这辆车后面的都放到tempPark里 （让路）
                        let moveWayCar = self.parkingLotStack[i]
                        self.tempPark.append(moveWayCar)
                    }
                    self.parkingLotStack.removeSubrange(index...self.parkingLotStack.count-1) //把这辆车跟后面的都退掉
                    for moveCar in self.tempPark {
                        self.parkingLotStack.append(moveCar)
                    }
                    self.tempPark.removeAll() //记得要清空一下临时队列
                    if isHaveCarWaiting() {
                        let firstWaitCar = self.waitingQueue.first
                        self.waitingQueue.removeFirst() //哈哈哈 调用removeFirst之后，后面的元素会自动补上来
                        self.parkingLotStack.append(firstWaitCar!)
                    }
            }
        }
        
    }
    func isParkingLotFull() -> Bool {
        if self.parkingLotStack.count >= MAX_PARKING_CAR_COUNT {
            return true
        } else {
            return false
        }
    }
    func isHaveCarWaiting() -> Bool {
        return !self.waitingQueue.isEmpty
    }
    func getCarInfo() -> Car {
        //获取用户输入
        print("车牌为：")
        let carID:String = getUserInput().first!
        print("当前的时刻为:（0~24）")
        let arrTime:Int = Int((getUserInput().first as! NSString).intValue)
        let currentCar:Car = Car(carID: carID, arriveTime: arrTime)
        return currentCar
    }
    func takeCharge(currentTime:Int ,leavingCar:Car) {
        //进行计费 并输出
        let parkTime:Int = currentTime - leavingCar.arriveTime
        let parkFee:Int = parkTime * PRICE_PER_HOUR
        print("本次停车\(parkTime)个小时，收取\(parkFee)")
    }
}

struct Car {
    var carID:String
    var arriveTime:Int
    
    init(carID:String, arriveTime:Int) {
        self.carID = carID
        self.arriveTime = arriveTime
    }
}

