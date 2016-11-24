//
//  main.swift
//  ScenicSpotSystem
//
//  Created by ffm on 16/11/22.
//  Copyright © 2016年 ITPanda. All rights reserved.
//



import Foundation

print("============================");
print("     欢迎使用景区信息管理系统");
print("       ***请选择菜单***");
print("============================");
print("\n1、创建景区景点分布图。\n2、输出景区景点分布图。\n3、输出导游路线图。\n4、输出导游路线图中的回路。\n5、求两个景点间的最短路径和最短距离。\n6、输出道路修建规划图。\n7、停车场车辆进出记录信息。\n0、退出系统。");

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
            findBestWayAndShortestWay(graph: graph)
        case 6: print(choice)
        case 7: print(choice)
        case 8: print(choice)
        default:
            print("输入有误，请重新输入")
        
    }
}



