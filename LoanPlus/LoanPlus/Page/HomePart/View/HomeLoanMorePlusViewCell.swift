//
//  HomeLoanMorePlusViewCell.swift
//  LoanPlus
//
//  Created by 许广会 on 2024/11/27.
//

import UIKit
import Kingfisher

class HomeLoanMorePlusViewCell: UITableViewCell {        
        // MARK: - Subviews
        private let customBgView = UIView()
        private let productLogo = UIImageView()

        private let titleLabel = UILabel()
        private let recommendLabel = GradientLabel()
        private let amountLabel = UILabel()
        private let interestRateLabel = UILabel()
        private let motoLabel = UILabel()
        private let tasaLabel = UILabel()
        private let lineView  =  UIView()
    
        private let applicationButton = UIButton(type: .system)
        private let tagsStackView = UIStackView()
    
    func loadTheSubViewWithData(data:JSON) {
        productLogo.kf.setImage(with: URL(string: data["vIpWhjneVpwTdpCtkKiZZvcpkZDPUR"].stringValue))
        titleLabel.text = data["yHCFirltgULKFkAByv"].stringValue
        
        recommendLabel.text = data["gMYutSpTgTcqwfMLeXD"].stringValue
        
        amountLabel.text = data["OnGNMpKrMTODiIJQukjAqi"].stringValue
        interestRateLabel.text = data["RpxpYhfYznvEWVsAqaZ"].stringValue
        applicationButton.setTitle(data["ACxCbolvnPQnuoNMSJrQpIMKxtY"].stringValue, for: .normal)
        applicationButton.backgroundColor = UIColor(hex: data["QwhRWGVXehqzSiuFrwRNQGEt"].stringValue)

        applicationButton.isEnabled = false;
        
        for items in tagsStackView.arrangedSubviews
        {
            items.removeFromSuperview();
        }
            
            
            
        let tags = data["rAlodhSRTNrQXQcixvTsBd"].arrayValue
        for tag in tags {
            let label = UILabel()
            label.text = tag.stringValue
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(hex: "#99A4CD")
            label.backgroundColor = UIColor(hex: "#F4F8FF")
            label.textAlignment = .center
            label.layer.cornerRadius = 11
            label.snp.makeConstraints { make in
                make.height.equalTo(22)
            }
            label.clipsToBounds = true
            tagsStackView.addArrangedSubview(label)
        }

        
        
        
        
    }
    
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupSubviews()
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Setup
        private func setupSubviews() {
            contentView.backgroundColor = .clear
            backgroundColor = .clear
            
            customBgView.backgroundColor = UIColor(hex: "#FBFCFF")
            customBgView.layer.masksToBounds = true
            customBgView.layer.cornerRadius = 12
            contentView.addSubview(customBgView);
            
            productLogo.kf.setImage(with: URL(string: ""))
            
            customBgView.addSubview(productLogo)
            
            // Title Label
            titleLabel.text = "XXXXXX"
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            customBgView.addSubview(titleLabel)
            
            // Recommend Label
            recommendLabel.text = "Recomendar"
            recommendLabel.font = UIFont.systemFont(ofSize: 12,weight: .bold)
            recommendLabel.textColor = .black
            recommendLabel.textAlignment = .center
            recommendLabel.layer.cornerRadius = 8
            recommendLabel.clipsToBounds = true
            customBgView.addSubview(recommendLabel)
            
            // Amount Label
            amountLabel.text = "$20,000"
            amountLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            amountLabel.textColor = UIColor(hex: "#3251C2")
            customBgView.addSubview(amountLabel)
            
            // Interest Rate Label
            interestRateLabel.text = "≥ 0.05%"
            interestRateLabel.font = UIFont.systemFont(ofSize: 16,weight: .bold)
            interestRateLabel.textColor = .black
            customBgView.addSubview(interestRateLabel)
            
          
            motoLabel.textColor = UIColor(hex: "#7E8AB0")
            motoLabel.text = "Monto del préstamo"
            motoLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            customBgView.addSubview(motoLabel)
            
            
            
            tasaLabel.textColor = UIColor(hex: "#7E8AB0")
            tasaLabel.text = "Tasa de Interés"
            tasaLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            customBgView.addSubview(tasaLabel)
            
            
            
            
            // Application Button
            applicationButton.setTitle("Aplicación", for: .normal)
            applicationButton.titleLabel?.font = .fontBold(13)
            applicationButton.setTitleColor(.white, for: .normal)
            applicationButton.backgroundColor = UIColor(hex: "#2747BF")
            applicationButton.layer.cornerRadius = 17
            customBgView.addSubview(applicationButton)
            
            
            
            //line
            lineView.backgroundColor = UIColor(hex: "#EEF0F4")
            customBgView.addSubview(lineView)
            
            // Tags Stack View
            tagsStackView.axis = .horizontal
            tagsStackView.spacing = 10
            tagsStackView.alignment = .fill
            tagsStackView.distribution = .fillProportionally
            customBgView.addSubview(tagsStackView)
            
            
        }
        
        private func setupConstraints() {
            customBgView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(15);
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-5)
                make.bottom.equalTo(tagsStackView.snp.bottom).offset(12)

            }
            
            //logo
            productLogo.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(7);
                make.leading.equalToSuperview().offset(16);
                make.size.equalTo(16)
            }
            
            
            // Title Label
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(productLogo)
                make.leading.equalTo(productLogo.snp.trailing).offset(5)
                make.height.equalTo(21)
                
                
            }
            
            // Recommend Label
            recommendLabel.snp.makeConstraints { make in
                make.top.trailing.equalToSuperview()
                make.width.equalTo(88)
                make.height.equalTo(21)
            }
            
            // Amount Label
            amountLabel.snp.makeConstraints { make in
                make.leading.equalTo(productLogo)
                make.top.equalTo(productLogo.snp.bottom).offset(19)
                make.height.equalTo(26)
                make.width.equalTo(120)
                
            }
            
            // Interest Rate Label
            interestRateLabel.snp.makeConstraints { make in
                make.leading.equalTo(amountLabel.snp.trailing).offset(28)
                make.centerY.equalTo(amountLabel.snp.centerY)
                make.height.equalTo(26)
            }
            
            
            motoLabel.snp.makeConstraints { make in
                make.leading.equalTo(productLogo)
                make.top.equalTo(amountLabel.snp.bottom).offset(4);
                make.height.equalTo(15)
            }
            
            tasaLabel.snp.makeConstraints { make in
                make.leading.equalTo(interestRateLabel);
                make.centerY.equalTo(motoLabel);
                make.height.equalTo(15)
            }
            
            // Application Button
            applicationButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-15)
                make.centerY.equalTo(amountLabel.snp.bottom)
                make.width.equalTo(85)
                make.height.equalTo(34)
            }
            
            
            lineView.snp.makeConstraints { make in
                make.leading.equalTo(productLogo)
                make.trailing.equalTo(applicationButton)
                make.top.equalTo(motoLabel.snp.bottom).offset(5)
                make.height.equalTo(1)
            }
            
            // Tags Stack View
            tagsStackView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.top.equalTo(lineView.snp.bottom).offset(12)
                make.height.equalTo(22)
            }
            
        }
    }

    
    



