//
//  CustomButton.swift
//  LoanPlus
//
//  Created by 许广会 on 2024/11/26.
//

import Foundation
import UIKit

class GradientButton: UIButton {
    
    // 渐变图层
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        // 设置背景颜色和圆角
        self.backgroundColor = .black
        self.layer.cornerRadius = 25 // 圆角值，可根据高度调整
        self.clipsToBounds = true
        
        // 添加渐变文字
        setupGradientText()
    }
    
    private func setupGradientText() {
        guard let titleLabel = self.titleLabel else { return }
        
        // 配置文字样式
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textAlignment = .center
        
        // 配置渐变图层
        gradientLayer.colors = [
            UIColor(hex: "#15DADD")?.cgColor ?? UIColor.white.cgColor,
            UIColor(hex: "#779C4F")?.cgColor ?? UIColor.white.cgColor,
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
        
        // 渐变文字显示
        let gradientTextMask = UILabel()
        gradientTextMask.text = self.currentTitle
        gradientTextMask.textColor = .black
        gradientTextMask.font = titleLabel.font
        gradientTextMask.textAlignment = titleLabel.textAlignment
        gradientTextMask.frame = self.bounds
        gradientLayer.mask = gradientTextMask.layer
    }
    
    
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // 更新渐变图层的大小
            gradientLayer.frame = self.bounds
            
            // 创建渐变文字 mask
            if let titleLabel = self.titleLabel {
                gradientLayer.mask = titleLabel.layer
                titleLabel.frame = self.bounds // 确保文字与按钮对齐
            }
        }
}
