//
//  BankConfirmView.swift
//  LoanPlus
//
//  Created by Kiven on 2024/12/4.
//

import UIKit

class BankConfirmView: UIView {
    
    var sureClick:VoidBlock?

    let backV = UIView()
    var contiBtn = UIButton()
    
    var types:Int
    var accountStr:String
    
    required init(types:Int,accountStr:String) {
        self.types = types
        self.accountStr = accountStr
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.backgroundColor = .grayHalfColor
        
        backV.backgroundColor = .lightMain
        backV.cornerRadius = 24
        addSubview(backV)
        backV.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(36)
            make.centerY.equalToSuperview()
            make.height.equalTo(240)
        }
        
        let titleLab = UILabel.create(text: types == 0 ? "Confirme que el número de tarjeta bancaria proporcionado sea correcto." : "Confirme que los digitos de la CLABE proporcionada son correctos.", textColor: .init(r: 81, g: 81, b: 81), font: .font_pfS(12))
        titleLab.numberOfLines = 0
        titleLab.textAlignment = .center
        backV.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(59)
            make.left.right.equalToSuperview().inset(19)
            make.height.equalTo(42)
        }
        
        let modiBtn = UIButton.create(title: "Modificar",titleColor: .init(r: 39, g: 71, b: 191),font: .font_pfr(13))
        modiBtn.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
        modiBtn.cornerRadius = 19
        modiBtn.borderColor = .init(r: 39, g: 71, b: 191)
        modiBtn.borderWidth = 1
        backV.addSubview(modiBtn)
        
        contiBtn = UIButton.create(title: "Continuar",titleColor: .white,font: .font_pfr(13))
        contiBtn.addTarget(self, action: #selector(confirmAlert), for: .touchUpInside)
        contiBtn.cornerRadius = 19
        contiBtn.backgroundColor = .black
        backV.addSubview(contiBtn)
        
        modiBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(contiBtn.snp.left).offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(contiBtn.snp.width)
            make.height.equalTo(38)
        }
        contiBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.left.equalTo(modiBtn.snp.right).offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(modiBtn.snp.width)
            make.height.equalTo(38)
        }
        
        let contentLab = UILabel.create(text: accountStr, textColor: .textBlack, font: .font_pfm(20))
        contentLab.textAlignment = .center
        contentLab.adjustsFontSizeToFitWidth = true
        contentLab.minimumScaleFactor = 0.5
        backV.addSubview(contentLab)
        contentLab.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(2)
            make.bottom.equalTo(contiBtn.snp.top).offset(-22)
        }
        
        backV.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animate(withDuration: 0.3) {
            self.backV.transform = .identity
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contiBtn.setGradientText(colors: [UIColor.init(r: 0, g: 181, b: 186),UIColor.init(r: 196, g: 253, b: 126)])
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
