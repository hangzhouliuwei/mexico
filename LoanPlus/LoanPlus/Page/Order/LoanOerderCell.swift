//
//  LoanOerderCell.swift
//  LoanPlus
//
//  Created by 许广会 on 2024/12/3.
//

import UIKit
import SnapKit

class LoanOerderCell: UITableViewCell {
    private let productLogo = UIImageView()
    private let titleLabel = UILabel()
    private let amountLabel = UILabel()
    
    private var statusLabel:UILabel?
    
    // 底部信息部分
    private let infoStackView = UIStackView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadTheSubViewWithData(data:JSON) {
        productLogo.kf.setImage(with: URL(string: data["vIpWhjneVpwTdpCtkKiZZvcpkZDPUR"].stringValue))
        titleLabel.text = data["yHCFirltgULKFkAByv"].stringValue
        
        
        amountLabel.text = data["HkWICltBsYJrimOcOQVg"].stringValue
        
        
        for items in infoStackView.arrangedSubviews
        {
            items.removeFromSuperview();
        }
        
        
        
        // 添加每一行信息
        addInfoRow(icon: UIImage(named: "order_4"), title: "Estado del préstamo", value: data["ACxCbolvnPQnuoNMSJrQpIMKxtY"].stringValue, statusIndex: true)
        addInfoRow(icon: UIImage(named: "order_1"), title: "Plazo del préstamo", value: data["cGXniWRnulsuSLNZytR"].stringValue , statusIndex:false)
        addInfoRow(icon: UIImage(named: "order_2"), title: "Tiempo de solicitud", value: data["ZxPemMXbpBXpQEFFC"].stringValue , statusIndex:false)
        addInfoRow(icon: UIImage(named: "order_3"), title: "Fecha del Pago", value: data["SowSporatxtDDD"].stringValue , statusIndex:false)
        
        statusLabel?.textColor = UIColor(hex: data["WpvYdzqjnCndnjXNzogwN"].stringValue)
    }
    // 顶部部分
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    private func setupView() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        let orderBgView = UIView()
        contentView.addSubview(orderBgView)
        orderBgView.snp.makeConstraints { make in
            make.top.equalTo(15);
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(-5)
            
        }
        
        
        
        // 配置卡片背景
        orderBgView.backgroundColor = UIColor(hex: "#3E40C0")
        orderBgView.layer.cornerRadius = 10
        orderBgView.layer.shadowColor = UIColor.black.cgColor
        orderBgView.layer.shadowOpacity = 0.1
        orderBgView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        // 配置顶部视图

        
        productLogo.isUserInteractionEnabled = true
        orderBgView .addSubview(productLogo)

        
        
        
        
        titleLabel.text = "XXXXXX"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor.black
        
        orderBgView.addSubview(titleLabel)
        
        amountLabel.text = "$4010"
        amountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        amountLabel.textColor = UIColor.systemBlue
        
        orderBgView.addSubview(amountLabel)
        
     
        
   
        productLogo.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(12)
            make.size.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(productLogo.snp.right).offset(8)
            make.centerY.equalTo(productLogo)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(productLogo)
        }
        
        // 配置底部信息部分
        infoStackView.axis = .vertical
        infoStackView.spacing = 8
        infoStackView.alignment = .fill
        infoStackView.distribution = .fillProportionally

        
        infoStackView.backgroundColor = UIColor(hex: "#FBFCFF")
        infoStackView.layer.masksToBounds = true
        infoStackView.layer.cornerRadius  = 12
        orderBgView.addSubview(infoStackView)
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(orderBgView.snp.top).offset(38)
            make.left.right.equalToSuperview().inset(0)
            make.height.equalTo(50 * 4)
        }
        orderBgView.snp.makeConstraints { make in
            make.bottom.equalTo(infoStackView.snp.bottom)
        }
        
        
        
        
    }
    
    private func addInfoRow(icon: UIImage?, title: String, value: String, statusIndex:Bool) {
        let row = UIView()
        
        let iconView = UIImageView(image: icon)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor(hex: "#68728A")
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 13)
        valueLabel.textColor = UIColor(hex: "#3251C2")
        valueLabel.textAlignment = .right
        
        row.addSubview(iconView)
        row.addSubview(titleLabel)
        row.addSubview(valueLabel)
        
        if statusIndex {
            statusLabel = valueLabel
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.left.equalTo(18)
            make.width.equalTo(14)
            make.height.equalTo(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(8)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
        infoStackView.addArrangedSubview(row)
    }
    
    
    
}
