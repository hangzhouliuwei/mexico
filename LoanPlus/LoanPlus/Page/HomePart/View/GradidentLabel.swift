//
//  GradidentLabel.swift
//  LoanPlus
//
//  Created by 许广会 on 2024/11/26.
//

import Foundation
import UIKit

class GradientLabel: UILabel {
    
    
    public let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Plazo de préstamo"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(hex: "#224226")
        label.textAlignment = .center
        return label
    }()
    
    // 渐变图层
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {

        
        // 配置渐变图层
        gradientLayer.colors = [
            UIColor(hex: "#7CF9EA")?.cgColor ?? UIColor.white.cgColor,
            UIColor(hex: "#EBF8ED")?.cgColor ?? UIColor.white.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.insertSublayer(gradientLayer, at: 0) // 插入到背景位置

        // 设置圆角
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        // 设置文本样式
       addSubview(subLabel)
        subLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview();
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 更新渐变图层的尺寸
        gradientLayer.frame = self.bounds
        self.layer.cornerRadius = self.height/2
        subLabel.text = self.text;
        subLabel.font = self.font;
        subLabel.textColor = self.textColor
        


    }
}
