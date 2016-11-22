//
//  main.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/22.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

import Foundation

public func createDistributionMap() {
    print("请输入顶点数和边数")
    let sin = FileHandle.standardInput
    let cx = NSString(data: sin.availableData, encoding: String.Encoding.utf8.rawValue)
    
    let arr = cx?.components(separatedBy:" ")
    let arr2 = arr?[1].components(separatedBy: "\n")
    let vertexNum:Int = (Int)(((arr?[0])! as NSString).intValue)
    let edgeNum:Int = (Int)(((arr2?[0])! as NSString).intValue)
    

    let graph = Graph(numVetex: vertexNum, numEdge: edgeNum)
    if graph.graphIsEmpty() {
        
        if !graph.graphFull() {
            
            print(graph.getNumberOfVetex())
            print(graph.getNumberOfEdge())
            let testData1 = ArcNode(name: "helloNode", introduction: "hhhhh", popularity: ePopularity.五星, haveRestArea: true, haveWC: true)
            let testData2 = ArcNode(name: "helloWorld", introduction: "wwww", popularity: ePopularity.四星, haveRestArea: true, haveWC: true)
            
            
            
            if graph.insertArcNode(vertex: testData1) {
                print("插入节点test1成功")
            } else {
                print("插入失败")
            }
            if graph.insertArcNode(vertex: testData2) {
                print("插入节点2成功！")
            } else {
                print("插入失败")
            }
            
        }
    }
    
}

print("============================");
print("     欢迎使用景区信息管理系统");
print("       ***请选择菜单***");
print("============================");
print("\n1、创建景区景点分布图。\n2、输出景区景点分布图。\n3、输出导游路线图。\n4、输出导游路线图中的回路。\n5、求两个景点间的最短路径和最短距离。\n6、输出道路修建规划图。\n7、停车场车辆进出记录信息。\n0、退出系统。");
while true {
    print("请输入你要选择的菜单项")
    var sin = FileHandle.standardInput
    var cx = NSString(data: sin.availableData, encoding: String.Encoding.utf8.rawValue)
    //let arr = cx?.components(separatedBy:" ")
    
    var choice:Int = Int(cx!.intValue)
        switch choice {
        case 1: print(choice)
            createDistributionMap()
        case 2: print(choice)
        case 3: print(choice)
        case 4: print(choice)
        case 5: print(choice)
        case 6: print(choice)
        case 7: print(choice)
        case 8: print(choice)
        default:
            print("输入有误，请重新输入")
        
    }
}


