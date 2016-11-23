//
//  CreateDistributionMap.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/23.
//  Copyright © 2016年 ITPanda. All rights reserved.
//


/*
 1.创建景区景点分布图
 */
import Foundation

let MAX_VERTEX_NUM = 15
let MAX_EDGE_NUM = 20

//初始化数组
public func initGraphSpotArr(graph:inout Graph) {
    let arrSpotPlist:NSArray = readPlist(plistNameStr: "ScenicSpotList.plist")
    for i in 0 ..< arrSpotPlist.count {
        let dict = arrSpotPlist[i]
        let model:ScenicSpotListModel = ScenicSpotListModel.init(dict: dict as! [String : Any])
        let node:ArcNode = ArcNode(name: model.name!, introduction: model.introduction!, popularity: model.popularity!, haveRestArea: model.isHaveRestArea!, haveWC: model.isHaveWC!)
        if graph.insertArcNode(vertex: node) {
            print("插入第\(i+1)个结点成功")
        }
    }
}

public func initGraphEdgeArr(graph:inout Graph) {
    
    let arrEdgePlist:NSArray = readPlist(plistNameStr: "EdgeList.plist")
    for i in 0 ..< arrEdgePlist.count {
        let dict = arrEdgePlist[i]
        let model:EdgeListModel = EdgeListModel.init(dict: dict as! [String : Any])
//        let newEdge:Edge = Edge(startVertex: graph.getArcNode(vertexName: model.startPoint!)!, endVertex: graph.getArcNode(vertexName: model.endPoint!)!, edgeWeight: Int(model.weight!)!)
        if graph.insertEdge(vertex: graph.getArcNode(vertexName: model.startPoint!)!, anotherVertex: graph.getArcNode(vertexName: model.endPoint!)!, weight: Int(model.weight!)!) {
            print("插入第\(i+1)条边成功")
        }
        
    }
}

func readPlist(plistNameStr:String) -> NSArray {
    let path = Bundle.main.path(forResource: plistNameStr, ofType: nil)
    //print(Bundle.main)     //main方法返回的路径贼奇怪，换了个地，为了测试方便，直接拷贝一份plist文件到其目录下了。就不过多纠结这些了。。
    let arr:NSArray = NSArray.init(contentsOfFile: path!)!
    return arr
}


public func createDistributionMap(graph:inout Graph ) {
    print("开始创建景区景点分布图")
    initGraphSpotArr(graph: &graph)
    initGraphEdgeArr(graph: &graph)
    
    print("创建景区景点分布图成功！")
}


/*
 初始版本是获取用户输入，这样用户输入太多，太多错误操作要考虑而且输入数据太大，所以把数据都写到plist文件里
//获取用户输入
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
    for i in 0..<maxEdgeNum {
        print("请输入第\(i+1)条边的两个顶点以及该边的权值：（空格隔开）")
        let edgeSetArr = getUserInput()
        let startSpot = graph.getArcNode(vertexName: edgeSetArr[0])
        let endSpot = graph.getArcNode(vertexName: edgeSetArr[1])
        let weight:Int = (Int)(edgeSetArr.last!)!
        if graph.insertEdge(vertex: startSpot!, anotherVertex: endSpot!, weight: weight) {
            print("插入边\(startSpot?.name)到\(endSpot?.name)成功,权值为\(weight)")
        } else {
            print("插入失败")
        }
    }
    
    print(graph.edgeArr)
    print(graph.vertexArr)
    print(graph.getArcNode(vertexName: "hello")?.connectedEdgeArr[0].endPoint.name)
    
}
 */
