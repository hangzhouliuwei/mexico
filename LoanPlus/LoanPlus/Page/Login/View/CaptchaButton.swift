//
//  CaptchaButton.swift
//  LoanPlus
//
//  Created by 刘巍 on 2024/11/27.
//

import UIKit

class CaptchaButton: UIButton {
   
    var timeLength = 60
    var currentTime = 0
    
    var isWorking:Bool = false
    
    var start = ""
    var prefix = ""
    
    var clickBtnEvent: (() -> Void)?
    
    lazy var timeLayer: CATextLayer = {
        let l = CATextLayer()
        l.alignmentMode = CATextLayerAlignmentMode.center
        l.font = UIFont.systemFont(ofSize: 13.0)
        l.fontSize = 13
        l.foregroundColor = UIColor(hex:"#B1B9C9")?.cgColor
        l.contentsScale = 2
        return l
    }()
    
    var timer: Timer?
    
    func setup(_ startTitle: String?,timeTitlePrefix: String?,aTimeLength:Int?) {
        layer.addSublayer(timeLayer)
        if startTitle != nil {
            start = startTitle!
        }
        if timeTitlePrefix != nil {
            prefix = timeTitlePrefix!
        }
        if aTimeLength != nil{
            timeLength = aTimeLength!
        }
        restore()
        self.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        timeLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 18)
        timeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        
    }
    
    @objc func clockEvent() {
        update()
        if currentTime <= 0 {
            restore()
        }
        currentTime -= 1
    }
    
    @objc fileprivate func update() {
        timeLayer.string = prefix + "\(currentTime)s"
        timeLayer.foregroundColor = UIColor(hex:"#B1B9C9")?.cgColor
    }
    
    @objc fileprivate func restore() {
        isWorking = false
        currentTime = timeLength
        timeLayer.string = start
        timeLayer.foregroundColor = UIColor(hex:"#2747BF")?.cgColor
        timerChangeStatus(false)
        self.isSelected = false
    }
    
    
    @objc func clickBtn(_ sender: CaptchaButton) {
        sender.isSelected = true
        timerChangeStatus(true)
        if clickBtnEvent != nil {
            clickBtnEvent!()
        }
    }
    
    @objc fileprivate func timerChangeStatus(_ fire: Bool) {
        if fire {
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(clockEvent), userInfo: nil, repeats: true)
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
   
}
