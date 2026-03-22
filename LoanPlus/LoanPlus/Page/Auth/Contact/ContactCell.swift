//
//  ContactCell.swift
//  LoanPlus
//
//  Created by Kiven on 2024/12/3.
//

import UIKit

class ContactCell: UITableViewCell {

    var clickBlock:IntBlock?
    var cellData = JSON()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        let showView = UIView()
        showView.backgroundColor = .white
        showView.cornerRadius = 12
        contentView.addSubview(showView)
        showView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        showView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
            make.height.equalTo(21)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = .init(r: 238, g: 240, b: 244)
        showView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(1)
        }
        
        let titleLab1 = UILabel.create(text: "Relación con el contacto", textColor: .textGray, font: .systemFont(ofSize: 13))
        showView.addSubview(titleLab1)
        titleLab1.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(11)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(17)
        }
        
        //MARK: - relationView
        let relationView = UIView()
        relationView.backgroundColor = .bgViewGray
        relationView.cornerRadius = 4
        showView.addSubview(relationView)
        
        let icon1 = UIImageView()
        icon1.image = UIImage(named: "cert_select_icon")
        relationView.addSubview(icon1)
        relationView.addSubview(relationLab)
        
        relationView.snp.makeConstraints { make in
            make.top.equalTo(titleLab1.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(48)
        }
        icon1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        relationLab.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalTo(icon1.snp.left).offset(-12)
        }
        
        let titleLab2 = UILabel.create(text: "Nombre del contacto&Número telefónico del contacto", textColor: .textGray, font: .systemFont(ofSize: 13))
        titleLab2.adjustsFontSizeToFitWidth = true
        titleLab2.minimumScaleFactor = 15
        showView.addSubview(titleLab2)
        titleLab2.snp.makeConstraints { make in
            make.top.equalTo(relationView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(17)
        }
        
        //MARK: - contactView
        let contactView = UIView()
        contactView.backgroundColor = .bgViewGray
        contactView.cornerRadius = 4
        showView.addSubview(contactView)
        
        let icon2 = UIImageView()
        icon2.image = UIImage(named: "cert_ext_icon")
        contactView.addSubview(icon2)
        contactView.addSubview(nameLab)
        contactView.addSubview(phoneLab)
        
        contactView.snp.makeConstraints { make in
            make.top.equalTo(titleLab2.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(48)
        }
        icon2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        nameLab.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalTo(icon1.snp.left).offset(-12)
            make.bottom.equalTo(phoneLab.snp.top)
            make.height.equalTo(phoneLab)
        }
        phoneLab.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalTo(icon1.snp.left).offset(-12)
            make.top.equalTo(nameLab.snp.bottom)
            make.height.equalTo(nameLab)
        }
        
        relationView.addTap {
            if self.clickBlock != nil{
                self.clickBlock!(0)
            }
        }
        
        contactView.addTap {
            if self.clickBlock != nil{
                self.clickBlock!(1)
            }
        }
        
    }
    
    private lazy var titleLab:UILabel = {
        let titleLab = UILabel.create(text: "", textColor: .textBlack, font: .systemFont(ofSize: 16))
        
        return titleLab
    }()
    
    private lazy var relationLab:UILabel = {
        let relationLab = UILabel.create(text: "", textColor: .textBlack, font: .systemFont(ofSize: 13))
        return relationLab
    }()
    
    private lazy var nameLab:UILabel = {
        let nameLab = UILabel.create(text: "", textColor: .textBlack, font: .systemFont(ofSize: 13))
        return nameLab
    }()
    private lazy var phoneLab:UILabel = {
        let phoneLab = UILabel.create(text: "", textColor: .textBlack, font: .systemFont(ofSize: 13))
        return phoneLab
    }()
    
    
    //MARK: - configData
    func configData(json:JSON){
        cellData = json
        titleLab.text = cellData["mKsoYNXaLHQHofdNQlnVFTaLyD"].stringValue
        
        nameLab.text = cellData["IFjTwGIfETpovJDfy"]["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
        phoneLab.text = cellData["IFjTwGIfETpovJDfy"]["weFhdKNVhVVAAczmVVwiHW"].stringValue
        
        let relationValue = cellData["IFjTwGIfETpovJDfy"]["LOfignqbeqvXxKCFguNtcgIcKAwl"].stringValue
        for dic in cellData["LOfignqbeqvXxKCFguNtcgIcKAwl"].arrayValue{
            if dic["MxpNpYKadDRvmjqybUjsIEARDwIwW"].stringValue == relationValue{
                relationLab.text = dic["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
                break
            }
        }
        
    }

}
