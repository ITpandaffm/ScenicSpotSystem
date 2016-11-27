//
//  main.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/22.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
//
/* 
 plist文件的路径，可能是由于运行在mac上，不同于运行在虚拟机，或者是swift语言的改版，在读取plist文件的时候，Bundle.main方法的读取路径不再是之前的在当前工程目录里查找读取，而是去到了一个debug的文件夹，具体还得通过print方法输出，通过finder前往文件夹才行。所以这里也恳请老师留个心眼，如果读取文件失败的话，麻烦把plist文件移动到Bundle.main方法所提供的路径。谢谢老师。
 （其实我已经把输出路径的代码混在了第一个功能creatDistributionMap里面了，直接按的话应该可以输出
 */
import Foundation

print("============================");
print("     欢迎使用景区信息管理系统");
print("       ***请选择菜单***");
print("============================");
print("\n1、创建景区景点分布图。\n2、输出景区景点分布图。\n3、输出导游路线图。\n4、输出导游路线图中的回路。\n5、求两个景点间的最短路径和最短距离。\n6、查找排序。\n7、景点热度排行榜。\n8、车辆进出管理系统。");
private var graph:Graph = Graph(maxVertexNum: MAX_VERTEX_NUM, maxEdgeNum: MAX_EDGE_NUM)

while true {
    print("请输入你要选择的菜单项")
    var sin = FileHandle.standardInput
    var cx = NSString(data: sin.availableData, encoding: String.Encoding.utf8.rawValue)
    
    var choice:Int = Int(cx!.intValue)
        switch choice {
        case 1:
            createDistributionMap(graph: &graph)
        case 2:
            outputDistributionMap(graph: graph)
        case 3:
            outputGuiLineMap(graph: graph)
        case 4:
            findLoopWay(graph: graph)
        case 5:
            findBestWayAndShortestWay(graph: &graph)
        case 6:
            SearchScenicSpot(graph: graph)
        case 7:
            SortScenicSpot(graph: graph)
        case 8:
            parkingLotManageSys()
        default:
            print("输入有误，请重新输入")
        
    }
}


//都会用到的方法，获取用户输入的字符串 返回一个数组
func getUserInput() -> [String] {
    let stdInput = FileHandle.standardInput
    let userInput = NSString(data: stdInput.availableData, encoding: String.Encoding.utf8.rawValue)
    var tempArr = userInput?.components(separatedBy: " ")
    let tempArr2 = tempArr?.last?.components(separatedBy: "\n")
    //把空格去掉归并到一个数组里
    tempArr?.removeLast()
    tempArr?.append((tempArr2?.first)!)
    return tempArr!
}

