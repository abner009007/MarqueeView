import UIKit

let screen_WIDTH : CGFloat          = UIScreen.main.bounds.size.width
let screen_HEIGHT : CGFloat         = UIScreen.main.bounds.size.height

class ZDYMarqueeView: UIView {
    
    fileprivate var firstLabel = UILabel()
    fileprivate var secondLabel = UILabel()
    fileprivate var font = UIFont.systemFont(ofSize: 14)
    
    convenience init(frame: CGRect, title: String,textColor:UIColor) {
        self.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        firstLabel.frame = CGRect(x:0,y:0,width:screen_WIDTH,height:self.frame.height)
        firstLabel.text = title
        firstLabel.font = font
        firstLabel.textColor = textColor
        self.addSubview(firstLabel)
        
        secondLabel.frame = CGRect(x:firstLabel.frame.maxX,y:0,width:screen_WIDTH,height:firstLabel.frame.size.height)
        secondLabel.text = title
        secondLabel.font = font
        secondLabel.textColor = textColor
        self.addSubview(secondLabel)
        
        startAnimation()
    }
    func startAnimation() {
        //两种方式都可以
//        firstLabel.frame = CGRect(x:0,y:0,width:screen_WIDTH,height:self.frame.height)
//        secondLabel.frame = CGRect(x:firstLabel.frame.maxX,y:0,width:screen_WIDTH,height:firstLabel.frame.size.height)
//        UIView.beginAnimations("testAnimation", context: nil)
//        UIView.setAnimationDuration(5)
//        UIView.setAnimationRepeatCount(0)
//        UIView.setAnimationCurve(.linear)
//        firstLabel.frame = CGRect(x:-screen_WIDTH,y:0,width:screen_WIDTH,height:frame.height)
//        secondLabel.frame = CGRect(x:0,y:0,width:screen_WIDTH,height:firstLabel.frame.size.height)
//        UIView.commitAnimations()
        
        weak var weakSelf = self
        firstLabel.frame = CGRect(x:0,y:0,width:screen_WIDTH,height:self.frame.height)
        secondLabel.frame = CGRect(x:firstLabel.frame.maxX,y:0,width:screen_WIDTH,height:firstLabel.frame.size.height)
        
        UIView.transition(with: self, duration: 10, options: .curveLinear, animations: { 
            weakSelf?.firstLabel.frame = CGRect(x:-screen_WIDTH,y:0,width:screen_WIDTH,height:(weakSelf?.frame.height)!)
            weakSelf?.secondLabel.frame = CGRect(x:0,y:0,width:screen_WIDTH,height:(weakSelf?.firstLabel.frame.size.height)!)
        }) { (finish) in
            weakSelf?.startAnimation()
        }
    }
    deinit {
        
    }
    
}





































