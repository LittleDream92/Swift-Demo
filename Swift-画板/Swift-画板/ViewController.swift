//
//  ViewController.swift
//  Swift-画板
//
//  Created by Meng Fan on 16/12/20.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var slide: UISlider!
    
    @IBOutlet weak var paintView: PaintView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: Action
    //改变宽度
    @IBAction func configLineWidth(_ sender: Any) {
        paintView.lineWidth = CGFloat(self.slide.value) * 10
    }
    
    
    
    //保存
    @IBAction func saveAction(_ sender: Any) {
        let height:CGFloat = self.view.bounds.size.height - self.saveBtn.frame.height - 10
        let imageSize :CGSize = CGSize(width: self.view.bounds.size.width, height: height)
        UIGraphicsBeginImageContext(imageSize)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(img, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //清除
    @IBAction func clearAction(_ sender: Any) {
        paintView.cleanAll()
    }
    

    //保存图片回调
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        var resultTitle:String?
        var resultMessage:String?
        if error != nil {
            resultTitle = "错误"
            resultMessage = "保存失败,请检查是否允许使用相册"
        } else {
            resultTitle = "提示"
            resultMessage = "保存成功"
        }
        let alert:UIAlertController = UIAlertController.init(title: resultTitle, message:resultMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //屏幕切换时刷新
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.paintView.setNeedsDisplay()
    }

}

