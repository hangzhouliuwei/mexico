//
//  LogOutAlertV.swift
//  LoanPlus
//
//  Created by Kiven on 2024/12/4.
//

import UIKit

class LogOutAlertV: UIView {
    
    var sureClick:VoidBlock?

    let backV = UIView()
    var cancelBtn = UIButton()
    
    var type:Int
    
    required init(type:Int) {
        self.type = type
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.backgroundColor = .grayHalfColor
        
        backV.backgroundColor = .clear
        backV.cornerRadius = 16
        addSubview(backV)
        backV.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.centerY.equalToSuperview().offset(-40)
            make.height.equalTo(168+76+45)
        }
        
        let contenV = UIView()
        contenV.backgroundColor = .clear
        contenV.cornerRadius = 16
        backV.addSubview(contenV)
        contenV.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(45)
        }
        
        let topIcon = UIImageView()
        topIcon.image = UIImage(named: "logout_icon")
        backV.addSubview(topIcon)
        topIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 103, height: 89))
        }
        
        let headImg = UIImageView()
        headImg.image = UIImage(named: "alet_headview")
        headImg.contentMode = .scaleAspectFill
        contenV.addSubview(headImg)
        headImg.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(135)
        }
        
        let titleLab = UILabel.create(text: self.type == 11 ? "Cerrar sesión" : "Cancelar cuenta", textColor: .textBlack, font: .font_pfS(18))
        titleLab.numberOfLines = 0
        titleLab.textAlignment = .center
        contenV.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.left.right.equalToSuperview().inset(39)
            make.height.equalTo(42)
        }
        
        let closeBtn = UIButton.create()
        closeBtn.setImage(UIImage(named: "alert_close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
        contenV.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        bottomView.cornerRadius = 16
        contenV.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        let confirmBtn = UIButton.create(title: "Confirmar",titleColor: .black,font: .font_pfr(18))
        confirmBtn.addTarget(self, action: #selector(confirmAlert), for: .touchUpInside)
        confirmBtn.cornerRadius = 25
        confirmBtn.borderColor = UIColor.black
        confirmBtn.borderWidth = 1
        bottomView.addSubview(confirmBtn)
        
        cancelBtn = UIButton.create(title: "Continuar",titleColor: .white,font: .font_pfr(18))
        cancelBtn.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
        cancelBtn.cornerRadius = 25
        cancelBtn.backgroundColor = .black
        
        bottomView.addSubview(cancelBtn)
        
        confirmBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(cancelBtn.snp.left).offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(cancelBtn.snp.width)
            make.height.equalTo(50)
        }
        cancelBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.left.equalTo(confirmBtn.snp.right).offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(confirmBtn.snp.width)
            make.height.equalTo(50)
        }
        
        let contentLab = UILabel.create(text: self.type == 11 ? "¿Está seguro/a de cerrar sesión?" : "¿Estás seguro de que deseas cancelar tu cuenta?", textColor: .textBlack, font: .font_pfr(14))
        contentLab.numberOfLines = 0
        contentLab.textAlignment = .center
        bottomView.addSubview(contentLab)
        contentLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(confirmBtn.snp.top)
        }
        
        backV.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animate(withDuration: 0.3) {
            self.backV.transform = .identity
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelBtn.setGradientText(colors: [UIColor.init(r: 0, g: 181, b: 186),UIColor.init(r: 196, g: 253, b: 126)])
    }
    
    @objc func closeAlert(){
        UIView.animate(withDuration: 0.3) {
            self.backV.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }completion: { bol in
            self.removeFromSuperview()
        }
    }
    
    @objc func confirmAlert(){
        UIView.animate(withDuration: 0.3) {
            self.backV.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }completion: { bol in
            self.removeFromSuperview()
            if (self.sureClick != nil) {
                self.sureClick!()
            }
        }
        
    }
    

}
