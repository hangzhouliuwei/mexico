//
//  ProductDetailCell.swift
//  LoanPlus
//
//  Created by Kiven on 2024/11/26.
//

import UIKit

class ProductDetailCell: UICollectionViewCell {
    
    
    private lazy var stateImg: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var bgImg: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var numImg: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var numLab: UILabel = {
        let numLab = UILabel.create(text: "", textColor: .white, font: .font_pfS(64))
        numLab.textAlignment = .right
        numLab.adjustsFontSizeToFitWidth = true
        numLab.minimumScaleFactor = 0.5
        return numLab
    }()
    
    private lazy var iconImg: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLab: UILabel = {
        let titleLab = UILabel()
        titleLab.numberOfLines = 2
        titleLab.textColor = .white
        titleLab.font = UIFont.systemFont(ofSize: 13)
        titleLab.adjustsFontSizeToFitWidth = true
        titleLab.minimumScaleFactor = 0.5
        return titleLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(bgImg)
        contentView.addSubview(numLab)
        contentView.addSubview(stateImg)
        contentView.addSubview(iconImg)
        contentView.addSubview(titleLab)
        
        bgImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        numImg.snp.makeConstraints { make in
//            make.bottom.right.equalToSuperview().offset(-15)
//            make.size.equalTo(CGSize(width: 69, height: 44))
//        }
        numLab.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().offset(-15)
        }
        stateImg.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        iconImg.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(iconImg.snp.bottom).offset(10)
            make.left.equalTo(iconImg)
            make.right.equalToSuperview().offset(-48)
        }
        
    }
    
    func config(data:JSON,index:Int){
        titleLab.text = data["mKsoYNXaLHQHofdNQlnVFTaLyD"].stringValue
        
        let imgStr = data["jTwkMincjChYmCzvHysZdzzvtWsvCr"].stringValue
        iconImg.kf.setImage(with: URL(string: imgStr))
        
//        numImg.image = UIImage(named: "product_0\(index+1)")
        numLab.text = "0\(index+1)"
        
        let status = data["GygsgiVLIfZfYuWAQe"].boolValue
        bgImg.image = status ? UIImage(named: "product_bg_yes") : UIImage(named: "product_bg_no")
        stateImg.image = status ? UIImage(named: "product_yes") : UIImage(named: "product_no")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        numLab.setGradientText()
    }
}
