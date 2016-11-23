//
//  main.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/22.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

import Foundation

public func getUserInput() -> [String] {
    let stdInput = FileHandle.standardInput
    let userInput = NSString(data: stdInput.availableData, encoding: String.Encoding.utf8.rawValue)
    var tempArr = userInput?.components(separatedBy: " ")
    let tempArr2 = tempArr?.last?.components(separatedBy: "\n")
    //把空格去掉归并到一个数组里
    tempArr?.removeLast()
    tempArr?.append((tempArr2?.first)!)
    return tempArr!
}


public func createDistributionMap() {
    print("请输入顶点数和边数")
    let vertexAndEdgeNum = getUserInput()
    let maxVertexNum:Int = (Int)(vertexAndEdgeNum.first!)!
    let maxEdgeNum:Int = (Int)(vertexAndEdgeNum.last!)!
    
    let graph = Graph(maxVertexNum: maxVertexNum, maxEdgeNum: maxEdgeNum)
    
    print("\n          请输入各顶点的信息\n\n请输入各顶点的名字（空格隔开）")
    let ScenicSpotNameArr = getUserInput()
    print(ScenicSpotNameArr.count)
    for i in 0..<(ScenicSpotNameArr.count) {
        let spotName = ScenicSpotNameArr[i]
        let spot = ArcNode(name: spotName)
        if graph.insertArcNode(vertex: spot) {
            print("插入\(spotName)节点成功")
        }
    }
    for i in 0..<maxVertexNum {
        print("请输入第\(i)条边的两个顶点以及该边的权值：（空格隔开）")
        let edgeSetArr = getUserInput()
        let startSpot = graph.getArcNode(vertexName: edgeSetArr[0])
        let endSpot = graph.getArcNode(vertexName: edgeSetArr[1])
        let weight:Int = (Int)(edgeSetArr.last!)!
        if (graph.insertEdge(vertex: startSpot!, anotherVertex: endSpot!, weight: weight) != nil) {
            print("插入边\(startSpot?.name)到\(endSpot?.name)成功,权值为\(weight)")
        } else {
            print("插入失败")
        }
    }
    
    print(graph.edgeArr)
    print(graph.vertexArr)
    
  /*
     
    
    if graph.graphIsEmpty() {
        
        if !graph.graphFull() {
            
            print(graph.getNumberOfVetex())
            print(graph.getNumberOfEdge())
            let testData1 = ArcNode(name: "老大", introduction: "hhhhh", popularity: ePopularity.五星, haveRestArea: true, haveWC: true)
            let testData2 = ArcNode(name: "老二", introduction: "wwww", popularity: ePopularity.四星, haveRestArea: true, haveWC: true)
            
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
            if graph.insertEdge(vertex: testData1, anotherVertex: testData2, weight: 8) {
                print("插入边成功")
            }
            
            if graph.insertEdge(vertex: testData2, anotherVertex: testData1, weight: 8) {
                print("插入边成功")
            }
            
            print(graph.getNumberOfVetex())
            print(graph.getWeight(vetexName: "老大", anotherName: "老二"))
            
//            print(graph.getArcNode(vertexName:"老大")?.next?.name)
//            print(graph.getArcNode(vertexName: "老二")?.pre?.name)
            
        }
    }
    


 */
    
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



