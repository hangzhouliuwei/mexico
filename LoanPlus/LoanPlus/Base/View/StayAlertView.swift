//
//  StayAlertView.swift
//  LoanPlus
//
//  Created by Kiven on 2024/11/28.
//

import UIKit

class StayAlertView: UIView {
    
    var sureClick:VoidBlock?

    let contenV = UIView()
    var cancelBtn = UIButton()
    
    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.backgroundColor = .grayHalfColor
        
        contenV.backgroundColor = .white
        contenV.cornerRadius = 16
        addSubview(contenV)
        contenV.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.centerY.equalToSuperview().offset(-40)
            make.height.equalTo(168+76)
        }
        
        let headImg = UIImageView()
        headImg.image = UIImage(named: "alet_headview")
        headImg.contentMode = .scaleAspectFill
        contenV.addSubview(headImg)
        headImg.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(135)
        }
        
        let titleLab = UILabel.create(text: "¿Está seguro/a de que desea salír del certificado?", textColor: .textBlack, font: .fontBold(16))
        titleLab.numberOfLines = 0
        titleLab.textAlignment = .center
        contenV.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
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
        contenV.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        let confirmBtn = UIButton.create(title: "Confirmar",titleColor: .black,font: .fontBold(18))
        confirmBtn.addTarget(self, action: #selector(confirmAlert), for: .touchUpInside)
        confirmBtn.cornerRadius = 25
        confirmBtn.borderColor = UIColor.black
        confirmBtn.borderWidth = 1
        bottomView.addSubview(confirmBtn)
        
        cancelBtn = UIButton.create(title: "Cancelar",titleColor: .white,font: .fontBold(18))
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
        
        let contentLab = UILabel.create(text: "Completar los datos de autorización aumentará la posibilidad de conseguir el préstamo.", textColor: .textBlack, font: .font(14))
        contentLab.numberOfLines = 0
        bottomView.addSubview(contentLab)
        contentLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(confirmBtn.snp.top).offset(-20)
        }
        
        contenV.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animate(withDuration: 0.3) {
            self.contenV.transform = .identity
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelBtn.setGradientText(colors: [UIColor.init(r: 0, g: 181, b: 186),UIColor.init(r: 196, g: 253, b: 126)])
    }
    
    @objc func closeAlert(){
        UIView.animate(withDuration: 0.3) {
            self.contenV.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }completion: { bol in
            self.removeFromSuperview()
        }
    }
    
    @objc func confirmAlert(){
        UIView.animate(withDuration: 0.3) {
            self.contenV.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }completion: { bol in
            self.removeFromSuperview()
            if (self.sureClick != nil) {
                self.sureClick!()
            }
        }
        
    }
    

}
