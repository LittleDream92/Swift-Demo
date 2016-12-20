//
//  PaintView.swift
//  Swift-画板
//
//  Created by Meng Fan on 16/12/20.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

import UIKit

class PaintView: UIView {

    public var lineWidth:CGFloat = 1
    fileprivate var allLineArray = [[CGPoint]]()   //所有的线    记录每一条线
    fileprivate var currentPointArray = [CGPoint]() //当前画线的点  画完置空 增加到 线数组中
    fileprivate var allPointWidth = [CGFloat]()    //所有的线宽
    
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(.round)
        context?.setLineJoin(.round)
        
        
        //重绘的逻辑
        //绘制之前的线
        if allLineArray.count > 0 {
            //遍历之前的线
            for i in 0..<allLineArray.count {
                let tmpArr = allLineArray[i]
                if tmpArr.count > 0 {
                    //画线
                    context?.beginPath()
                    //取出起始点
                    let sPoint:CGPoint = tmpArr[0]
                    context?.move(to: sPoint)
                    //取出所有当前线的点
                    for j in 0..<tmpArr.count {
                        let endPoint:CGPoint = tmpArr[j]
                        context?.addLine(to: endPoint)
                    }
                    context?.setLineWidth(allPointWidth[i])
                    context?.strokePath()
                }
            }
        }
        
        
        if currentPointArray.count > 0 {
            //绘制当前线
            context?.beginPath()
            context?.setLineWidth(self.lineWidth)
            context?.move(to: currentPointArray[0])
            print(currentPointArray[0])
            
            for i in 0..<currentPointArray.count {
                context?.addLine(to: currentPointArray[i])
                print(currentPointArray[i])
            }
            context?.strokePath()
        }
    }
    
    //设置触摸时间，开始时记录第一个点并重绘（不重绘就没有只画一个点得效果），移动时不断记录并重绘。
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let point:CGPoint = (event?.allTouches?.first?.location(in: self))!
        //路径起点
        currentPointArray.append(point)
        //重绘，不重绘的话就只有一个点
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let point:CGPoint = (event?.allTouches?.first?.location(in: self))!
        //路径
        currentPointArray.append(point)
        
        //刷新视图
        self.setNeedsDisplay()
        
        
    }
    
    //触摸结束 存线 存线宽 清空当前线
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        allPointWidth.append(self.lineWidth)
        allLineArray.append(currentPointArray)
        currentPointArray.removeAll()
        self.setNeedsDisplay()
    }
    
    
    //我们的点都是存在数组中，清空画板时，只要将数组清空就可以了
    func cleanAll(){
        allLineArray.removeAll()
        currentPointArray.removeAll()
        allPointWidth.removeAll()
        self.setNeedsDisplay()
        
    }


}
