//
//  ParkingLotManageSystem.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/25.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/*
 8、车辆进出管理系统
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
        //当有车要进入，首先判断停车场里面是否还有空位，若满，则放进队列里，否则进入停车场，
        //无论进入等待队列还是停车场 都要有控制台输出 车辆具体位置
        
        //获取用户输入
        print("车牌为：")
        let carID:String = getUserInput().first!
        print("进场的时刻为:（0~24）")
        let arrTime:Int = Int((getUserInput().first as! NSString).intValue)
        let newInCar:Car = Car(carID: carID, arriveTime: arrTime)
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
        //当某辆车要离开，则在其之后进来的车都要退栈让路，直到该车离开停车场，再回来（往前填充空位
        //然后检查等待队列里是否有车，若有，则队头进入停车场
        //并且离开的时候，要按照停留时间长短进行缴费,输出到控制台其应交费用还有停留时间
        print("请输入要离开的车辆的车牌号：")
        let carID:String? = getUserInput().first!
        print("请输入当前的时间 （0~24）")
        let currentTime:Int = Int((getUserInput().first! as NSString).intValue)
        
        for (index, value) in self.parkingLotStack.enumerated() {
            if carID == value.carID {
                let leavingCar = self.parkingLotStack[index]
                print("你的车在\(index)号停车位")
                
                if index+1 == self.parkingLotStack.count {  //如果是最后一辆，不需要其他车移动，直接退栈
                    //进行计费 并输出
                    let parkTime:Int = currentTime - leavingCar.arriveTime
                    let parkFee:Int = parkTime * PRICE_PER_HOUR
                    print("本次停车\(parkTime)个小时，收取\(parkFee)")
//
                    self.parkingLotStack.removeLast()
                    
                    if isHaveCarWaiting() {
                        let firstWaitCar = self.waitingQueue.first
                        self.waitingQueue.removeFirst() //哈哈哈 调用removeFirst之后，后面的元素会自动补上来
                        self.parkingLotStack.append(firstWaitCar!)
                    }
                } else {
                    //进行计费 并输出
//                    let parkTime:Int = (currentTime as! Int) - (leavingCar.arriveTime as! Int)
//                    let parkFee:Double = (parkTime as! Double) * PRICE_PER_HOUR
//                    print("本次停车\(parkTime)个小时，收取\(parkFee)")
                    
                    //开始退栈，进行让路
                    for i in index+1 ..< self.parkingLotStack.count {  //把这辆车后面的都放到tempPark里 （让路）
                        let moveWayCar = self.parkingLotStack[i]
                        self.tempPark.append(moveWayCar)
                    }
                    self.parkingLotStack.removeSubrange(index...self.parkingLotStack.count-1) //把这辆车跟后面的都退掉
                    for moveCar in self.tempPark {
                        self.parkingLotStack.append(moveCar)
                    }
                    //原来的车进入完毕之后， 检查一下等待队列，如果等待队列不为空，证明之前停车场是满的，现在多了一个位置，
                    //所以取出等待队列的队头元素，并加入到停车场里面
                    if isHaveCarWaiting() {
                        let firstWaitCar = self.waitingQueue.first
                        self.waitingQueue.removeFirst() //哈哈哈 调用removeFirst之后，后面的元素会自动补上来
                        self.parkingLotStack.append(firstWaitCar!)
                    }
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
}

struct Car {
    var carID:String
    var arriveTime:Int
    
    init(carID:String, arriveTime:Int) {
        self.carID = carID
        self.arriveTime = arriveTime
    }
}

