//
//  SelectCell.swift
//  LoanPlus
//
//  Created by Kiven on 2024/12/2.
//

import UIKit

class SelectCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = .clear
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(5)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        bgView.addSubview(lab)
        lab.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(2)
            make.top.bottom.equalToSuperview()
        }
        
    }
    
    private lazy var bgView:UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        bgView.layer.masksToBounds = true
        bgView.cornerRadius = 12
        bgView.borderColor = UIColor(r: 39, g: 71, b: 191)
        bgView.borderWidth = 0
        return bgView
    }()
    
    private lazy var lab:UILabel = {
        let lab = UILabel.create(text: "", textColor: .textBlack, font: .font(13))
        lab.textAlignment = .center
        return lab
    }()
    
    func configJson(json:JSON,isSelected:Bool){
        let value = json["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
        lab.text = value
        lab.textColor = isSelected ? .textBlack : .textGray
        lab.font = isSelected ? .fontBold(13) : .font(13)
        bgView.borderWidth = isSelected ? 2 : 0
    }
}