////
////  ZDYPMDAnimation.swift
////  KaiXinGuoMJZZR
////
////  Created by 云中科技 on 2018/3/14.
////  Copyright © 2018年 深圳指掌人科技有限公司. All rights reserved.
////
//
//import UIKit
//
//class ZDYMarqueeView: UIView {
//
//    /// 前后间距
//    private let xMargin: CGFloat = 0
//    /// 时间
//    private var time: Double = 5
//    private var isRun: Bool = false
//    private var isSuspend: Bool = false
//    
//    private let frontLabel = UILabel()
//    private let behindLabel = UILabel()
//
//    var font = UIFont.systemFont(ofSize: 13) {
//        didSet {
//            frontLabel.font = font
//            behindLabel.font = font
//        }
//    }
//    
//    var color = UIColor.black {
//        didSet {
//            frontLabel.textColor = color
//            behindLabel.textColor = color
//        }
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.clipsToBounds = true
//        
//        frontLabel.font = font
//        behindLabel.font = font
//        
//        frontLabel.textColor = color
//        behindLabel.textColor = color
//        
//        self.addSubview(frontLabel)
//        self.addSubview(behindLabel)
//        
//    }
//    
//    // MARK: - 开始跑马灯动画
//    func start(){
//        if isRun == false {
//            isRun = true
//            isSuspend = false
//            frontLabel.layer.timeOffset = 0.0
//            behindLabel.layer.timeOffset = 0.0
//            frontLabel.layer.speed = 1.0
//            behindLabel.layer.speed = 1.0
//            frontLabel.layer.beginTime = 0.0
//            behindLabel.layer.beginTime = 0.0
//            marqueeAnimation()
//        }
//    }
//    
//    // MARK: - 停止跑马灯动画
//    func stop() {
//        if isRun {
//            isRun = false
//            frontLabel.layer.removeAnimation(forKey: "frontAnima")
//            behindLabel.layer.removeAnimation(forKey: "behindAnima")
//        }
//    }
//    
//    // MARK: -  暂停动画
//    func suspend() {
//        if isRun && isSuspend == false {
//            isSuspend = true
//            let frontPauseTime = frontLabel.layer.convertTime(CACurrentMediaTime(), from: nil)
//            frontLabel.layer.speed = 0.0
//            frontLabel.layer.timeOffset = frontPauseTime
//            
//            let behindPauseTime = behindLabel.layer.convertTime(CACurrentMediaTime(), from: nil)
//            behindLabel.layer.speed = 0.0
//            behindLabel.layer.timeOffset = behindPauseTime
//            
//        }
//    }
//    
//    // MARK: - 继续动画
//    func continuation() {
//        if isRun && isSuspend {
//            isSuspend = false
//            let frontPauseTime = frontLabel.layer.timeOffset
//            frontLabel.layer.speed = 1.0
//            frontLabel.layer.timeOffset = 0.0
//            frontLabel.layer.beginTime = 0.0
//            let frontTimeSincePause = frontLabel.layer.convertTime(CACurrentMediaTime(), from: nil)  - frontPauseTime
//            frontLabel.layer.beginTime = frontTimeSincePause
//            
//            let behindPauseTime = behindLabel.layer.timeOffset
//            behindLabel.layer.speed = 1.0
//            behindLabel.layer.timeOffset = 0.0
//            behindLabel.layer.beginTime = 0.0
//            let behindTimeSincePause = behindLabel.layer.convertTime(CACurrentMediaTime(), from: nil)  - behindPauseTime
//            behindLabel.layer.beginTime = behindTimeSincePause
//            
//        }
//    }
//    
//    // MARK: - 设置显示文字
//    func setTitle(title: String,textColor:UIColor) {
//        self.stop()
//        
//        frontLabel.text = title
//        frontLabel.sizeToFit()
//        frontLabel.frame.size.width = frontLabel.frame.width + xMargin
//        frontLabel.center.y = self.frame.height / 2
//        frontLabel.frame.origin.x = 0
//        frontLabel.textColor = textColor
//        
//        behindLabel.text = title
//        behindLabel.sizeToFit()
//        behindLabel.frame.size.width = frontLabel.frame.width
//        behindLabel.frame.origin.x = frontLabel.frame.maxX
//        behindLabel.center.y = self.frame.height / 2
//        behindLabel.textColor = textColor
//        
//        if behindLabel.frame.width > self.frame.width {
//            behindLabel.isHidden = false
//            self.start()
//        }
//        else {
//            behindLabel.isHidden = true
//        }
//    }
//    
//    // MARK: - 跑马灯动画实现过程
//    func marqueeAnimation() {
//        let frontAnima = CABasicAnimation()
//        frontAnima.keyPath = "position"
//        frontAnima.fromValue = NSValue(cgPoint: CGPoint(x:  self.frontLabel.frame.width / 2 , y: self.frame.height / 2))
//        frontAnima.toValue = NSValue(cgPoint: CGPoint(x: -1 * self.frontLabel.frame.width / 2, y: self.frame.height / 2))
//        frontAnima.duration = self.time
//        frontAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//        frontAnima.repeatCount = MAXFLOAT
//        
//        let behindAnima = CABasicAnimation()
//        behindAnima.keyPath = "position"
//        behindAnima.fromValue = NSValue(cgPoint: CGPoint(x:  self.frontLabel.frame.width / 2 * 3 , y: self.frame.height / 2))
//        behindAnima.toValue = NSValue(cgPoint: CGPoint(x:  self.frontLabel.frame.width / 2, y: self.frame.height / 2))
//        behindAnima.duration = self.time
//        behindAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//        behindAnima.repeatCount = MAXFLOAT
//        
//        self.frontLabel.layer.add(frontAnima, forKey: "frontAnima")
//        self.behindLabel.layer.add(behindAnima, forKey: "behindAnima")
//    }
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

